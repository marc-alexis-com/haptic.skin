# `firmware/` — Raspberry Pi Pico (MicroPython)

Firmware running on the Pico. Reads commands from the host daemon over USB
serial, drives the 16 ERM motors via PCA9685 + ULN2803A, reads the 2× MPU6050
IMUs, streams gesture events upstream.

## Layout (planned)

```
firmware/
├── main.py                 # boot entry point
├── config.py               # I²C pins, motor map, PWM frequency
├── drivers/
│   ├── pca9685.py          # 16-channel PWM driver
│   ├── mpu6050.py          # IMU with DMP support
│   └── uart_proto.py       # binary serial framing (0xAA / 0xBB + XOR)
├── core/
│   ├── motor_scheduler.py  # max() composition, fade in/out
│   ├── imu_stream.py       # sample + filter IMU at fixed rate
│   └── power_guard.py      # limit concurrent motors (≤ 8)
└── tests/
    └── serial_loopback.py  # dev-only, no PC needed
```

## Flashing

1. Hold BOOTSEL, plug the Pico — it mounts as a USB drive.
2. Drop the MicroPython `.uf2` (see <https://micropython.org/download/RPI_PICO/>).
3. Push the firmware:
   ```bash
   mpremote connect auto cp -r firmware/ :
   mpremote reset
   ```

## Serial protocol (summary)

- **Host → Pico**: `0xAA [cmd] [len] [payload…] [XOR]`
- **Pico → Host**: `0xBB [event] [len] [payload…] [XOR]`
- Baud rate: 921 600 (CDC-ACM runs at USB Full Speed regardless).
- Commands: `set_motor(idx, intensity)`, `set_all(bitmap, intensities)`, `stop_all()`
- Events: `gesture(id)`, `imu_sample(acc, gyro)`, `error(code)`

See `docs/protocol.md` for the full spec (WIP).
