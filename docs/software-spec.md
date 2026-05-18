# Spec software — HAPTIC.SKIN v1

> Mise à jour 2026-05-18 · Scope v1 = **navigation haptique unique** sur
> collier seul (8 moteurs ERM). Pas d'IMU, pas de bracelets.

## Qui fait quoi

| Espace | Membres | Langage | Responsabilité |
|---|---|---|---|
| **🔧 ROBOTNICS** | Marc-Alexis, Alexis | Rust + Embassy | Firmware Pico, hardware, assemblage |
| **💻 BOUFFEUR DE CODE** | Yorgo, Lucie | Python | Daemon, GPS, routing, navigation controller, CLI |
| **🧬 FEUILLE** | Pierre | — | Patterns directionnels, protocole test utilisateur |
| **💰 MONEYMAKER** | Lilou | — | Marché, poster, rapport, planning |

L'interface entre ROBOTNICS et BOUFFEUR DE CODE = **le protocole série
binaire** (issue #8). C'est le point de contact à verrouiller en
semaine 2 : tant qu'il n'est pas figé, ni le firmware ni le daemon ne
peuvent avancer indépendamment.

---

## Partie ROBOTNICS — firmware Rust + Embassy (côté Pico)

Le firmware tourne sur le Pico. C'est un seul binaire `firmware.uf2` qui :

1. Initialise l'USB CDC-ACM (le Pico apparaît en `/dev/ttyACM0`)
2. Initialise l'I²C0 (SDA = GP4, SCL = GP5) à 400 kHz
3. Initialise le PCA9685 (PWM à ~200 Hz, pour ERM)
4. Boucle async :
   - Lit les trames série entrantes (`0xAA [cmd] [len] [payload] [XOR]`)
   - Dispatche : `set_motor(id, intensity, duration_ms)`, `stop_all()`, `ping`
   - Applique l'intensité au PCA9685 (12-bit, 0–4095)
   - Envoie un `pong` sur ping (heartbeat pour le daemon)
   - LED status (vert = idle, bleu = running, rouge = error)

### Modules Rust à écrire

```
firmware/src/
├── main.rs                ← #[embassy_executor::main]
├── config.rs              ← pins, PWM_FREQ, BAUD, MOTOR_MAP
├── drivers/
│   ├── pca9685.rs         ← async I²C, set_pwm(ch, on, off)
│   └── status_led.rs      ← RGB ou bicolore
├── proto.rs               ← framing 0xAA/0xBB + XOR + parse_frame()
├── usb_serial.rs          ← embassy-usb CDC-ACM task
├── motor_scheduler.rs     ← table d'intensité par moteur + duration timer
└── power_guard.rs         ← cap 6 moteurs simultanés
```

### Issues ROBOTNICS ouvertes

- #1 Commander les composants (voir `hardware/BOM.md`)
- #2 Breadboard 1 moteur ERM piloté
- #3 Schéma KiCad collier
- #4 Boîtiers 3D (collier + controller box)
- #5 Setup Rust + Embassy + flash initial du Pico
- #6 Driver Rust PCA9685 (embedded-hal)
- #8 Protocole série binaire 0xAA/0xBB + XOR

---

## Partie BOUFFEUR DE CODE — daemon Python (côté PC)

Le daemon tourne sur le laptop. Il fait **5 choses** :

### Module 1 — Transport série vers le Pico
**Fichier** : `daemon/src/haptic_skin/serial_client.py`

- Ouvre `/dev/ttyACM0`, baud 921 600 (en pratique non significatif sur USB CDC)
- `pyserial-asyncio` pour ne pas bloquer l'event loop
- Implémente le protocole `0xAA/0xBB + XOR` (cf. #8, owner ROBOTNICS,
  spec à figer ensemble)
- API : `await client.set_motor(id: int, intensity: float, duration_ms: int)`
- Auto-reconnect si le Pico est débranché (issue #9)
- **Simulateur** `fake_pico.py` (issue : à créer) qui mime le Pico sans
  hardware, pour développer offline

### Module 2 — Source GPS
**Fichier** : `daemon/src/haptic_skin/gps.py`

- Mode **live** : lit `/dev/ttyACM1` (le NEO-6M), parse NMEA avec `pynmea2`
- Mode **replay** : lit `trace.json` (liste d'événements `{t, lat, lon, cog, speed}`)
  rejoués à la vitesse réelle
- Yield un `GpsFix(lat, lon, cog, speed, timestamp)` à chaque tick (1 Hz)
- Sentinelles `NoFix` si le GPS perd le signal

### Module 3 — Routing
**Fichier** : `daemon/src/haptic_skin/routing.py`

- API : `route(origin: LatLon, destination: LatLon) -> Route`
- 3 backends interchangeables, choisis par variable d'env :
  - `osrm` : auto-hébergé local, gratuit, contrôle total, plus lourd à
    installer (image Docker `osrm/osrm-backend`)
  - `mapbox` : free tier 100 000 requêtes/mois, API stable, clé en .env
  - `google` : Directions API, free tier 200 $/mois, plus précis en France
- `Route` = liste de `RouteStep(lat, lon, bearing_abs, distance_m, instruction)`
- Cache la route une fois calculée (pas de recompute en cours de marche v1)

### Module 4 — Navigation controller
**Fichier** : `daemon/src/haptic_skin/nav.py`

C'est le cœur. À chaque `GpsFix` :

1. Trouve le prochain `RouteStep` non encore franchi
2. Calcule la distance haversine `d` entre user et step
3. Calcule le bearing relatif : `step.bearing_abs - fix.cog`, normalisé
   sur [-180°, +180°]
4. Map bearing relatif → bucket directionnel sur 8 :
   `bucket = round((bearing_rel + 360) / 45) % 8`
   (bucket 0 = devant, 2 = droite, 4 = derrière, 6 = gauche)
5. Choisit le pattern selon `d` :
   - `d > 50 m` : silence
   - `50 ≥ d > 20 m` : `preview(bucket)`
   - `20 ≥ d > 5 m` : `approach(bucket)`
   - `d ≤ 5 m` : `now(bucket)` puis incrément step
6. Si tous les steps faits : `arrived()`
7. Si user ne suit plus la route (off-route > 30 m) : `off_route()`

### Module 5 — Patterns + scheduler
**Fichier** : `daemon/src/haptic_skin/patterns.py`

Bibliothèque de patterns directionnels — **ce sont les seuls patterns
nécessaires pour la démo nav** :

| Pattern | Effet |
|---|---|
| `silent()` | rien |
| `preview(bucket)` | pulse 200 ms sur 1 moteur, intensité 40 %, toutes les 2 s |
| `approach(bucket)` | pulse 200 ms sur 1 moteur, intensité 70 %, toutes les 800 ms |
| `now(bucket)` | pulse 800 ms sur 1 moteur, intensité 100 % |
| `arrived()` | balayage des 8 moteurs en cercle, 1,5 s, intensité 80 % |
| `off_route()` | flash 3× sur le moteur "derrière" (bucket 4), 100 % |

Scheduler interne tick à 50 Hz (suffisant pour les transitions de pulse).

### Module 6 — CLI / examples
**Fichier** : `daemon/src/haptic_skin/cli.py` + `examples/`

- `street-nav <adresse_origine> <adresse_destination>` : lance le daemon
  en mode live, route avec le backend par défaut, démarre la navigation
- `examples/replay_trace.py trace.json` : mode indoor pour la démo soutenance
- `examples/motor_test.py [N]` : pulse séquentiellement les 8 moteurs
  pour valider le câblage

### Module 7 — Packaging
**Fichier** : `client/pyproject.toml`

- Package `haptic-skin` publiable sur PyPI (issue #27)
- `pip install haptic-skin` expose la commande `street-nav` et l'API
  Python : `from haptic_skin import haptic; haptic('turn_left', 0.8)`

### Issues BOUFFEUR DE CODE ouvertes

- #9 Daemon asyncio + connexion série auto-reconnect
- #10 Pattern engine (à narrower aux 6 patterns nav)
- #11 IPC Unix socket (optionnel v1, plus orienté open-source platform)
- #13 Package pip `haptic-skin`
- #14 Bibliothèque de patterns (réduite à 6 nav patterns)
- #19 Protocole test utilisateur navigation (en lien avec FEUILLE)
- #22 Setup mkdocs
- #26 Doc API GitHub Pages
- #27 PyPI publish
- #28 **Demo navigation** (umbrella issue)

---

## Layout final du repo

```
firmware/                    ← ROBOTNICS (Rust)
├── Cargo.toml
├── memory.x
└── src/
    ├── main.rs
    ├── drivers/pca9685.rs
    ├── proto.rs
    └── …

daemon/                      ← BOUFFEUR DE CODE (Python)
├── pyproject.toml
└── src/haptic_skin/
    ├── daemon.py
    ├── serial_client.py
    ├── gps.py
    ├── routing.py
    ├── nav.py
    ├── patterns.py
    └── cli.py

client/                      ← BOUFFEUR DE CODE (Python, publié PyPI)
└── src/haptic_skin/
    └── __init__.py          ← `from haptic_skin import haptic`

examples/
├── street_nav.py            ← démo live
├── replay_trace.py          ← démo indoor
└── motor_test.py

tests/
├── fake_pico.py
├── trace_efrei_villejuif.json
├── test_nav.py
└── test_protocol.py

hardware/                    ← ROBOTNICS
├── BOM.md
├── README.md
├── necklace/pod.stl
└── controller-box/
    ├── carrier.kicad_*
    └── enclosure.stl
```

---

## Planning grossier (10 semaines)

| Semaine | ROBOTNICS | BOUFFEUR DE CODE |
|---|---|---|
| S1 | Commander composants, setup toolchain Rust+Embassy | Setup repo Python, `fake_pico.py`, scaffolding modules |
| S2 | Breadboard #2 (1 moteur), proto série figé avec SE | `serial_client.py`, `gps.py` (replay mode), squelette `nav.py` |
| S3 | Driver PCA9685, 8 moteurs sur breadboard, KiCad collier | `routing.py` (choix backend), `nav.py` complet |
| S4 | Soudure néoprène + pods TPU, PCB lancé JLCPCB | `patterns.py`, intégration `daemon.py` end-to-end |
| S5 | Reception PCB, assemblage controller box, premier test bout-en-bout | Tests intégration `fake_pico` ↔ `street_nav.py`, mode replay marche |
| S6 | Stress test 8 moteurs, ajustement patterns physiques | Mode live avec NEO-6M, debug latence |
| S7 | Itérations confort collier, fab lab | Polish CLI, doc, mkdocs |
| S8 | Pré-mock defense interne | Pré-mock defense interne |
| S9 | Mock defense (2 juillet) | Mock defense |
| S10 | **Soutenance 3 juillet** | **Soutenance 3 juillet** |

---

## Décisions à trancher tout de suite

1. **Quel backend de routing ?** OSRM auto-hébergé / Mapbox / Google Directions ?
   - OSRM : gratuit, contrôle, lourd à installer
   - Mapbox : 100k req/mois gratuit, simple, dépendance externe
   - Google : 200 $/mois gratuit, plus précis FR, dépendance externe
2. **Source GPS de démo soutenance** : outdoor avec NEO-6M / indoor avec
   `trace.json` rejoué ? Le code doit gérer les deux mais le choix final
   se fait au mock defense.
3. **IPC Unix socket (issue #11)** : on garde dans le scope v1 ou on
   reporte ? Pour la démo nav, pas strictement nécessaire (un seul process).
   Recommandation : reporter post-soutenance.
