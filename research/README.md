# `research/` — long-form research notes

These Markdown notes are the **seed material** for the Typst deep-research
report in [`../research-report/main.typ`](../research-report/main.typ).
The Typst file is the canonical deliverable; these notes are where
raw findings and sources get distilled before being folded into the report.

| File | Content |
|---|---|
| [`hardware.md`](hardware.md) | Hardware analysis: motor choice (ERM vs LRA), PCA9685 + ULN2803A chain, MPU6050, flyback diodes, BOM rationale |
| [`scientific-foundations.md`](scientific-foundations.md) | Mechanoreceptors, frequency sensitivity per body zone, two-point discrimination, perception thresholds |
| [`similar-projects.md`](similar-projects.md) | State-of-the-art survey: bHaptics, Teslasuit, research wearables, open-source haptic projects |
| [`prompt.md`](prompt.md) | Original mega-prompt that orchestrated the parallel research agents. Re-run (or parts of it) to refresh a research axis |

## Workflow

1. Update or add findings in one of these `.md` files.
2. Reflect the distilled version into the matching `== section` in `../research-report/main.typ`.
3. Add new citations to `../research-report/refs.yml`.
4. Recompile: `cd ../research-report && typst compile main.typ`.
