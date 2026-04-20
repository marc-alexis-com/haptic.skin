# `patterns/` — JSON pattern library

Haptic patterns as portable JSON files, inspired by Apple's AHAP format and
bHaptics' timeline model. Each file is self-contained and loaded by the
daemon's pattern engine.

## Format

```json
{
  "name": "swipe_left",
  "duration_ms": 400,
  "timeline": [
    {
      "time_ms": 0,
      "type": "continuous",
      "motors": [0, 1, 2, 3],
      "intensity": 0.8,
      "duration_ms": 150,
      "fade_out_ms": 50
    },
    {
      "time_ms": 100,
      "type": "continuous",
      "motors": [4, 5, 6, 7, 8, 9, 10, 11],
      "intensity": 0.6,
      "duration_ms": 200
    },
    {
      "time_ms": 250,
      "type": "continuous",
      "motors": [12, 13, 14, 15],
      "intensity": 0.8,
      "duration_ms": 150
    }
  ]
}
```

## Composition

When multiple patterns overlap on the same motor, the daemon uses `max()`
— not addition. This prevents clipping and matches the behavior of
bHaptics and Apple Core Haptics.

## Planned built-ins

| Name | Purpose |
|---|---|
| `pulse` | single short buzz (100 ms) |
| `double_pulse` | two quick buzzes (confirmation) |
| `swipe_left` / `swipe_right` | direction cue across a row |
| `heartbeat` | pulse rhythm (mood, biofeedback) |
| `alert_urgent` | strong rising pattern |
| `confirm` / `deny` | short positive / negative cues |
| `navigate_left` / `navigate_right` / `navigate_forward` / `navigate_back` | compass cues on necklace |
| `breathing_in` / `breathing_out` | slow ramps at 6/min (coherent breathing) |
