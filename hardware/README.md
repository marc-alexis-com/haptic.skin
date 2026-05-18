# `hardware/` — schematics, PCB, 3D prints, BOM

All files here are licensed under **CERN-OHL-P v2** (see `LICENSE-HARDWARE`).

> Pour la BOM détaillée et le plan de commande : voir [`BOM.md`](BOM.md).

## L'objet final — description en détail

HAPTIC.SKIN v1 est **un système 4 pièces** : 1 collier + 2 bracelets + 1
boîtier de contrôle, reliés par câbles fins. Tout est piloté par un
Raspberry Pi Pico (firmware Rust + Embassy) sur USB depuis le PC hôte.

```
                            [PC / Arch Linux]
                                  │ USB-A
                                  │  ┌────────────────┐
                                  ├──┤ GPS u-blox     │ NMEA via /dev/ttyACM1
                                  │  │ NEO-6M USB     │
                                  │  └────────────────┘
                                  │ USB-micro-B
                          ┌───────▼───────────┐
                          │  Controller box   │
                          │  (clip ceinture)  │
                          │  Pico + PCA9685   │
                          │  + 2× ULN2803A    │
                          └──┬─────┬──────┬───┘
                  JST-PH 9p  │     │ 6p   │ 6p  JST-PH
                ┌────────────┘     │      └────────────┐
                │                  │                   │
        ┌───────▼────────┐  ┌──────▼──────┐   ┌────────▼──────┐
        │   Collier      │  │ Bracelet G  │   │  Bracelet D   │
        │ 8 moteurs ERM  │  │ 4 ERM       │   │  4 ERM        │
        │ (8 directions  │  │ + 1 MPU6050 │   │  + 1 MPU6050  │
        │  cardinales)   │  └─────────────┘   └───────────────┘
        └────────────────┘
```

### 1 · Le collier (la pièce vedette)

- **Forme** : bande néoprène élastique noire, 45 cm de circonférence,
  25 mm de large. Fermeture Velcro à l'arrière du cou, ajustable de 35 à
  50 cm. Posé comme un tour de cou classique, repose sur les clavicules.
- **8 moteurs ERM coin** (10 × 2,7 mm) répartis tous les ~5,5 cm autour du
  cou. Positions (vu du dessus, "12 h" = devant) : **12, 1:30, 3, 4:30, 6,
  7:30, 9, 10:30** — ces 8 positions mappent les 8 directions cardinales
  (N, NE, E, SE, S, SO, O, NO) dans le référentiel du porteur.
- Chaque moteur est dans un **pod TPU 3D-imprimé** (12 × 10 × 5 mm), pod
  cousu/collé sur la bande néoprène, ouverture côté peau pour que la
  vibration passe au mieux. Le TPU amortit les harmoniques et empêche le
  moteur de claquer contre la peau.
- **Câblage** : fil silicone 26 AWG (très flexible) passé à l'intérieur
  de la bande néoprène, soudé aux pattes du moteur, sortie unique à
  l'arrière via un **connecteur JST-PH 2.0 mm 9 broches** (8 sorties moteur
  + 1 V+ commun).
- **Poids estimé** : 80–90 g.

### 2 · Les bracelets (×2)

- **Forme** : bande néoprène 20 mm de large, 15 cm de long, fermeture
  Velcro. Ajustable de 14 à 22 cm de tour de poignet.
- **4 moteurs ERM** répartis tous les 90° autour du poignet (haut, droite,
  bas, gauche du poignet) — renforcement directionnel possible (le moteur
  "droite" du bracelet droit peut pulser pendant un "tourne à droite" du
  collier).
- **1 MPU6050 GY-521** dans un pod TPU dédié sur la face supérieure du
  poignet. Adresse I²C : 0x68 pour le gauche, 0x69 pour le droit (AD0 tied
  high sur l'un, low sur l'autre).
- **Câblage** : 4 fils moteurs + 4 fils I²C/alim (SDA, SCL, 3V3, GND) =
  **8 fils**, sortie via un **JST-PH 2.0 mm 6 broches** (4 moteurs partagent
  un V+ commun, 4 GND séparés + SDA + SCL + 3V3 + GND = on combine en 6
  fils en partageant les masses).
- **Poids estimé** : 25–30 g chacun.

### 3 · Le boîtier de contrôle ("controller box")

- **Forme** : boîtier 3D-imprimé PLA, ~60 × 40 × 20 mm, clip ceinture ou
  brassard. Cylindre arrondi pour ne pas accrocher les vêtements.
