# `daemon/` — host-side Python daemon

Python 3.11+ asyncio daemon. Opens the serial port to the Pico, runs the
pattern scheduler at 200 Hz, exposes a local API over Unix socket (primary),
WebSocket (for web/Unity clients), and REST (for admin/debug).

## Layout (planned)

```
daemon/
├── pyproject.toml
├── src/haptic_skin_daemon/
│   ├── __main__.py         # python -m haptic_skin_daemon
│   ├── serial_transport.py # pyserial/aioserial wrapper, auto-reconnect
│   ├── pattern_engine.py   # JSON timeline → motor commands, max() compose
│   ├── scheduler.py        # 200 Hz tick, priority queue
│   ├── gestures.py         # threshold detection, FSM debouncer
│   ├── ipc/
│   │   ├── unix_socket.py
│   │   ├── websocket.py
│   │   └── rest.py
│   └── config.py
└── tests/
```

## Running (once implemented)

```bash
cd daemon/
python -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
python -m haptic_skin_daemon --port /dev/ttyACM0
```

## Design choices

- **asyncio** single-process, one task per I/O stream, shared state guarded
  by `asyncio.Lock`.
- **200 Hz scheduler** because the PCA9685 I²C write of 16 channels takes
  ~2–3 ms at 400 kHz — comfortably below the 5 ms tick.
- **Pattern composition** uses `max()` per motor, not sum — prevents clipping.
  Validated by bHaptics and Apple Core Haptics.
- **Primary IPC is Unix socket** (~10–50 µs). WebSocket for multi-language
  clients. REST for humans.
