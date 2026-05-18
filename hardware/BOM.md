# BOM finale — HAPTIC.SKIN v1

> Mise à jour 2026-05-18 · Budget validé **150 €** (#24 closed)
> Sourcing mixte EU rapide + AliExpress + local.

## Stratégie en 4 commandes

| # | Commande | Quand | Délai | Sous-total |
|---|---|---|---|---|
| 1A | EU rapide (Mouser / Welectron / Pimoroni) | semaine 1 | 3–5 j | 31,50 € |
| 1B | AliExpress volume | semaine 1 | 14–21 j | 39,60 € |
| 2 | Amazon FR — mécanique | semaine 2 | 2–4 j | 28,00 € |
| 3 | JLCPCB (carrier PCB) | après #2 validé | 5–7 j | 8,00 € |
| | **Total commandes** | | | **107,10 €** |
| | Buffer shipping / douanes | | | 15,00 € |
| | Buffer remplacement / casse / itération | | | 27,90 € |
| | **TOTAL BUDGET** | | | **150,00 €** |

Le découpage permet de **commencer le breadboard #2 dès la semaine 1** sans
attendre la commande AliExpress de 3 semaines.

---

## Commande 1A — EU rapide (~31,50 €)

Suppliers : Mouser, Welectron, Pimoroni, TME. Délai 3–5 j.

| Composant | Qty | Prix u. | Total | Réf / commentaire |
|---|---|---|---|---|
| Raspberry Pi Pico H (headers pré-soudés) | 2 | 6,00 € | 12,00 € | SC0917 — 1 actif + 1 spare ou *picoprobe* |
| PCA9685 16-canaux breakout | 1 | 4,00 € | 4,00 € | clone Adafruit-815, I²C |
| ULN2803A DIP-18 | 4 | 0,50 € | 2,00 € | TI ULN2803APE4 — 2 actifs + 2 spares |
| MPU6050 GY-521 breakout | 1 | 2,50 € | 2,50 € | pour 1er essai breadboard |
| Breadboard 830 points | 2 | 3,00 € | 6,00 € | une pour ROBOTNICS, une pour BOUFFEUR DE CODE |
| Kit jumpers Dupont 65 pcs (M-M / M-F / F-F) | 1 | 3,00 € | 3,00 € | |
| Câble USB-A → micro-B 1 m | 1 | 2,00 € | 2,00 € | pour le Pico |
| **Sous-total 1A** | | | **31,50 €** | |

---

## Commande 1B — AliExpress (~39,60 €)

Délai 14–21 j. **À passer en même temps que 1A** pour que tout arrive avant fin mai.

| Composant | Qty | Prix u. | Total | Recherche AliExpress |
|---|---|---|---|---|
| PCA9685 breakout (spare) | 1 | 2,50 € | 2,50 € | "PCA9685 16-channel module" |
| ULN2803A DIP-18 (spares) | 4 | 0,25 € | 1,00 € | "ULN2803A DIP18" |
| **Moteurs ERM coin 10 mm × 2,7 mm, 3 V, ~12 000 RPM** | **24** | 0,40 € | 9,60 € | "10mm vibration motor 3V coin" — 16 utilisés + 8 spares (rebut ~15 % documenté) |
| MPU6050 GY-521 (spares) | 3 | 1,50 € | 4,50 € | "MPU6050 GY-521" — taux de panne réel |
| **Module GPS USB u-blox NEO-6M (avec antenne)** | **1** | 12,00 € | 12,00 € | "NEO-6M GPS USB module antenna" — pour démo nav |
| Kit JST-PH 2.0 mm (housings + crimps + headers) | 1 | 5,00 € | 5,00 € | "JST-PH 2.0mm kit" |
| Fil silicone 26 AWG, 5 m multicolore | 1 | 3,00 € | 3,00 € | très flexible — idéal câblage wearable |
| Kit gaine thermo assorti | 1 | 2,00 € | 2,00 € | |
| **Sous-total 1B** | | | **39,60 €** | |

---

## Commande 2 — Mécanique / wearable (~28 €)

Amazon FR ou mercerie locale. Délai 2–4 j. À passer en semaine 2 quand on a
validé le breadboard.

| Composant | Qty | Prix | Total | Source |
|---|---|---|---|---|
| Filament TPU flexible 95A, bobine 250 g | 1 | 15,00 € | 15,00 € | Amazon — eSun TPU ou Sunlu TPU |
| Bande néoprène élastique 25 mm × 1 m (noir) | 1 | 5,00 € | 5,00 € | mercerie / Amazon |
| Bande Velcro adhésive 20 mm × 1 m (paire crochet+boucle) | 1 | 3,00 € | 3,00 € | local |
| Sugru (8 sachets) ou mastic silicone | 1 | 5,00 € | 5,00 € | fixation moteurs, encapsulation |
| Filament PLA | — | 0 € | 0 € | partagé fab lab |
| **Sous-total 2** | | | **28,00 €** | |

---

## Commande 3 — PCB carrier JLCPCB (~8 €)

Après validation breadboard #2 (~semaine 4). Délai 5–7 j (DHL Europe).

| Composant | Qty | Prix | Notes |
|---|---|---|---|
| PCB carrier ~50 × 40 mm, 2 couches, HASL, vert, 5 pcs | 1 ordre | 3,00 € | conception KiCad côté #3 |
| Shipping JLCPCB Europe (DHL) | 1 | 5,00 € | |
| **Sous-total 3** | | **8,00 €** | |

KiCad est gratuit. Pas de stencil ni de pâte à braser nécessaires (composants
DIP soudés à la main au fab lab).

---

## Justifications des choix techniques

### Pourquoi Pico **H** et pas Pico nu (-1 €) ?
Headers pré-soudés → on pose le Pico directement sur breadboard sans avoir
à le souder soi-même. Économie de temps en semaine 1, surtout que l'enjeu
critique du projet est l'apprentissage Rust+Embassy, pas le micro-soudage.

### Pourquoi 24 moteurs et pas 16 ?
Taux de rebut documenté ~10–15 % sur les ERM coin AliExpress. Sur 16, on
aura statistiquement 2 défectueux. 8 spares = couverture rebut + casse
manipulation/soudage (les fils du moteur sont fragiles, ils cassent vite).

### Pourquoi 4 MPU6050 ?
La recherche cite *"high failure rate (2-3 bad per batch), drifts within
minutes"* sur les clones GY-521 (voir `research/hardware.md` §2.3).
2 spares minimum, surtout qu'on n'en utilise que 2 (un par bracelet).

### Pas de diode 1N4148 ?
Les ULN2803A intègrent des **diodes de roue libre** internes (broche COM
= rail moteurs). Économie : 16 diodes + 16 perçages PCB + 16 soudures.
Note historique : la ligne `1N4148 flyback diodes` du précédent
`hardware/README.md` est **supprimée** pour cette raison.

### Pourquoi le NEO-6M et pas un autre GPS ?
- **USB direct** → branche dans le PC, pas de niveau logique à adapter, pas de
  câblage UART supplémentaire (chemin critique = simplicité)
- Sort en **NMEA 0183** standard → parser Python trivial (`pyserial-asyncio` +
  `pynmea2`) ou `gpsd`
- Antenne incluse, sensibilité OK pour piéton en rue dégagée (testé pour
  Villejuif, à confirmer sur place — canyon urbain dense moins bien)
- 12 € livré

Alternative écartée : téléphone Android tethered via ADB. Gratuit mais
ajoute des points de panne (batterie, ADB, permission Android, câble USB-C
vers le laptop déjà occupé par le Pico). Le dongle est autonome.

### Pourquoi pas de batterie LiPo en v1 ?
USB suffit. Calcul de conso : USB 2.0 = 500 mA. Firmware cape à 8 moteurs
simultanés à 70 % duty → ~280 mA pic moteurs + 35 mA reste = **~315 mA**.
On reste sous les 500 mA même au pire pattern. LiPo + TP4056 + boost 5 V =
~6 € à ajouter post-soutenance pour la v1.5.

### Pourquoi PCB carrier *après* validation breadboard ?
Si on grave le PCB avant, on a 5 cartes potentiellement à jeter si on
découvre un détail (ex : il faut un condensateur de découplage 10 µF près
de chaque ULN2803A pour absorber les pics de courant moteur). Donc :
**breadboard #2 → perfboard si nécessaire → PCB carrier #3**.

---

## Ce qu'on ne **commande pas**

| Composant écarté | Pourquoi |
|---|---|
| LSM6DS3 (IMU upgrade) | MPU6050 suffit pour détection de gestes par seuils. L'upgrade nécessite réécriture du driver côté firmware → coût en temps > coût en argent |
| ESP32 (alternative MCU) | Pas de besoin Wi-Fi en v1, le Pico est plus simple à débugger |
| Pico 2 (RP2350) | RP2040 largement suffisant, écosystème Embassy plus mature sur RP2040 fin 2026 |
| 1N4148 flyback diodes | ULN2803A intègre des diodes de roue libre |
| Stencil + pâte à braser | Composants DIP, soudure manuelle au fab lab |
| Boîte/sacoche custom du controller box | Boîtier 3D-imprimé au fab lab, pas de coût matière hors PLA déjà dispo |
| Capteur de température (overload moteurs) | Limitation logicielle suffisante en v1 |
| LiPo + TP4056 + boost 5 V | USB suffit pour la démo, batterie = stretch goal v1.5 |

---

## Décisions à valider avant de passer commande

- [ ] **Pico H (avec headers)** vs **Pico nu** (à souder, -2 €) → recommandé : **Pico H**
- [ ] **24 moteurs ERM** (16 + 8 spares) vs 20 (16 + 4) → recommandé : **24**
- [ ] **NEO-6M USB** vs téléphone tethered → recommandé : **NEO-6M**
- [ ] Acheter la **bobine TPU** maintenant vs imprimer en PLA d'abord → recommandé : **TPU dès semaine 2** (confort wearable très différent)

Quand ces 4 décisions sont validées, je peux générer la liste d'achat finale
avec les liens directs (à coller dans le navigateur).
