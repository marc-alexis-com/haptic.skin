# Les 4 ESPACES

Organisation d'équipe par ESPACES. Chaque ESPACE a un domaine principal,
mais **tout le monde peut contribuer partout** — CODEOWNERS ne fait
qu'auto-router les demandes de review.

Pour les priorités et le calendrier : voir le [Project board](https://github.com/users/marc-alexis-com/projects/1)
et les milestones. Pour la scope : voir [`scope.md`](scope.md).

---

## 🔧 ESPACE ROBOTNICS — embedded

**Membres** :
- [Marc-Alexis Manso-Peters](https://github.com/marc-alexis-com)
- [Alexis Jolly](https://github.com/AlexisJOLLY)

**Dossiers** : `firmware/`, `hardware/`, `research/hardware.md`

### Missions (v1 — collier seul, pas de bracelets ni d'IMU)

- **Assemblage électronique** : breadboard → perfboard → PCB JLCPCB carrier
- **Firmware Rust + Embassy** sur Raspberry Pi Pico (voir #5)
- **Driver PCA9685** (PWM I²C, 8 canaux utilisés sur 16) avec fade in/out
  et garde-fou conso (cap 6 moteurs simultanés)
- **Protocole série binaire** USB CDC-ACM (framing 0xAA/0xBB + XOR)
- **Schémas KiCad** du collier (#3) + carrier PCB controller box (#4)
- **Boîtiers 3D** imprimables : pods TPU collier + boîtier PLA controller
  box (#4)
- **Assemblage final** : soudure néoprène + pods + collier + câble JST-PH

### Issues principales

`firmware`, `hardware` dans le [backlog](https://github.com/marc-alexis-com/haptic.skin/issues?q=label%3Afirmware+OR+label%3Ahardware).

### Chemin critique

- [#1 Commander les composants AliExpress](../../issues/1) (2–3 semaines de
  livraison — à passer en semaine 1)
- [#2 Breadboard 1 moteur ERM validé](../../issues/2) (valide la chaîne
  PCA9685 → ULN2803A → moteur + flyback)

---

## 💻 ESPACE BOUFFEUR DE CODE — software

**Membres** :
- [Yorgo Haykal](https://github.com/yorgo-haykal)
- [Lucie Moreau](https://github.com/lucie769)

**Dossiers** : `daemon/`, `client/`, `examples/`, `tests/`

### Missions (v1 — démo navigation unique)

Détail module-par-module dans [`software-spec.md`](software-spec.md).
Résumé :

- **`serial_client.py`** : transport USB CDC-ACM vers le Pico, protocole
  0xAA/0xBB + XOR (à figer avec ROBOTNICS en S2)
- **`gps.py`** : NMEA du dongle u-blox NEO-6M (live `/dev/ttyACM1`) +
  mode replay depuis `trace.json` pour la démo indoor
- **`routing.py`** : client routing (un choix entre OSRM auto-hébergé /
  Mapbox / Google Directions)
- **`nav.py`** : navigation controller — mapping bearing → 8 buckets
  directionnels → moteur correspondant
- **`patterns.py`** : 6 patterns nav (silent, preview, approach, now,
  arrived, off_route)
- **`cli.py` + `examples/`** : commande `street-nav`, `replay_trace.py`,
  `motor_test.py`
- **`fake_pico.py`** : simulateur série pour développer sans hardware
- **Packaging** : `pip install haptic-skin` (PyPI, issue #27) + doc
  mkdocs (#22) + GitHub Pages (#26)

### Issues principales

`daemon`, `client`, `patterns` dans le [backlog](https://github.com/marc-alexis-com/haptic.skin/issues?q=label%3Adaemon+OR+label%3Aclient+OR+label%3Apatterns).

---

## 🧬 ESPACE FEUILLE — bio-informatique

**Membre** :
- [Pierre Heger](https://github.com/hepi1911)

**Dossiers** : `research/scientific-foundations.md`

### Missions — Pierre doit brainstormer + sourcer

- **Seuils de sensation** — quelle amplitude / fréquence vibratoire est
  perceptible sans être désagréable, sur le cou
- **Positionnement des actionneurs** — où placer les 8 moteurs autour du
  cou pour maximiser la résolution spatiale perçue (densité Pacinian,
  two-point discrimination)
- **State of the art scientifique** — finaliser `research/scientific-foundations.md`.
  Sourcer Bolanowski (1988), Van Erp (2005), Israr-Poupyrev (2011 —
  "Tactile Brush"), etc.
- **Patterns directionnels** — différencier "tourne ici" vs "prépare-toi à
  tourner" sans saturer le porteur. Test avec ROBOTNICS dès que le collier
  est physique.
- **Protocole test utilisateur** pour la démo navigation (5–10
  volontaires, parcours indoor, métriques, consentement éclairé)

### Issues principales

- [#18 Finaliser §6 fondements scientifiques](../../issues/18)
- [#19 Protocole test utilisateur navigation aveugle](../../issues/19)

---

## 💰 ESPACE MONEYMAKER — IT for Finance

**Membre** :
- [Lilou Constantin](https://github.com/lilouconstantin)

**Dossiers** : `research/` (notes marché à créer), poster, planning

### Missions

- **Business model** : open-source + kit BOM à vendre ? SaaS patterns ?
  Sponsoring ? SWOT à rédiger comme note dans `research/market.md`
- **Gestion projet** : maintenir Monday, planning Gantt sur 10 semaines,
  suivi des 3 Challenge Me, risk register
- **Budget** : suivi achats (**150 € validés**, BOM 87 €, buffer 63 €),
  devis Welectron / Mouser / AliExpress, **commandes en semaine 1**
  (stratégie 4 commandes — voir `hardware/BOM.md`) — coordonner avec
  ESPACE ROBOTNICS
- **Poster** (deadline 6 juillet) — draft v1, itérations, impression A0
- **Répétitions de la soutenance**

### Issues principales

- [#20 §5 analyse marché + business model](../../issues/20)
- [#21 Draft v1 du poster](../../issues/21)

---

## Comment ça se passe entre les ESPACES ?

- **Review de code** : CODEOWNERS auto-request les reviewers de l'espace
  concerné, mais **n'importe qui peut approuver**.
- **Collaboration critique** ROBOTNICS ↔ BOUFFEUR DE CODE sur le
  **protocole série binaire** — c'est l'interface physique entre les deux
  couches, il faut que les deux côtés se mettent d'accord sur les trames.
- **Stand-up async** le lundi matin sur le canal d'équipe (canal à
  définir — Discord / WhatsApp / Slack). Chacun poste les 3 issues qu'il
  prend pour la semaine.
- **Démo du vendredi** (10 min) : on merge sur `main` tout ce qui marche,
  on lance le démon, on montre les nouveaux patterns.
