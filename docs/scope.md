# HAPTIC.SKIN — Project Scope

> Source of truth for the prototype definition. If you're looking for who
> does what, see [`espaces.md`](espaces.md).

## Minimum Viable Prototype (v1 — livré en juillet 2026)

Le prototype minimal à produire :

- **1 collier** avec **8 moteurs ERM** répartis sur 8 directions cardinales
- **1 controller box** (Pico + PCA9685 + ULN2803A) reliée par câble USB
  au PC hôte
- **1 dongle GPS USB** (u-blox NEO-6M) côté PC, en `/dev/ttyACM1`
- **Démon Python** asyncio + CLI `street-nav` + librairie `haptic-skin`
  installable via `pip`
- **1 scénario de démo** live pour la soutenance — navigation haptique uniquement
- **Code + schémas + doc open-source** sur GitHub

### Ce que le MVP **n'est pas** (décisions 2026-05-18)

- **Pas de bracelets** — collier seul
- **Pas d'IMU** — heading = GPS course-over-ground
- **Pas de reconnaissance gestuelle** — pas d'input utilisateur sur le wearable
- Pas un dispositif médical (pas de revendication MDR)
- Pas un produit grand public (pas de packaging, pas de certif CE)
- Pas de sans fil — câblé USB, v2 stretch goal
- Pas d'autre démo que la navigation

## Objectifs principaux

1. **Définir le prototype minimal à produire** — voir section ci-dessus.
2. **API open-source** — docs hébergées sur GitHub Pages (issue #26) +
   package publié sur PyPI (issue #27) pour que n'importe qui puisse faire
   `pip install haptic-skin`.
3. **Collier + bracelets fonctionnant ensemble** — pas juste un des deux,
   les trois wearables communiquent en même temps.
4. **Poster final** — deadline 6 juillet 2026 (milestone *Rapport + poster*).

## Clarifications pour le jury

### 1. Positionnement du prototype

HAPTIC.SKIN v1 est une **preuve de concept open-source à moins de 100 €**,
livrée en juillet, avec 1 collier de 8 moteurs + 2 bracelets de 4 moteurs,
câblés en USB. Elle démontre le canal haptique bidirectionnel **sans
prétendre être un produit commercial, médical ou sans fil**.

### 2. Cible

- **Cible primaire** (utilisateurs de la plateforme) : **développeurs,
  makers et étudiants** qui veulent intégrer du retour haptique dans leurs
  apps en une ligne de code (`pip install haptic-skin`), avec une doc
  claire hébergée.
- **Cible pilote secondaire** (validation terrain) : **personnes
  malvoyantes**, pour valider en conditions réelles le cas d'usage
  navigation.

Tout le monde peut contribuer à n'importe quelle partie du code —
l'open-source est un atout central, pas seulement un choix de licence.

### 3. Usages

On livre **un seul usage** (issue #28) :

- 🥇 **Navigation haptique** — l'utilisateur marche, le collier vibre dans
  la direction de la prochaine rue à prendre. 8 moteurs = 8 directions
  cardinales. Intensité qui croît à l'approche du virage. Mains libres,
  yeux libres. Deux modes côté code, tranchés selon la fiabilité au
  mock-defense :
  - **Indoor** (safe, par défaut) : trace GPS pré-enregistrée rejouée,
    parcours d'obstacles en intérieur, volontaire optionnellement les
    yeux bandés. 100 % reproductible.
  - **Outdoor** (wow) : dongle GPS USB (u-blox NEO-6M) ou téléphone
    tethered, marche réelle de 150-200 m autour d'EFREI.

Pas d'autre démo en v1 (musique, notifications spatiales, communication
silencieuse, gaming — explicitement écartés, issues #15/#16/#17 closes).

### 4. Fonctionnement

```
[GPS dongle USB] ──► [Démon Python asyncio] ──► [Routing engine]
                            │
                            │  trame 0xAA [cmd] [XOR]  (USB CDC-ACM)
                            ▼
                       [Raspberry Pi Pico, Rust+Embassy]
                            │  I²C 400 kHz
                            ▼
                       [PCA9685] ──PWM──► [ULN2803A]
                                              │
                                              ▼
                                       [8 moteurs ERM] → 🫨
```

Voie unique descendante (PC → collier). Pas de remontée capteur en v1
(pas d'IMU). Latence cible end-to-end < 200 ms.

## API open-source

- **Documentation hébergée** sur GitHub Pages — `marc-alexis-com.github.io/haptic.skin/`
  (issue [#26](../../issues/26)). Construite avec `mkdocs-material`.
- **Package PyPI** — `haptic-skin` publié sous licence MIT
  (issue [#27](../../issues/27)). Une fois publié :
  ```bash
  pip install haptic-skin
  ```

## Questions ouvertes

Issues GitHub actives :

- [#25 Rôle + attentes du mentor Olivier Girinsky](../../issues/25)
- Source GPS pour la démo navigation (#28) : dongle u-blox USB **ou**
  téléphone tethered **ou** trace rejouée
- Moteur de routing pour #28 : OSRM auto-hébergé **ou** Mapbox Directions
  API **ou** Google Directions API

Résolus : [#23 accès fab lab](../../issues/23) ✅ ·
[#24 budget 150 € validé](../../issues/24) ✅

## Pour aller plus loin

- [`espaces.md`](espaces.md) — organisation en 4 ESPACES (qui fait quoi)
- [`../research-report/main.typ`](../research-report/main.typ) — rapport
  de recherche approfondi (715 lignes, 11 sections)
- [`../research/hardware.md`](../research/hardware.md) — analyse matérielle détaillée
- [`../research/scientific-foundations.md`](../research/scientific-foundations.md) — fondements scientifiques
