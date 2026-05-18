# HAPTIC.SKIN — Project Scope

> Source of truth for the prototype definition. If you're looking for who
> does what, see [`espaces.md`](espaces.md).

## Minimum Viable Prototype (v1 — livré en juillet 2026)

Le prototype minimal à produire :

- **1 collier** avec **8 moteurs ERM** répartis sur 8 directions cardinales
- **2 bracelets**, chacun avec **4 moteurs ERM** + **1 IMU MPU6050**
- **Communication simultanée** entre le collier et les 2 bracelets — les 3
  wearables fonctionnent ensemble en temps réel, pilotés par un unique
  Raspberry Pi Pico connecté en USB au PC hôte
- **Démon Python** asyncio + **API one-liner** + **librairie `haptic-skin`**
  installable via `pip`
- **3 scénarios de démo** live pour la soutenance (voir §Usages)
- **Code + schémas + doc open-source** sur GitHub

### Ce que le MVP **n'est pas**

- Pas un dispositif médical (pas de revendication MDR)
- Pas un produit grand public (pas de packaging, pas de certif CE)
- Pas de sans fil — câblé USB, v2 stretch goal
- Pas de reconnaissance gestuelle par ML — seuils seulement en v1
- Pas de PCB custom — perfboard + boîtiers 3D

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

On se concentre sur **un seul usage principal** (livrable #1, issue #28) :

- 🥇 **Navigation haptique style Google Maps** — l'utilisateur marche dans
  la rue avec son téléphone (ou un dongle GPS USB), et le collier vibre
  dans la direction de la prochaine rue à prendre. 8 moteurs = 8 directions
  cardinales. Intensité qui croît à l'approche du virage. Mains libres,
  yeux libres. Démo soutenance en mode *indoor* (trace GPS rejouée,
  reproductible) avec passerelle vers une démo *outdoor* si fiabilité OK.
  La variante "yeux bandés / parcours d'obstacles" reste valide comme cas
  spécifique (issue #15).

Démonstrateurs courts conservés comme `examples/` mais **rétrogradés en
stretch** (priorité P3-nice, on les fait *si* il reste du temps) :

- **Notifications spatiales silencieuses** avec réponse par geste
  (issue #16) — montre la bidirectionnalité.
- **Musique → vibration** (issue #17) — accroche émotionnelle 30 s.

### 4. Fonctionnement

```
[App utilisateur]
      │  haptic('swipe_left', intensity=0.8)
      ▼
[Client Python] ──Unix socket──► [Démon asyncio]
                                      │  trame 0xAA [cmd] [XOR]
                                      ▼    (USB série 921 600 bauds)
                                 [Raspberry Pi Pico]
                                      │  I²C 400 kHz
                                      ▼
                              [PCA9685] ──PWM──► [ULN2803A]
                                                      │
                                                      ▼
                                              [16 moteurs ERM] → 🫨
```

Sens montant : les 2 **MPU6050** des bracelets remontent leurs données via
I²C → Pico → série → démon → événement `gesture(...)` → callback dans le
programme utilisateur. Latence totale < 20 ms.

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