- **Contenu** :
  - 1 Raspberry Pi Pico H (carte fille montée sur headers femelle)
  - 1 PCB carrier (~50 × 40 mm, 2 couches, JLCPCB) avec :
    - PCA9685 (DIP-28 ou breakout soldé)
    - 2× ULN2803A DIP-18 (8+8 canaux d'amplification)
    - 4× condensateurs de découplage 100 nF (chaque chip)
    - 2× condensateurs électrolytiques 100 µF (rails moteurs)
    - 3× connecteurs JST-PH (1× 9p collier, 2× 6p bracelets)
- **Sorties** :
  - 1 port USB-micro-B vers le PC hôte (alim + données série)
  - 3 ports JST-PH vers les wearables
  - 1 LED status (RGB ou bicolore, "ready / running / error")
- **Poids estimé** : 45–55 g.

### 4 · Le dongle GPS (côté PC, pas porté)

- u-blox NEO-6M en clé USB avec antenne céramique
- Branché directement dans le laptop, apparaît comme `/dev/ttyACM1`
- Sort en NMEA 0183, parsé par le démon Python (`pynmea2`)
- Pour la démo *outdoor* uniquement ; le mode *indoor* rejoue une trace
  GPS pré-enregistrée donc le dongle n'est pas obligatoire

## Architecture électrique

```
[Pico GP4 SDA / GP5 SCL] ──I²C 400 kHz──┐
                                         ├──► PCA9685 (0x40, 16 canaux PWM)
                                         ├──► MPU6050 bracelet G (0x68)
                                         └──► MPU6050 bracelet D (0x69)

[PCA9685 ch 0..7]  ──► [ULN2803A #1 in 1..8] ──out──► [8 moteurs collier]
[PCA9685 ch 8..15] ──► [ULN2803A #2 in 1..8] ──out──► [4+4 moteurs bracelets]
                                              COM ◄── [+5 V USB Vbus]

[Pico VBUS 5 V] ──┬──► PCA9685 V+
                  └──► ULN2803A COM (rails moteurs)
[Pico 3V3]   ─────┴──► PCA9685 VCC logique + MPU6050 VCC
[Pico GND]   ─────┴──► GND commun partout
```

**Budget courant** :
- 8 moteurs simultanés à 70 % duty × 80 mA = **280 mA pic**
- + Pico 25 mA + PCA9685 10 mA + 2 MPU6050 8 mA = **~325 mA total**
- USB 2.0 plafond 500 mA → **on reste à 65 % de la limite**

Le firmware (`power_guard.rs`) enforce le plafond "max 8 moteurs simultanés"
en compositionnant les patterns avec un `max()` après limitation par moteur.

## Comment on le porte

1. Brancher le dongle GPS dans le PC (optionnel, mode indoor possible sans).
2. Lancer le démon : `python -m haptic_skin.daemon`.
3. Mettre **le collier** autour du cou, ajuster Velcro pour que les 8 pods
   moteurs touchent la peau (pas trop serré).
4. Mettre **les bracelets** aux poignets, le pod IMU sur le dessus.
5. Clipper **la controller box** à la ceinture ou la passer en bandoulière.
6. Brancher les 3 câbles JST-PH dans la box.
7. Brancher le câble USB de la box dans le PC.
8. LED passe au vert → tout est prêt. Lancer la démo : `python street_nav.py`.

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
       │  NMEA 0183 (GGA, RMC) à 1 Hz
       ▼
[Démon Python]
       │  routing : OSRM / Mapbox / Google Directions
       ├──► itinéraire = liste de [step, bearing, distance]
       │
       │  À chaque tick GPS :
       │   • distance au prochain step
       │   • bearing du step relatif au cap utilisateur (depuis IMU collier
       │     ou compass GPS)
       │   • bucket directionnel = round(bearing / 45°) % 8
       │
       │  Pattern :
       │   • d > 50 m : silence
       │   • 50 > d > 20 m : pulse 200 ms toutes les 2 s sur le bucket
       │   • 20 > d > 0 m : pulse 200 ms toutes les 800 ms, intensité × 1,5
       │   • d ~ 0 m : pulse fort 800 ms
       │   • arrived : balayage circulaire 8 moteurs en 1,5 s
       │
       ▼  trames série binaires 0xAA / 0xBB (XOR)
[Pico Rust+Embassy]
       │  parse → set_pwm(motor_id, intensity_12bit)
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
  ULN2803A Darlington arrays are mandatory amplifiers.
- **Flyback diodes** : ULN2803A integrates them on its outputs (COM pin =
  motor V+ rail). No separate 1N4148 needed.
- **Power budget**: USB 5 V / 500 mA. 16 motors at full draw = ~1.3 A >
  limit. Firmware enforces max 8 concurrent motors at 70 % duty.
- **ERM rated 3 V driven from 5 V** : firmware caps duty cycle at ~60 %
  to keep average voltage ≈ 3 V (preserves motor lifespan).
- See `../research/hardware.md` and `../research-report/main.typ` §3 for
  the full rationale.

## Layout

```
hardware/
├── BOM.md                     ← BOM détaillée + plan de commande
├── README.md                  ← ce fichier (architecture + description objet)
├── necklace/
│   ├── necklace.kicad_pro
│   └── enclosure.stl
├── bracelet/
│   ├── bracelet.kicad_pro
│   └── strap_holder.stl
├── controller-box/
│   ├── carrier.kicad_pro      ← PCB Pico + PCA9685 + 2× ULN2803A
│   └── enclosure.stl
└── docs/
    ├── wiring-diagram.png
    └── assembly-guide.md
```

## Tooling

- **KiCad 8+** for schematics and PCB.
- **FreeCAD** or **OpenSCAD** for enclosures (export `.stl` for 3D printing).
- **JLCPCB** for production PCBs (after breadboard validation).
- **Fab lab** (accès confirmé, #23 closed) : fer à souder réglable, multimètre,
  oscilloscope, imprimante 3D PLA + TPU.
