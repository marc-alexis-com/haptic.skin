# `tests/` — shared test utilities

Cross-cutting test code. Per-package unit tests live inside each package
(`daemon/tests/`, `client/tests/`).

## Planned contents

```
tests/
├── serial_sim.py           # fake Pico over a virtual serial port
├── pattern_fixtures/       # JSON patterns used by engine tests
└── e2e/
    └── test_roundtrip.py   # client → daemon → fake Pico loop
```

## Serial simulator

`serial_sim.py` spawns a PTY (or socat-backed pipe) that speaks the same
binary protocol as real firmware. Lets us develop and test the daemon
without a Pico plugged in — critical while components ship from AliExpress
in weeks 1–3.
