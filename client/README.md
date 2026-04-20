# `client/` — `haptic-skin` Python package

Pip-installable one-liner client. Any Python program talks to the daemon
through this library.

## Layout (planned)

```
client/
├── pyproject.toml          # package metadata, deps: none or minimal
├── src/haptic_skin/
│   ├── __init__.py         # exposes haptic(), HapticClient, exceptions
│   ├── client.py           # Unix socket connection, reconnect, context mgr
│   ├── patterns.py         # helpers to build custom patterns
│   └── gestures.py         # gesture event subscribe/callback
└── tests/
```

## Target API

```python
from haptic_skin import haptic, on_gesture

# One-liner
haptic('swipe_left', intensity=0.8)
haptic('heartbeat', repeat=3, interval_ms=800)

# Custom pattern
haptic({
    "duration_ms": 300,
    "timeline": [
        {"time_ms": 0, "motors": [0, 1], "intensity": 0.9, "duration_ms": 150},
    ],
})

# Gesture callback
@on_gesture('hand_raised')
def answer_call():
    ...
```

## Install (once published)

```bash
pip install haptic-skin
```

During development from the monorepo:

```bash
pip install -e client/
```
