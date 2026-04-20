# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# HAPTIC.SKIN — Innovation Project EFREI ING2

## Repository Status
**This is a research & documentation repository, not (yet) a code repository.** The hardware, firmware, and daemon described below are the *target* deliverables; today the repo holds the deep-research dossier that feeds the specifications, the Typst-compiled report, and project-context artifacts (candidature, jury feedback, Notion export). Do not invent source trees (`src/`, `firmware/`, `daemon/`) — they don't exist yet.

## Repository Layout
- `research-report/main.typ` — the compiled deep-research report (French, MDPI template via `splendid-mdpi`). ~715 lines, 11 top-level sections (Introduction, État de l'art, Matériel, Logiciel, Cas d'usage, Marché, Fondements scientifiques, Éco-conception, Projets similaires, Recommandations, Conclusion).
- `research-report/refs.yml` — Hayagriva bibliography consumed by `main.typ`.
- `research-report/images/` — figures embedded in the report (architecture diagrams, etc.).
- `research-report/Rapport Approfondi.pdf` — last committed PDF export. Regenerate when `main.typ` or `refs.yml` changes.
- `hardware-research.md`, `06-scientific-foundations.md`, `research-08-similar-projects.md` — long-form research notes in English/Markdown. These **seed** `main.typ`; the Typst file is the canonical deliverable.
- `research-prompt.md` — the original mega-prompt that orchestrated the parallel research agents. Re-run it (or parts of it) when refreshing a research axis.
- `notion-infos.txt` — raw Notion export of the EFREI *Projets Transverses* practical guide (deadlines, deposit process, Monday/Calendly workflow). Treat as authoritative for program rules.
- `candidature-et-retour-jury.txt` — project deposit confirmation and jury return. Source of truth for what the jury validated and flagged.

