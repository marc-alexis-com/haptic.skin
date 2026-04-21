# HAPTIC.SKIN

> Open-source bidirectional haptic wearable platform.
> One necklace + two bracelets, 16 vibration motors, gesture input, < 100 € BOM.

![status](https://img.shields.io/badge/status-prototype_in_progress-orange)
![license](https://img.shields.io/badge/code-MIT-blue)
![hardware](https://img.shields.io/badge/hardware-CERN--OHL--P_v2-green)
![docs](https://img.shields.io/badge/docs-CC--BY--SA_4.0-lightgrey)

HAPTIC.SKIN adds a new sensory layer to the body. A user receives information
through spatialized vibrations on the neck and wrists, and responds through
gestures captured by inertial sensors — no screen, no sound. Any Python program
can trigger a haptic pattern in one line of code:

```python
from haptic_skin import haptic

haptic('swipe_left', intensity=0.8)
haptic('heartbeat', repeat=3, interval_ms=800)
```

This is an **EFREI Paris ING2 Innovation Project (2025-2026)**. A working
prototype, complete open-source codebase, KiCad schematics, 3D-printable
enclosures and a documented API will be released by **July 2026**.

---

## Why

The two dominant human-machine channels — sight and hearing — are saturated
with screens, notifications and alerts. Touch, our most intuitive sense,
stays limited to generic phone vibration. Commercial haptic wearables
(bHaptics, Teslasuit) are closed, expensive and gaming-focused.
**No affordable, open-source, bidirectional haptic wearable platform exists.**

HAPTIC.SKIN fills that gap:

| | bHaptics TactSuit | Teslasuit | **HAPTIC.SKIN v1** |
|---|---|---|---|
| Price | 250–500 € | 20 000 € | **< 100 €** |
| Open-source | ❌ | ❌ | **✅** |
| Bidirectional | ❌ | ✅ | **✅** |
| Target | Gamers | Enterprise | **Developers, makers, accessibility** |

## What's in the prototype (v1, July 2026)

- **Hardware**: 1 necklace (8 ERM motors) + 1 bracelet (4 motors + MPU6050 IMU),
  USB-powered, driven by a Raspberry Pi Pico.
- **Firmware**: MicroPython on the Pico, PCA9685 + ULN2803A chain to drive
  the motors, binary serial protocol.
- **Daemon**: Python asyncio, pattern sequencer at 200 Hz, local Unix socket
  API, threshold-based gesture recognition.
- **Client library**: `pip install haptic-skin`, one-liner API,
  15+ built-in patterns.
- **Three live demo scenarios**: blind navigation, silent spatial
  notifications, music-to-vibration.

### Explicitly out of scope for v1

Not a medical device, not a consumer product, no wireless, no ML gesture
classification, no custom PCB — see `research-report/` for the full scoping
rationale.

## Architecture

```
┌─────────────────────────────────────────────┐
│ Client library (pip: haptic-skin)           │
│   haptic('swipe_left', intensity=0.8)       │
├─────────────────────────────────────────────┤
│ Daemon (Python asyncio, PC)                 │
│  • Pattern engine 200 Hz                    │
│  • Serial transport to Pico                 │
│  • Gesture events upstream                  │
│  • IPC: Unix socket + WebSocket + REST      │
├─────────────────────────────────────────────┤
│ Firmware (Raspberry Pi Pico, MicroPython)   │
│  • PCA9685 → ULN2803A → 16× ERM motors      │
│  • MPU6050 IMU (I²C, DMP)                   │
│  • Binary serial protocol                   │
└─────────────────────────────────────────────┘
```

See `docs/architecture.md` for details, or the full research report in
`research-report/`.

## Repository layout

| Path | Content |
|---|---|
| `firmware/` | MicroPython code for the Raspberry Pi Pico |
| `daemon/` | Python asyncio daemon (pattern engine, IPC) |
| `client/` | `haptic-skin` Python package (pip-installable) |
| `patterns/` | JSON library of haptic patterns |
| `hardware/` | KiCad schematics, PCB, BOM, 3D printable enclosures |
| `docs/` | Developer & user documentation (mkdocs) |
| `examples/` | Demo scripts (blind nav, music, silent comms) |
| `website/` | Public website ([haptic.skin](https://haptic.skin)) — auto-deployed on push |
| `tests/` | Unit tests, serial simulator |
| `research-report/` | Typst deep-research report (French) |
| `research/` | Long-form research notes (scientific foundations, hardware, similar projects) |

## Quick start (once prototype exists)

```bash
# Install the client library
pip install haptic-skin

# Run the daemon (needs a Pico connected over USB)
python -m haptic_skin.daemon

# Trigger a pattern from any Python program
python -c "from haptic_skin import haptic; haptic('swipe_left')"
```

## Status

**April 2026** — Research phase complete, repository scaffolded, component
ordering in progress. See [open issues](https://github.com/marc-alexis-com/haptic.skin/issues)
and the project board.

## Contributing

See `CONTRIBUTING.md`. Issues labelled `good-first-issue` are a good starting
point for external contributors.

## Licenses

- **Code** (`firmware/`, `daemon/`, `client/`, `patterns/`, `examples/`, `tests/`) — MIT (`LICENSE`)
- **Hardware** (`hardware/` — schematics, PCB, 3D models, BOM) — CERN-OHL-P v2 (`LICENSE-HARDWARE`)
- **Documentation** (`docs/`, `research-report/`, research markdown files, README) — CC-BY-SA 4.0 (`LICENSE-DOCS`)

## Team

EFREI Paris ING2 Innovation Project 2025-2026. Mentor: Olivier Girinsky.

- **[Marc-Alexis Manso-Peters](https://github.com/marc-alexis-com)** — project lead, embedded (firmware Pico, PCA9685, IMU, PCB)
- **[Alexis Jolly](https://github.com/AlexisJOLLY)** — embedded (firmware Pico, PCA9685, IMU, PCB)
- **[Yorgo Haykal](https://github.com/yorgo-haykal)** — software (daemon, client lib, IPC, gestures)
- **Lucie Moreau** *(GitHub handle TBD)* — software (daemon, client lib, patterns, integrations)
- **Pierre Heger** *(GitHub handle TBD)* — bio-informatics (body mapping, accessibility, scientific foundations)
- **[Lilou Constantin](https://github.com/lilouconstantin)** — IT for Finance (market analysis, business model, poster, report)

The team is organized in **4 ESPACES** (ROBOTNICS embedded, BOUFFEUR DE
CODE software, FEUILLE bio-informatics, MONEYMAKER IT for Finance) — see
[`docs/espaces.md`](docs/espaces.md) for who does what inside each space.
For the prototype scope, see [`docs/scope.md`](docs/scope.md).

Although each member owns a primary area, everyone can contribute to any
part of the codebase — CODEOWNERS only auto-routes review requests, it
does not restrict who can push or approve.

## Contact

- Project: https://github.com/marc-alexis-com/haptic.skin
- EFREI Projets Transverses: `projets.transverses@efrei.fr`
- Mentor: `olivier.girinsky@efrei.fr`
