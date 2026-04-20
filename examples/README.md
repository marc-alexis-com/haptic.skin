# `examples/` — demo scripts

Standalone scripts showing what the platform can do. Each one is the basis
for a live defense demo.

## Planned demos

| Script | What it does | Defense slot |
|---|---|---|
| `blind_navigation.py` | Guide a blindfolded volunteer through an obstacle course using 8-direction necklace vibrations | 🥇 primary (2 min) |
| `spatial_notifications.py` | Incoming "call" from a contact → vibration on the matching side; gesture answers/dismisses | 🥈 bidirectional (2 min) |
| `music_to_vibration.py` | Real-time audio FFT → frequency bands mapped to motor groups; jury wears the necklace | 🥉 wow factor (30 s) |
| `posture_reminder.py` | IMU detects slouch → gentle vibrating reminder | bonus |
| `compass.py` | Necklace motor always pointing north (magnetic sense training) | bonus |

## How to run (once prototype exists)

```bash
# Start the daemon in one terminal
python -m haptic_skin_daemon

# Run an example in another
python examples/blind_navigation.py
```

Each example is self-contained, depends only on `haptic-skin`, and is meant
to be short enough to read during the defense (< 50 lines).
