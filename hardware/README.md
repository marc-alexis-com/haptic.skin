# `hardware/` — schematics, PCB, 3D prints, BOM

All files here are licensed under **CERN-OHL-P v2** (see `LICENSE-HARDWARE`).

> Pour la BOM détaillée et le plan de commande : voir [`BOM.md`](BOM.md).

## L'objet final — description en détail

HAPTIC.SKIN v1 est **un système 2 pièces** : 1 collier + 1 controller box,
reliés par un câble fin. Tout est piloté par un Raspberry Pi Pico (firmware
Rust + Embassy) sur USB depuis le PC hôte. Le PC ingère le GPS USB et
calcule la direction à donner.

```
                    [PC / Arch Linux]
                       │           │
                       │ USB-A     │ USB-A
                       │           │
                       │     ┌─────▼─────────┐
                       │     │ GPS u-blox    │ /dev/ttyACM1
                       │     │ NEO-6M USB    │ NMEA 0183
                       │     └───────────────┘
                       │
                  USB micro-B
                       │
                ┌──────▼────────┐
                │ Controller    │   ← clip ceinture, PLA 60×40×20 mm
                │ box           │     Pico + PCA9685 + ULN2803A
                │               │
                └──────┬────────┘
                JST-PH 9 broches
                       │
                ┌──────▼────────┐
                │   COLLIER     │   ← néoprène 45 cm × 25 mm
                │   8 moteurs   │     8 pods TPU (8 directions cardinales)
                │   ERM 10 mm   │     Velcro à l'arrière du cou
                └───────────────┘
```

### 1 · Le collier (la pièce vedette)

- **Forme** : bande néoprène élastique noire, 45 cm de circonférence,
  25 mm de large. Fermeture Velcro à l'arrière du cou, ajustable de
  35 à 50 cm. Posé comme un tour de cou classique, repose sur les
  clavicules.
- **8 moteurs ERM coin** (10 × 2,7 mm) répartis tous les ~5,5 cm autour du
  cou. Positions (vu du dessus, "12 h" = devant) : **12, 1:30, 3, 4:30, 6,
  7:30, 9, 10:30** — ces 8 positions mappent les 8 directions cardinales
  (N, NE, E, SE, S, SO, O, NO) **dans le référentiel du porteur**.
- Chaque moteur est dans un **pod TPU 3D-imprimé** (12 × 10 × 5 mm), pod
  cousu/collé sur la bande néoprène, ouverture côté peau pour que la
  vibration passe au mieux. Le TPU amortit les harmoniques et empêche le
  moteur de claquer contre la peau.
- **Câblage** : fil silicone 26 AWG (très flexible) passé à l'intérieur
  de la bande néoprène, soudé aux pattes du moteur, sortie unique à
  l'arrière via un **connecteur JST-PH 2.0 mm 9 broches** (8 sorties moteur
  + 1 V+ commun).
- **Poids estimé** : 80–90 g.

### 2 · Le controller box

- **Forme** : boîtier 3D-imprimé PLA, ~60 × 40 × 20 mm, clip ceinture ou
  brassard. Cylindre arrondi pour ne pas accrocher les vêtements.
