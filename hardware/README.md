# `hardware/` — schematics, PCB, 3D prints, BOM

All files here are licensed under **CERN-OHL-P v2** (see `LICENSE-HARDWARE`).

## Layout (planned)

```
hardware/
├── BOM.csv                     # master bill of materials
├── necklace/
│   ├── necklace.kicad_pro
│   ├── necklace.kicad_sch
│   ├── necklace.kicad_pcb
│   └── enclosure.stl
├── bracelet/
│   ├── bracelet.kicad_pro
│   ├── …
│   └── strap_holder.stl
└── docs/
    ├── wiring-diagram.png
    └── assembly-guide.md
```

## Critical design notes

- **PCA9685 cannot drive ERM motors directly.** It sources ~10 mA / sinks
  ~25 mA per channel; ERM motors draw 80–100 mA at full speed.
  ULN2803A Darlington arrays are mandatory amplifiers.
- **Flyback diodes (1N4148) on every motor** to suppress back-EMF spikes.
- **Power budget**: USB 5 V / 500 mA. 16 motors at full draw = ~1.3 A >
  limit. Firmware enforces max 6–8 concurrent motors.
- See `hardware-research.md` and research-report section 3 for rationale.

## BOM summary (target ≤ 100 €)

| Item | Qty | Unit | Subtotal |
|---|---|---|---|
| Raspberry Pi Pico | 1 | 4 € | 4 € |
| PCA9685 breakout | 1 | 3 € | 3 € |
| ULN2803A Darlington | 2 | 0,50 € | 1 € |
| 1N4148 flyback diodes | 16 | 0,05 € | 1 € |
| ERM motors (10 mm coin) | 16 | 0,50 € | 8 € |
| MPU6050 (GY-521) | 2 | 1,50 € | 3 € |
| Perfboard / JLCPCB | 1 | 5 € | 5 € |
| Connectors (JST-PH), wiring | — | — | 10 € |
| Filament (PLA + TPU) | — | — | 15 € |
| Neoprene bands, Velcro | — | — | 8 € |
| USB cable | 1 | 3 € | 3 € |
| Passives (R, C) | — | — | 2 € |
| **TOTAL** | | | **63 €** |

## Tooling

- **KiCad 8+** for schematics and PCB.
- **FreeCAD** or **Fusion 360** for enclosures (export `.stl` for 3D printing).
- **JLCPCB** for production PCBs (if we go beyond perfboard).