## Building the Report
Typst 0.14+ is installed (`/usr/bin/typst`). From `research-report/`:
- `typst compile main.typ` → produces `main.pdf` (overwrite `Rapport Approfondi.pdf` manually if that's the name to ship).
- `typst watch main.typ` → live rebuild while editing.
- The report pulls `@preview/splendid-mdpi:0.1.0` from Typst Universe; first compile needs network access to fetch it.

## Research → Report Workflow
1. Update or add a research axis in the relevant top-level `.md` file (or create a new one).
2. Reflect distilled findings into the matching `== section` inside `research-report/main.typ`.
3. Add any new citations to `refs.yml` (Hayagriva YAML, keyed by short id; cite in Typst with `@key`).
4. Recompile the PDF.

When editing `main.typ`, keep prose in **French** (the report's language) and match the existing tone of the committed sections.

## Core Concept
- **Output**: 16 ERM vibration motors distributed across 3 wearables, driven by PWM via PCA9685 **+ ULN2803A Darlington transistors** (critical: PCA9685 sources only ~10 mA per channel; ERM motors draw 80–100 mA, so direct drive does not work — see `hardware-research.md` and §3 of the report).
- **Input**: IMU sensors (MPU6050) on each bracelet for gesture recognition (raise, tilt, rotate, shake).
- **Controller**: Raspberry Pi Pico (non-W recommended; Pico 2 W as stretch for wireless) connected via USB to host PC.
- **Software**: Python asyncio daemon on Linux exposing a local API, client library with predefined patterns.
- **Vision**: Human-machine fusion / transhumanism — adding a new sensory layer to the body.

## Hardware Architecture
```
[PC / Arch Linux]
    |  USB Serial
[Raspberry Pi Pico]
    |  I2C
[PCA9685 PWM Driver] → [ULN2803A Darlington] → 16x ERM Motors
[MPU6050 IMU x2] ──> gesture input (bracelets only)
```

## Tech Stack (planned)
- **Firmware**: MicroPython or C on Raspberry Pi Pico.
- **Communication**: USB serial (pyserial on host).
- **Daemon**: Python 3 asyncio, runs on Arch Linux.
- **API**: Local socket or REST; one-liner client interface (`haptic('swipe_left', intensity=0.8)`).
- **PCB**: KiCad.
- **Gesture recognition**: threshold-based or lightweight ML on IMU data.

## Budget
Target < 100 EUR total. Current BOM estimate ~63 EUR (see report §3.6).
Pico ~5 € · 16× ERM ~8 € · PCA9685 ~3 € · ULN2803A ~2 € · 2× MPU6050 ~4 € · passives/connectors ~20 € · silicone + 3D print ~40 €.

## Use Cases (prioritized for demo)
Recommended defense demo sequence (from report §10):
1. Music-to-vibration.
2. Blind navigation.
3. Bidirectional silent communication.

Broader use cases: spatial notifications, gesture response, accessibility (visually impaired), gaming/VR, silent inter-wearer comms.

## Team Composition (6 members, assigned April 2026)
- **Marc-Alexis Manso-Peters** (`@marc-alexis-com`) — embedded + project lead.
- **Alexis Jolly** (`@AlexisJOLLY`) — embedded (firmware Pico, PCA9685, ULN2803A, MPU6050, PCB).
- **Yorgo Haykal** (`@yorgo-haykal`) — software (daemon, client lib, IPC, gesture recognition).
- **Lucie Moreau** (handle TBD) — software (daemon, client lib, patterns, integrations).
- **Pierre Heger** (handle TBD) — bio-informatics (body mapping, accessibility, scientific state of the art).
- **Lilou Constantin** (`@lilouconstantin`) — IT for Finance (market, business model, poster, report).

Marc-Alexis and Alexis are symmetric embedded co-workers. Everyone can
contribute to any area — CODEOWNERS only auto-routes review requests,
it does not restrict who can push or approve.

## Team Organization (4 ESPACES)
The team is split into **4 ESPACES**, each with a primary domain but no
hard boundaries:
- 🔧 **ROBOTNICS** (embedded) — Marc-Alexis, Alexis. `firmware/`, `hardware/`.
- 💻 **BOUFFEUR DE CODE** (software) — Yorgo, Lucie. `daemon/`, `client/`, `patterns/`, `examples/`, `tests/`.
- 🧬 **FEUILLE** (bio-informatics) — Pierre. `docs/science/`, `06-scientific-foundations.md`, report §6/§7.
- 💰 **MONEYMAKER** (IT for Finance) — Lilou. `research-report/` §5/§10, poster, planning.

See `docs/espaces.md` for detailed missions per ESPACE and
`docs/scope.md` for the full MVP v1 definition.

## Prototype Scope (v1, July 2026)
The **minimum viable prototype** is: **1 necklace (8 ERM motors) + 2
bracelets (4 motors + 1 MPU6050 IMU each)**, all driven by a single
Raspberry Pi Pico over USB. The 3 wearables run simultaneously. Python
daemon + `haptic-skin` pip package + 3 live demo scenarios + open-source
code/schematics/docs. See `docs/scope.md` for the full definition and
what is explicitly **out of scope** (no medical device, no wireless, no
ML gesture recognition, no custom PCB).

## Key Dates (EFREI Calendar, 2026)
- **Apr 6–10**: team candidacy period.
- **Apr 10**: kick-off.
- **Apr 20**: Focus 1 — state of the art.
- **Apr 27**: Focus 2 — market thinking.
- **May 4**: Focus 3 — product vision + **Challenge Me 1 (mandatory)**.
- **Jun 22**: **Challenge Me 2 (mandatory)**.
- **Jul 2**: mock defense.
- **Jul 3**: **final defense + live demo**.
- **Jul 6**: final report + poster deadline.
- **Jul 16**: Poster Prize.

## Deliverables
Specifications (cahier des charges), working prototype (3 wearables + firmware + daemon + API), technical report, poster, live demo, open-source codebase with documentation.

## Competitive Gap
bHaptics TactSuit (~300–500 €, proprietary, gaming), Teslasuit (enterprise, very expensive), Apple Taptic Engine (closed, phone-only), Meta haptic gloves (R&D). **No open-source, affordable, programmable, bidirectional wearable haptic platform exists.** Haptic-tech market growing 14–16 %/yr toward ~10 B$ by 2028.

## Project Contacts
- EFREI Projets Transverses: `projets.transverses@efrei.fr`
- Mentor: Olivier Girinsky — `olivier.girinsky@efrei.fr`
- Tools: Monday (project tracking), Notion (central page), Calendly (meetings).
