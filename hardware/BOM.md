# BOM finale — HAPTIC.SKIN v1

> Mise à jour 2026-05-18 · Budget validé **150 €** (#24 closed)
> Scope v1 : **collier seul** (8 moteurs), USB-tethered. Pas de bracelets,
> pas d'IMU. Voir décision sur #28.

## Stratégie en 4 commandes

| # | Commande | Quand | Délai | Sous-total |
|---|---|---|---|---|
| 1A | EU rapide (Welectron / Mouser / Pimoroni) | semaine 1 | 3–5 j | 27,50 € |
| 1B | AliExpress volume | semaine 1 | 14–21 j | 26,00 € |
| 2 | Amazon FR — mécanique | semaine 2 | 2–4 j | 25,00 € |
| 3 | JLCPCB (carrier PCB) | après #2 OK | 5–7 j | 8,00 € |
| | **Total commandes** | | | **86,50 €** |
| | Buffer shipping / douanes | | | 13,50 € |
| | Buffer remplacement / casse / itération | | | 50,00 € |
| | **TOTAL BUDGET** | | | **150,00 €** |

Le découpage permet de **commencer le breadboard #2 dès la semaine 1** sans
attendre la commande AliExpress de 3 semaines.

---

## Commande 1A — EU rapide (~27,50 €)

Welectron (Allemagne, livre FR en 3-5 j), Mouser, Pimoroni.

| Composant | Qty | Prix u. | Total | Recherche / réf |
|---|---|---|---|---|
| Raspberry Pi Pico H (headers pré-soudés) | 2 | 6,00 € | 12,00 € | Welectron "Raspberry Pi Pico H" — 1 actif + 1 *picoprobe* (debug SWD) |
| PCA9685 16-canaux breakout I²C | 1 | 4,00 € | 4,00 € | Welectron "PCA9685" ou Adafruit 815 |
| ULN2803A DIP-18 | 2 | 0,50 € | 1,00 € | Mouser "595-ULN2803APE4" — 1 actif + 1 spare |
| Breadboard 830 points | 1 | 3,00 € | 3,00 € | Welectron / TME |
| Kit jumpers Dupont 65 pcs (M-M / M-F / F-F) | 1 | 3,00 € | 3,00 € | |
| Câble USB-A → micro-B 1 m | 1 | 2,00 € | 2,00 € | local ou Welectron |
| Connecteurs JST-PH 2.0 mm 9p (housings + crimps) | 1 lot | 2,50 € | 2,50 € | Welectron |
| **Sous-total 1A** | | | **27,50 €** | |

---

## Commande 1B — AliExpress (~26 €)

Délai 14–21 j. À passer **en même temps que 1A** pour que tout arrive avant fin mai.

| Composant | Qty | Prix u. | Total | Recherche AliExpress |
|---|---|---|---|---|
| Moteurs ERM coin 10 mm × 2,7 mm, 3 V, ~12 000 RPM | 12 | 0,40 € | 4,80 € | "10mm vibration motor 3V coin" — 8 utilisés + 4 spares |
| **Module GPS USB u-blox NEO-6M (avec antenne)** | 1 | 12,00 € | 12,00 € | "NEO-6M GPS USB module antenna" |
| Fil silicone 26 AWG, 5 m multicolore | 1 | 3,00 € | 3,00 € | "silicone wire 26AWG 5m" |
| Kit gaine thermo assortie | 1 | 2,00 € | 2,00 € | "heat shrink tubing kit" |
| ULN2803A DIP-18 (spares supplémentaires) | 2 | 0,25 € | 0,50 € | |
| PCA9685 breakout (spare) | 1 | 2,50 € | 2,50 € | spare clone, ok pour backup |
| Padding wrap (housse de fils tissée) | 1 | 1,20 € | 1,20 € | "expandable braided sleeving 5mm" |
| **Sous-total 1B** | | | **26,00 €** | |

---

## Commande 2 — Mécanique / wearable (~25 €)

Amazon FR ou mercerie locale. Délai 2–4 j. À passer en semaine 2 après
validation du breadboard.

| Composant | Qty | Prix | Total | Source |
|---|---|---|---|---|
| Filament TPU flexible 95A, bobine 250 g | 1 | 14,00 € | 14,00 € | Amazon — eSun TPU 250 g, noir |
| Bande néoprène élastique 25 mm × 1 m (noir) | 1 | 4,00 € | 4,00 € | mercerie / Amazon "bande néoprène 25mm" |
| Bande Velcro adhésive 20 mm × 1 m (paire) | 1 | 3,00 € | 3,00 € | local |
| Sugru (4 sachets) | 1 | 4,00 € | 4,00 € | Amazon — fixation/encapsulation moteurs |
| Filament PLA | — | 0 € | 0 € | partagé fab lab |
| **Sous-total 2** | | | **25,00 €** | |

---

## Commande 3 — PCB carrier JLCPCB (~8 €)

Après validation breadboard #2 (~semaine 4). Délai 5–7 j (DHL Europe).

| Composant | Qty | Prix | Notes |
|---|---|---|---|
| PCB carrier ~50 × 35 mm, 2 couches, HASL, vert, 5 pcs | 1 | 3,00 € | conception KiCad côté #3 |
| Shipping JLCPCB Europe (DHL) | 1 | 5,00 € | |
| **Sous-total 3** | | **8,00 €** | |

KiCad est gratuit. Pas de stencil ni de pâte à braser nécessaires
(composants DIP soudés à la main au fab lab).

---

## Liens / chemins d'achat concrets

### Welectron (DE → FR, payable par CB, ~5 j)
- Page Pico H : `welectron.com` → recherche "Raspberry Pi Pico H"
- Page PCA9685 : `welectron.com` → recherche "PCA9685"
- Page ULN2803A : `welectron.com` → recherche "ULN2803A"
- Page Breadboard / jumpers / JST-PH : disponibles dans la même commande

### Mouser FR (alternative pour les chips DIP, livraison 3 j)
- Pico H : "474-SC0917"
- ULN2803A : "595-ULN2803APE4"

### AliExpress (1 vendeur ≥ 4.8 étoiles, regrouper la commande)
- Moteurs ERM : recherche "10mm vibration motor 3V coin" — pack de 10-20
- NEO-6M USB : recherche "NEO-6M GPS USB" — version **avec antenne** + **avec câble USB intégré**
- Fil silicone : "silicone wire 26AWG 5m 6 colors"
- Heat shrink : "heat shrink tubing kit 280pcs"

### Amazon FR (livraison 2 j prime)
- TPU : recherche "eSun TPU 95A 250g"
- Néoprène : recherche "bande néoprène élastique 25mm"
- Velcro : recherche "velcro adhésif 20mm 1m"
- Sugru : recherche "Sugru pack 4"

### JLCPCB (semaine 4, après #2 validé)
- `jlcpcb.com` → upload Gerber depuis KiCad → quantité 5, finition HASL, couleur vert (par défaut), shipping DHL Europe

---

## Justifications des choix techniques

### Pourquoi pas de bracelets ni d'IMU ?
Décision 2026-05-18 : la démo unique est la **navigation haptique**. Le
heading utilisateur vient du **course-over-ground GPS** (champ COG du
NMEA RMC), qui marche tant que l'utilisateur bouge — ce qui est précisément
le cas dans la démo. Pas besoin d'IMU → pas besoin de bracelets → BOM
allégée de ~22 € et complexité firmware/soft divisée par deux.

### Pourquoi 12 moteurs ERM et pas 8 ?
Taux de rebut documenté ~10-15 % sur les clones AliExpress. 4 spares sur
8 utilisés = couverture rebut + casse manipulation/soudage.

### Pourquoi 2 Pico H ?
Le second Pico sert de **debug probe** (firmware `picoprobe` flashé,
permet SWD + RTT logs sur le Pico cible). Économie d'un Pi Debug Probe
officiel à 12 €.

### Pas de diode 1N4148 ?
ULN2803A intègre les diodes de roue libre internes (broche COM = rail
moteurs).

### Pourquoi le NEO-6M et pas un autre GPS ?
- **USB direct** → branche dans le laptop, aucun câblage électrique
  supplémentaire (chemin critique = simplicité)
- Sort en **NMEA 0183** standard → parser Python trivial (`pyserial-asyncio`
  + `pynmea2`)
- Antenne céramique incluse, sensibilité OK pour piéton en rue dégagée

### Pourquoi pas de batterie LiPo ?
USB suffit. Calcul de conso pire cas (8 moteurs simultanés à 70 % duty) :
~ 280 mA pic. USB 2.0 plafond 500 mA → **56 % de la limite**. Batterie =
stretch goal v1.5 post-soutenance.

### Pourquoi PCB carrier *après* validation breadboard ?
Si on grave le PCB avant, 5 cartes potentiellement à jeter si on découvre
un détail. Donc : **breadboard #2 → perfboard si nécessaire → PCB #3**.

---

## Ce qu'on ne commande pas

| Composant écarté | Pourquoi |
|---|---|
| 2× Bracelets (4 moteurs + 1 MPU6050 chacun) | Pas dans le scope v1 |
| MPU6050 / LSM6DS3 / tout IMU | Heading = GPS course-over-ground |
| 1N4148 flyback diodes | ULN2803A intègre les diodes |
| ESP32 (alternative MCU) | Pas de Wi-Fi, le Pico est plus simple |
| Pico 2 (RP2350) | RP2040 largement suffisant |
| Stencil + pâte à braser | DIP soudés à la main au fab lab |
| LiPo + TP4056 + boost 5 V | USB suffit, batterie en v1.5 |
| Pi Debug Probe officiel (12 €) | Second Pico flashé en *picoprobe* |

---

## Décisions à valider avant de cliquer "commander"

- [ ] **Pico H** (avec headers, +1 € chacun) → recommandé
- [ ] **2× Pico H** (1 cible + 1 picoprobe) → recommandé
- [ ] **12 moteurs ERM** (8 + 4 spares) → recommandé
- [ ] **NEO-6M USB** (dongle autonome) → recommandé
- [ ] **TPU 95A** dès semaine 2 → recommandé

Quand les 5 cases sont cochées : commande Welectron + AliExpress en
parallèle dans l'heure qui suit.
