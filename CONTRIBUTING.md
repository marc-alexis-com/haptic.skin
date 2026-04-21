# Contributing to HAPTIC.SKIN

Thanks for your interest. This document covers the workflow for team members
and external contributors.

## Workflow

1. **Pick an issue** on the [project board](https://github.com/marc-alexis-com/haptic.skin/projects)
   or create one. Assign it to yourself.
2. **Create a branch** from `main`: `git checkout -b feat/<scope>-<short-title>`.
   Scopes: `firmware`, `daemon`, `client`, `hardware`, `patterns`, `docs`, `website`.
3. **Commit** using conventional commits:
   - `feat(daemon): pattern engine 200 Hz scheduler`
   - `fix(firmware): I²C retry on NACK`
   - `docs(science): Pacinian threshold citation`
4. **Open a PR** against `main`. Link the issue. Fill the PR template.
5. **CI must pass** and **one reviewer** must approve before merge.
6. Branch is auto-deleted after merge.

## Local dev setup

### Daemon / client (Python)

```bash
cd daemon/  # or client/
python -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
pytest
ruff check . && ruff format --check .
```

### Firmware (MicroPython on Raspberry Pi Pico)

1. Flash MicroPython on the Pico (drag the `.uf2` while holding BOOTSEL).
2. Use Thonny or `mpremote` to push files:
   ```bash
   mpremote connect auto cp -r firmware/ :
   mpremote reset
   ```
3. A serial simulator lives in `tests/serial_sim.py` for dev without hardware.

### Hardware (KiCad)

- KiCad 8+ required.
- Open `hardware/necklace/necklace.kicad_pro`.
- BOM generated via the BOM plugin; committed as `hardware/BOM.csv`.

### Website

The public site at [haptic.skin](https://haptic.skin). No build step for now —
just edit files in `website/public/` and push to `main`. GitHub Actions deploys
automatically via rsync.

```bash
# Preview locally
open website/public/index.html
```

### Research report (Typst)

```bash
cd research-report/
typst watch main.typ   # live rebuild
typst compile main.typ # one-shot
```

## Code style

- **Python**: `ruff` (configured in `pyproject.toml`), type hints encouraged,
  docstrings on public API.
- **MicroPython**: Keep it readable, avoid heap allocations in hot loops,
  prefer `const()` for magic numbers.
- **Commits**: Conventional commits lite (see above).
- **No secrets** in commits — use `.env` (gitignored) for API keys.

## Reviewing

Reviews should be lightweight. One approval is enough.
Reviewers are auto-assigned via `.github/CODEOWNERS`.
Cross-area reviews are encouraged — it helps everyone understand the whole
system before the final defense.

## Filing issues

- Bug: use the bug template, include repro steps and hardware state.
- Feature: use the feature template, link it to a milestone if applicable.
- Tag with one **zone** label (`firmware`, `daemon`, …) and one **priority**
  label (`P0-blocking` to `P3-nice-to-have`).

## Licenses

By contributing, you agree your contributions are licensed under:

- MIT for code
- CERN-OHL-P v2 for hardware files
- CC-BY-SA 4.0 for documentation

See `LICENSE`, `LICENSE-HARDWARE`, `LICENSE-DOCS`.

## Code of conduct

Be kind. See `CODE_OF_CONDUCT.md`.
