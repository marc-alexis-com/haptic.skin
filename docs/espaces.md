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

### Missions

- **Assemblage électronique** : breadboard → perfboard → éventuel PCB JLCPCB
- **Firmware MicroPython / C** sur Raspberry Pi Pico
- **Driver PCA9685** (PWM I²C) avec fade in/out et garde-fou conso
- **Driver MPU6050** (2× capteurs sur un bus I²C, activation DMP)
- **Protocole série binaire** (framing 0xAA/0xBB + XOR, baud 921 600)
- **Schémas KiCad** du collier et des bracelets
- **Boîtiers 3D** imprimables (PLA + TPU)

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
- Lucie Moreau (handle GitHub à venir)

**Dossiers** : `daemon/`, `client/`, `patterns/`, `examples/`, `tests/`

### Missions

- **Couche 3 — Client Python** : API one-liner `haptic('swipe_left', intensity=0.8)`
- **Librairie pip-installable** `haptic-skin` (publication PyPI, issue #27)
- **Couche 2 — Démon asyncio** : parler au Pico via `pyserial` / `aioserial`
  (en **collaboration avec ESPACE ROBOTNICS** pour le protocole binaire)
- **Socket Unix** comme IPC principal (+ WebSocket + REST secondaires)
- **Moteur de patterns** : parser JSON timeline, scheduler 200 Hz,
  composition `max()`
- **Reconnaissance gestuelle** par seuils (Phase 1 MVP)
- **Intégrations** avec des apps externes — exemple : **Google Maps**
  → navigation haptique (issue #28)
- **Simulateur série** pour développer sans Pico plugué

### Issues principales

`daemon`, `client`, `patterns` dans le [backlog](https://github.com/marc-alexis-com/haptic.skin/issues?q=label%3Adaemon+OR+label%3Aclient+OR+label%3Apatterns).

---

## 🧬 ESPACE FEUILLE — bio-informatique

**Membre** :
- [Pierre Heger](https://github.com/hepi1911)

**Dossiers** : `docs/science/`, `research/scientific-foundations.md`,
sections §6 & §7 de `research-report/main.typ`

### Missions — Pierre doit brainstormer + sourcer

- **Seuils de sensation** — quelle amplitude / fréquence vibratoire est
  perceptible sans être désagréable, par zone du corps
- **Positionnement et puissance des actionneurs** — où placer les 16
  moteurs sur le cou et les poignets pour maximiser la résolution spatiale
  perçue (densité Pacinian, two-point discrimination)
- **Rôle et actions possibles de l'outil** — *exploration* : vibrations
  seules, ou aussi **lumières** (LED) ? thermique ? EMS ? (décision v1 à
  valider)
- **State of the art scientifique** — finaliser `research/scientific-foundations.md`
  et §6 du rapport. Sourcer Bolanowski (1988), Van Erp (2005),
  Israr-Poupyrev (2011 — "Tactile Brush"), etc.
- **Protocole test utilisateur** pour le cas d'usage navigation aveugle
  (5–10 volontaires, parcours d'obstacles, métriques, consentement éclairé)

### Issues principales

- [#18 Finaliser §6 fondements scientifiques](../../issues/18)
- [#19 Protocole test utilisateur navigation aveugle](../../issues/19)

---

## 💰 ESPACE MONEYMAKER — IT for Finance

**Membre** :
- [Lilou Constantin](https://github.com/lilouconstantin)

**Dossiers** : `research-report/` (§5 marché, §10 recommandations),
poster, planning

### Missions

- **Business model** : open-source + kit BOM à vendre ? SaaS patterns ?
  Sponsoring ? SWOT complet dans §5 du rapport
- **Gestion projet** : maintenir Monday, planning Gantt sur 10 semaines,
  suivi des 3 Challenge Me, risk register
- **Budget** : suivi achats (cible 63 € BOM, marge 37 € pour itération),
  devis AliExpress / Mouser, **commandes en semaine 1** (2–3 semaines de
  livraison = chemin critique — coordonner avec ESPACE ROBOTNICS)
- **Poster** (deadline 6 juillet) — draft v1, itérations, impression A0
- **Coordination rapport final** en Typst + répétitions de la soutenance

### Issues principales

- [#20 §5 analyse marché + business model](../../issues/20)
- [#21 Draft v1 du poster](../../issues/21)
- [#24 Qui paye la commande AliExpress ?](../../issues/24) — à résoudre
  en tout premier

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
