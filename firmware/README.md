# `firmware/` — Raspberry Pi Pico (Rust + Embassy)

Firmware running on the Pico. Reads commands from the host daemon over USB
serial (CDC-ACM), drives the 16 ERM motors via PCA9685 + ULN2803A, reads the
2× MPU6050 IMUs, streams gesture events upstream.

## Why Rust + Embassy

- Async-first executor (Embassy) → natural fit for "drive PWM + sample IMU +
  serve serial frames" running concurrently on a single core.
- Type-safe HAL via `embedded-hal` ecosystem (`embassy-rp`, `embassy-time`).
- No GC, deterministic timing — important for the 200 Hz pattern scheduler
  and the < 200 ms latency target on the navigation demo (issue #28).
- Mature RP2040 support (`embassy-rp` crate, `probe-rs` for SWD debug).

MicroPython was the original plan and is explicitly dropped (see issues #5,
#6, #7 for the rename and rationale).

## Layout (planned)

```
firmware/
├── Cargo.toml
├── memory.x                  # linker script for RP2040
├── .cargo/config.toml        # target = thumbv6m-none-eabi
├── src/
│   ├── main.rs               # Embassy executor entry point
│   ├── config.rs             # I²C pins, motor map, PWM frequency
│   ├── drivers/
│   │   ├── pca9685.rs        # 16-channel PWM driver (embedded-hal I²C)
│   │   ├── mpu6050.rs        # IMU driver (2× sensors on shared bus)
│   │   └── uart_proto.rs     # binary serial framing (0xAA / 0xBB + XOR)
│   ├── tasks/
│   │   ├── motor_scheduler.rs  # max() composition, fade in/out
│   │   ├── imu_stream.rs       # sample + filter IMU at fixed rate
│   │   └── power_guard.rs      # limit concurrent motors (≤ 8)
│   └── lib.rs
└── tests/
    └── serial_loopback.rs    # dev-only, no PC needed
```

## Toolchain

```bash
# Rust toolchain
rustup target add thumbv6m-none-eabi

# Flashing + debug
cargo install probe-rs --features cli
# OR drag-and-drop UF2 via BOOTSEL: cargo install elf2uf2-rs
```

## Build & flash

```bash
cd firmware/

# Drag-and-drop UF2 (no debug probe needed)
cargo run --release       # builds + uses elf2uf2-rs runner to flash via BOOTSEL

# Or via SWD probe (faster iteration + RTT logs)
cargo run --release       # configured to use probe-rs runner in .cargo/config.toml
```

## Serial protocol (summary)

- **Host → Pico**: `0xAA [cmd] [len] [payload…] [XOR]`
- **Pico → Host**: `0xBB [event] [len] [payload…] [XOR]`
- Transport: USB CDC-ACM (USB Full Speed, baud rate nominal).
- Commands: `set_motor(idx, intensity)`, `set_all(bitmap, intensities)`, `stop_all()`
- Events: `gesture(id)`, `imu_sample(acc, gyro)`, `error(code)`

See `docs/protocol.md` for the full spec (WIP).

## Key crates

| Crate | Purpose |
|---|---|
| `embassy-executor` | async runtime |
| `embassy-rp` | RP2040 HAL (I²C, USB, PIO, GPIO) |
| `embassy-time` | timers + async sleep |
| `embassy-usb` | USB CDC-ACM |
| `embedded-hal-async` | trait abstractions |
| `defmt` + `defmt-rtt` | log over SWD |
| `panic-probe` | panic handler that surfaces over RTT |
