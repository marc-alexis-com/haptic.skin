# `docs/` — user & developer documentation

Source for the documentation site. Stack: **mkdocs-material** (to be set up).

## Planned structure

```
docs/
├── scope.md                  # prototype v1 scope + clarifications jury
├── espaces.md                # 4 ESPACES team organization
├── index.md                  # landing
├── getting-started.md        # install + first vibration
├── architecture.md           # 3 software layers + 2 hardware layers
├── protocol.md               # binary serial + IPC protocols
├── pattern-format.md         # JSON schema + examples
├── gesture-recognition.md    # thresholds, FSM, tuning
├── api/
│   ├── client.md
│   └── daemon.md
├── hardware/
│   ├── assembly.md           # step-by-step build guide
│   └── wiring.md
├── science/                  # maintained by the bio-informatics lead
│   ├── mechanoreceptors.md
│   ├── frequency-sensitivity.md
│   └── body-mapping.md
└── use-cases/
    ├── accessibility.md
    ├── notifications.md
    └── music.md
```

## Build locally

```bash
pip install mkdocs-material
mkdocs serve
```

## Deploy

GitHub Pages, auto-deployed by `.github/workflows/docs.yml` (to be added).