- **Contenu** :
  - 1 Raspberry Pi Pico H (carte fille montée sur headers femelle)
  - 1 PCB carrier (~50 × 35 mm, 2 couches, JLCPCB) avec :
    - PCA9685 (breakout I²C 16-canaux PWM, on n'utilise que 8)
    - 1× ULN2803A DIP-18 (8 canaux d'amplification — un seul suffit)
    - 2× condensateurs de découplage 100 nF (Pico + PCA9685)
    - 1× condensateur électrolytique 100 µF (rail moteurs)
    - 1× connecteur JST-PH 9 broches (vers le collier)
- **Sorties** :
  - 1 port USB-micro-B vers le PC hôte (alim + données série CDC-ACM)
  - 1 port JST-PH 9p vers le collier
  - 1 LED status RGB ("ready / running / error")
- **Poids estimé** : 45–55 g.

### 3 · Le dongle GPS (côté PC, pas porté)

- **u-blox NEO-6M** en clé USB avec antenne céramique
- Branché directement dans un port USB du laptop
- Apparaît comme `/dev/ttyACM1` sur Linux
- Sort en NMEA 0183 à 1 Hz (sentences GGA, RMC)
- Le daemon Python lit `RMC.course_over_ground` pour le heading utilisateur
- Pour la démo *outdoor* uniquement ; le mode *indoor* rejoue une trace
  GPS pré-enregistrée donc le dongle n'est pas obligatoire

## Architecture électrique

```
[Pico GP4 SDA / GP5 SCL] ──I²C 400 kHz──► PCA9685 (0x40)

[PCA9685 ch 0..7] ──► [ULN2803A in 1..8] ──out──► [8 moteurs collier]
                                            COM ◄── [+5 V USB Vbus]

[Pico VBUS 5 V] ──┬──► PCA9685 V+
                  └──► ULN2803A COM (rail moteurs)
[Pico 3V3]   ─────┴──► PCA9685 VCC logique
[Pico GND]   ─────┴──► GND commun
```

**Budget courant** :
- 4 moteurs simultanés à 70 % duty × 80 mA = **224 mA pic** (cas usuel,
  démo nav : 1-2 moteurs actifs à la fois)
- Cas extrême 8 moteurs simultanés à 70 % duty = **448 mA pic**
- + Pico 25 mA + PCA9685 10 mA = **~485 mA total** (vraiment pire cas)
- USB 2.0 plafond 500 mA → **firmware enforce un cap à 6 moteurs simultanés**
  pour rester à ~360 mA = 72 % de la limite USB

Le firmware (`power_guard.rs`) enforce le plafond en compositionnant les
patterns avec un `max()` après limitation par moteur.

## Comment on le porte

1. Brancher le dongle GPS dans un port USB du PC (optionnel — mode indoor
   possible sans).
2. Lancer le démon : `python -m haptic_skin.daemon` (ou `street-nav <orig> <dest>`).
3. Mettre **le collier** autour du cou, ajuster Velcro pour que les 8 pods
   moteurs touchent la peau sans trop serrer (pas plus serré qu'un collier
   ras du cou classique).
4. Clipper **la controller box** à la ceinture ou la passer en bandoulière.
5. Brancher le câble JST-PH 9p du collier dans la box.
6. Brancher le câble USB micro-B de la box dans le PC.
7. LED passe au vert → tout est prêt.

## Le flow démo *navigation*

Du point de vue de l'utilisateur :

> *Tu mets le collier. Tu tapes une destination dans le terminal. Tu te
> mets à marcher. À 50 m du prochain virage, le moteur du collier dans la
> direction du virage pulse doucement. À 20 m, le pulse devient régulier.
> Au virage, le moteur vibre franchement pendant 800 ms. Tu tournes. Le
> collier redevient silencieux jusqu'à la prochaine direction. À l'arrivée,
> les 8 moteurs s'enchaînent en cercle comme un applaudissement.*

Du point de vue technique :

```
[GPS dongle USB / fixture trace.json]
       │  NMEA 0183 (GGA, RMC) à 1 Hz, donne lat/lon + course-over-ground
       ▼
[Démon Python]
       │  routing : OSRM / Mapbox / Google Directions
       ├──► itinéraire = liste de [step, bearing_absolu, distance]
       │
       │  À chaque tick GPS :
       │   • distance au prochain step
       │   • bearing relatif = step.bearing - user.course_over_ground
       │   • bucket directionnel = round(bearing_relatif / 45°) % 8
       │
       │  Pattern :
       │   • d > 50 m : silence
       │   • 50 > d > 20 m : pulse 200 ms toutes les 2 s sur le bucket
       │   • 20 > d > 5 m  : pulse 200 ms toutes les 800 ms, intensité × 1,5
       │   • d ≤ 5 m       : pulse fort 800 ms (le virage est ici)
       │   • arrived       : balayage circulaire 8 moteurs en 1,5 s
       │   • off-route     : flash arrière 3× (motor 6 h, "demi-tour")
       │
       ▼  trames série binaires 0xAA / 0xBB (XOR)
[Pico Rust+Embassy]
       │  parse → set_pwm(motor_id, intensity_12bit, duration_ms)
       ▼
[PCA9685 → ULN2803A → moteur ERM] → 🫨
```

**Latence cible end-to-end** : < 200 ms entre fix GPS et vibration physique.
Décomposition :
- GPS → daemon : ~50 ms (1 tick à 1 Hz, jitter)
- daemon decision + routing cache : ~30 ms
- daemon → Pico série : ~5 ms (CDC-ACM à 921 600 bauds)
- Pico → PCA9685 I²C : ~1 ms
- PCA9685 → motor startup : ~50 ms (ERM physique)
- **Total ~140 ms** — confortable sous les 200 ms.

## Critical design notes

- **PCA9685 cannot drive ERM motors directly.** It sources ~10 mA / sinks
  ~25 mA per channel; ERM motors draw 80–100 mA at full speed.
  ULN2803A Darlington array is mandatory amplifier.
- **Flyback diodes** : ULN2803A integrates them on its outputs (COM pin =
  motor V+ rail). No separate 1N4148 needed.
- **Power budget**: USB 5 V / 500 mA. Firmware caps at 6 concurrent motors
  at 70 % duty (~360 mA total).
- **ERM rated 3 V driven from 5 V** : firmware caps duty cycle at ~60 %
  to keep average voltage ≈ 3 V (preserves motor lifespan).
- **Heading source** : GPS course-over-ground (NMEA RMC), not IMU. Works
  when user is moving (which is the demo case). When stopped at a
  waypoint, the last known COG is held.
- See `../research/hardware.md` and `../research-report/main.typ` §3 for
  the full rationale.

## Layout

```
hardware/
├── BOM.md                     ← BOM détaillée + plan de commande
├── README.md                  ← ce fichier (architecture + description objet)
├── necklace/
│   ├── pod.stl                ← pod TPU pour 1 moteur (×8 par collier)
│   └── wiring.md
├── controller-box/
│   ├── carrier.kicad_pro      ← PCB carrier Pico + PCA9685 + ULN2803A
│   ├── carrier.kicad_sch
│   ├── carrier.kicad_pcb
│   └── enclosure.stl
└── docs/
    ├── wiring-diagram.png
    └── assembly-guide.md
```

## Tooling

- **KiCad 8+** for schematics and PCB.
- **FreeCAD** or **OpenSCAD** for enclosures (export `.stl` for 3D printing).
- **JLCPCB** for production PCBs (after breadboard validation).
- **Fab lab** (accès confirmé, #23 closed) : fer à souder réglable,
  multimètre, oscilloscope, imprimante 3D PLA + TPU.
