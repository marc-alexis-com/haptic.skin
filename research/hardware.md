# HAPTIC.SKIN -- Hardware Research

> Research compiled April 2026 for the EFREI Innovation Project.
> Goal: open-source bidirectional haptic wearable (1 necklace + 2 bracelets, 16 motors, IMU sensors, <100 EUR budget, 3-month timeline).

---

## 2.1 Microcontroller Comparison

| Criterion | Raspberry Pi Pico | Raspberry Pi Pico W / Pico 2 W | ESP32 (WROOM-32) | STM32 (e.g. STM32F401) |
|---|---|---|---|---|
| **CPU** | Dual-core ARM M0+ @ 133 MHz | Dual-core ARM M0+ @ 133 MHz (Pico 2 W: M33 @ 150 MHz) | Dual-core Xtensa @ 240 MHz | Single-core ARM M4 @ 84 MHz |
| **RAM** | 264 KB | 264 KB (Pico 2 W: 520 KB) | 520 KB | 96 KB |
| **Flash** | 2 MB | 2 MB | 4 MB (typically) | 256-512 KB |
| **Wi-Fi** | No | Yes (2.4 GHz) | Yes (2.4 GHz) | No |
| **Bluetooth** | No | No (Pico 2 W: Yes, BLE) | Yes (Classic + BLE) | No |
| **I2C buses** | 2 | 2 | 2 | 3 |
| **PWM channels** | 16 (8 slices x 2) | 16 | 16 | 12+ |
| **PIO state machines** | 8 | 8 | None | None |
| **MicroPython support** | Excellent | Excellent | Good | Limited |
| **Power (active)** | ~25 mA | ~25-90 mA (Wi-Fi active: ~90 mA) | ~160-240 mA (Wi-Fi active) | ~30 mA |
| **Price (Europe)** | ~4 EUR | ~6-7 EUR | ~4-8 EUR | ~3-10 EUR |
| **USB** | Native USB 1.1 | Native USB 1.1 | USB via UART bridge (most dev boards) | Native USB (some variants) |
| **Documentation** | Excellent, beginner-friendly | Excellent | Very good, huge community | Good but steeper learning curve |

### Analysis for HAPTIC.SKIN

**Raspberry Pi Pico (non-W) -- RECOMMENDED for prototype**

- Exactly 16 hardware PWM channels matches our 16 motors (though we still need PCA9685 for I2C-addressable independent control).
- Native USB serial is the planned PC communication channel -- no Wi-Fi needed.
- MicroPython ecosystem is mature; PCA9685 library already exists.
- PIO blocks could be used for custom I2C or motor driving protocols.
- Cheapest option (~4 EUR), maximizing budget for motors and mechanical parts.
- Dual-core allows one core for motor patterns, one for IMU processing.

**ESP32 -- best if wireless is needed later**

- If the project evolves to need Bluetooth (wireless wearable without USB tether), ESP32 becomes the better choice.
- Higher power consumption is a downside for battery operation.
- More processing power than needed for this use case.

**STM32 -- overkill complexity**

- Better for production; not justified for a 3-month prototype with MicroPython as the language.

**Decision: Raspberry Pi Pico (non-W) for prototype. Pico 2 W as stretch goal for wireless.**

Sources:
- [ESP32 vs Raspberry Pi Pico W: 2026 Comparison](https://www.flywing-tech.com/blog/esp32-vs-raspberry-pi-pico-w-2025-microcontroller-comparison/)
- [ESP32 vs Pico W - Makers Electronics](https://makerselectronics.com/2025/08/09/esp32-vs-raspberry-pi-pico-w/)
- [ESP32 vs Raspberry Pi Pico - RaspberryTips](https://raspberrytips.com/esp32-vs-raspberry-pico/)
- [ESP32 vs Arduino, STM32, RPi Pico & nRF52 - SocketXP](https://www.socketxp.com/iot/esp32-vs-arduino-stm32-raspberry-pi-pico-nrf52-best-iot-microcontroller/)
- [Buy a Raspberry Pi Pico - Official](https://www.raspberrypi.com/products/raspberry-pi-pico/)
- [Pico W pricing - welectron](https://www.welectron.com/Raspberry-Pi-Pico-W_1)

---

## 2.2 Actuator Technology Comparison

| Criterion | ERM (Eccentric Rotating Mass) | LRA (Linear Resonant Actuator) | Piezoelectric |
|---|---|---|---|
| **Mechanism** | DC motor with off-center mass | Spring-mass system, single axis | Crystal deformation |
| **Response time** | 50-100 ms startup | 40-60 ms startup | ~1.5 ms (fastest) |
| **Stop time** | 50-100 ms | Several hundred ms (resonance decay) | <5 ms |
| **Frequency control** | Voltage = speed (coupled) | Fixed resonant freq (~150-250 Hz) | Independent freq + amplitude |
| **Amplitude control** | Voltage = amplitude (coupled) | Drive amplitude | Independent |
| **Typical voltage** | 2.5-3.3 V DC | 2.0 V AC (resonant) | 60-200 V (needs boost driver) |
| **Current** | 60-100 mA | 30-60 mA | <5 mA (capacitive load) |
| **Power per actuator** | ~200-330 mW | ~60-120 mW | ~1-10 mW |
| **Driver complexity** | Simple: transistor + PWM | Needs AC drive at resonant freq (DRV2605L) | Needs high-voltage boost IC |
| **Form factor** | Coin: 8-12 mm dia, 2-3 mm thick | Coin: 8-10 mm dia, 3-4 mm thick | Disc: 12-35 mm dia, 0.2-0.5 mm |
| **Haptic quality** | Coarse, buzzy | Crisp, responsive | Highest fidelity, sharp |
| **Cost per unit** | 0.20-0.80 EUR | 1.50-4.00 EUR | 2.00-15.00 EUR |
| **Driver cost (16 ch)** | PCA9685 + transistors: ~5 EUR | 16x DRV2605L: ~80+ EUR | 16x boost drivers: ~100+ EUR |
| **Wearable suitability** | Good -- simple, cheap, proven | Best balance -- phones/watches use these | Emerging -- thinnest, best fidelity |

### Analysis for HAPTIC.SKIN

**ERM -- RECOMMENDED for prototype**

- 16 motors at 0.30-0.50 EUR each = ~5-8 EUR total. Fits budget perfectly.
- Driving is trivial: PCA9685 PWM -> N-channel MOSFET/transistor -> motor. No special driver IC needed per motor.
- Coin-type ERM (10 mm diameter, 2-3 mm thick) is ideal for embedding in wearable bands.
- Response time of 50-100 ms is acceptable for notification patterns (not gaming-level precision).
- Well-documented, massive community knowledge base.
- 16 LRAs would need 16 individual DRV2605L drivers (~5 EUR each), blowing the budget.

**LRA -- stretch goal / v2**

- Superior haptic quality, but the per-channel driver cost (DRV2605L) makes 16-channel LRA impractical at <100 EUR.
- Could be considered if channel count is reduced.

**Piezoelectric -- not feasible**

- High-voltage drive circuitry too complex and expensive for 16 channels.
- Better suited for single-actuator high-fidelity applications.

**Decision: 10 mm coin-type ERM motors (3V, ~60-80 mA). Budget: ~8 EUR for 16 units.**

**Recommended part:** 10 mm x 2.7 mm coin ERM, 3V rated, ~75 mA, 12000 RPM (available from AliExpress/NFP Shop/Precision Microdrives).

Sources:
- [Haptic Actuators: Comparing Piezo to ERM and LRA - Piezo.com](https://blog.piezo.com/haptic-actuators-comparing-piezo-erm-lra)
- [Haptics Components: LRA, ERM, Piezo - Power Electronic Tips](https://www.powerelectronictips.com/haptics-components-pt-1-lra-erm-and-piezo-actuators/)
- [Haptic Motors Selection Guide - MicroMotorPro](https://micromotorpro.com/haptic-motors-types-selection-erm-lra-vcm-piezo/)
- [Haptic Actuators: LRA and ERM vs Piezo - Boreas Technologies](https://pages.boreas.ca/blog/piezo-haptics/haptic-actuators-how-lra-and-erm-stack-up-with-piezo-actuators)
- [Design Guidance for Haptic Wearables - Precision Microdrives](https://www.precisionmicrodrives.com/design-guidance-for-haptic-wearables)
- [10mm Coin Vibration Motor - NFP Shop](https://nfpshop.com/product/coin-vibration-motor-price-10mm-diameter-ieee-projects)

---

## 2.3 IMU Sensor Options

| Criterion | MPU6050 | BMI160 | LSM6DS3 | LSM6DSO (bonus) |
|---|---|---|---|---|
| **Manufacturer** | InvenSense (TDK) | Bosch | STMicroelectronics | STMicroelectronics |
| **DOF** | 6 (accel + gyro) | 6 (accel + gyro) | 6 (accel + gyro) | 6 (accel + gyro) |
| **Accel range** | +/-2/4/8/16 g | +/-2/4/8/16 g | +/-2/4/8/16 g | +/-2/4/8/16 g |
| **Gyro range** | +/-250/500/1000/2000 dps | +/-125 to 2000 dps | +/-125 to 2000 dps | +/-125 to 2000 dps |
| **ODR (max)** | 1 kHz | 1600 Hz | 6664 Hz | 6664 Hz |
| **Noise (gyro)** | 0.05 dps/sqrt(Hz) | 0.008 dps/sqrt(Hz) | 0.004 dps/sqrt(Hz) | 0.003 dps/sqrt(Hz) |
| **Built-in features** | DMP (Digital Motion Processor) | Step counter, gesture detect | Step counter, tap detect, tilt, wake-up, **embedded ML core** | Step counter, tap, tilt, wake-up, **ML core (larger)** |
| **Power (normal)** | 3.9 mA | 0.95 mA | 0.9 mA | 0.55 mA |
| **Power (low-power)** | N/A (no real LP mode) | 0.003 mA | 0.024 mA | 0.014 mA |
| **Voltage** | 2.375-3.46 V | 1.71-3.6 V | 1.71-3.6 V | 1.71-3.6 V |
| **Interface** | I2C / SPI | I2C / SPI | I2C / SPI | I2C / SPI |
| **Status** | Active but aging (2012 design) | **OBSOLETE** (EOL April 2025) | Active | Active (recommended successor) |
| **Breakout board price** | 1-2 EUR | 3-5 EUR | 3-6 EUR | 4-8 EUR |
| **Quality issues** | High failure rate (2-3 bad per batch), drifts within minutes | N/A -- do not use | Good reliability | Best in class |

### Analysis for HAPTIC.SKIN

**MPU6050 -- acceptable for budget prototype, but with caveats**

- Cheapest option at ~1-2 EUR per breakout (GY-521 board on AliExpress).
- The DMP can offload gesture processing from the Pico.
- Known quality issues: drift and high failure rates in cheap clones. Buy extras.
- For threshold-based gesture recognition (raise, shake, tilt) -- not precision tracking -- the MPU6050 is adequate.
- Massive MicroPython library ecosystem.

**LSM6DS3 -- RECOMMENDED if budget allows**

- Built-in tap detection, tilt detection, and step counter reduce firmware complexity.
- ML core (in some variants) could run simple gesture classification on-chip.
- Much lower noise and power consumption than MPU6050.
- Breakout boards available at ~4-6 EUR.
- MicroPython support exists but is less mature than MPU6050.

**BMI160 -- DO NOT USE**

- Officially obsolete as of April 2025. No new designs should use it.

**Decision: MPU6050 (GY-521) for initial prototype due to cost and library support. Upgrade path to LSM6DS3 if gesture recognition quality is insufficient.**

Sources:
- [IMU Comparison - SlimeVR Docs](https://docs.slimevr.dev/diy/imu-comparison.html)
- [BMI160 Obsolete: Best Replacement Sensors 2025](https://www.utmel.com/components/bosch-bmi160-blues-best-sensor-swaps-for-2025?id=7045)
- [MPU-6050 vs LSM6D* -- IMU Comparison](https://viacheslav-popika.com/imu-compare.html)
- [GY-LSM6DS3 6-Axis IMU Guide](https://easyelecmodule.com/gy-lsm6ds3-6-axis-imu-from-beginner-to-application/)
- [Comparison of 4 Gyros - Hackaday](https://hackaday.io/page/1595-comparison-of-4-gyros)

---

## 2.3b PWM Driver Comparison

| Criterion | PCA9685 | TLC5940 | Direct GPIO PWM (Pico) |
|---|---|---|---|
| **Channels** | 16 | 16 | 16 (8 slices x 2 outputs) |
| **Resolution** | 12-bit (4096 steps) | 12-bit (4096 steps) | 16-bit (65536 steps) |
| **Interface** | I2C | SPI + external clock | Direct GPIO |
| **Internal clock** | Yes (25 MHz, adjustable) | No (needs external GSCLK) | Yes |
| **PWM frequency** | 24 Hz - 1526 Hz | Depends on external clock | Up to 125 MHz / divider |
| **Max output current** | 25 mA per channel (sink/source) | 120 mA per channel (sink only) | ~12 mA per GPIO |
| **Needs transistors?** | Yes (motors draw 60-80 mA) | Depends (can sink 120 mA directly) | Yes |
| **Chaining** | Up to 62 boards (992 channels) | Yes, daisy-chain | N/A |
| **CPU load** | Minimal (I2C set-and-forget) | High (continuous clocking) | Low (hardware PWM) |
| **MicroPython library** | Yes, mature | Limited | Built-in |
| **Price (breakout)** | 2-3 EUR | 2-4 EUR | Free (built into Pico) |

### Analysis for HAPTIC.SKIN

**PCA9685 -- RECOMMENDED**

- I2C interface uses only 2 pins on the Pico, leaving others free for IMU and USB.
- Set-and-forget: once configured, runs independently. CPU can focus on pattern sequencing.
- 12-bit resolution gives 4096 intensity levels -- far more than needed for vibration control.
- Existing MicroPython library for Pico: [pca9685_for_pico](https://github.com/kevinmcaleer/pca9685_for_pico).
- At ~200 Hz PWM (suitable for ERM motors), provides smooth vibration control.
- **Requires external transistors** since motor current (60-80 mA) exceeds PCA9685's 25 mA per-channel limit.

**Transistor array needed:** 16x 2N7000 N-channel MOSFETs (~0.05 EUR each) or ULN2803A Darlington array (2x for 16 channels, ~0.50 EUR each). The ULN2803A provides 8 channels each with built-in flyback diodes (important for inductive motor loads).

**Decision: PCA9685 + 2x ULN2803A Darlington arrays.**

Sources:
- [TLC59xx vs PCA96xx - Adafruit Forums](https://forums.adafruit.com/viewtopic.php?t=66635)
- [Choosing a PWM Driver](https://drlwork.wordpress.com/2015/02/16/21615-choosing-a-pwm-driver-a-big-pain-in-the-neck/)
- [PCA9685 MicroPython Library for Pico](https://github.com/kevinmcaleer/pca9685_for_pico)
- [Adafruit PCA9685 Product Page](https://www.adafruit.com/product/815)

---

## 2.4 Power Architecture

### Option A: USB-Powered (RECOMMENDED for prototype)

```
[PC USB Port] --USB cable--> [Raspberry Pi Pico] --3.3V/5V--> [PCA9685 + Motors]
```

| Parameter | Value |
|---|---|
| USB 2.0 max current | 500 mA |
| Pico consumption | ~25 mA |
| PCA9685 logic | ~10 mA |
| 2x MPU6050/LSM6DS3 | ~8 mA |
| 16x ERM motors (worst case, all ON) | 16 x 75 mA = 1200 mA |
| 16x ERM motors (typical pattern, 4-6 ON) | 4-6 x 75 mA = 300-450 mA |
| **Total typical** | **~350-500 mA** |
| **Total worst case** | **~1240 mA** |

**Problem:** USB 2.0 provides only 500 mA. All 16 motors at full power exceeds this.

**Solutions:**
1. **External 5V power supply** for motor bank (separate from USB data). Cost: ~3-5 EUR for a 5V/2A supply.
2. **Current limiting in firmware**: never activate more than 6 motors simultaneously at full intensity. Pattern design should account for this.
3. **PWM duty cycle limiting**: cap maximum duty cycle at 70%, reducing per-motor current to ~50 mA.
4. **Combination of 2 and 3**: most patterns only activate 3-6 motors in sequence, staying well within 500 mA.

### Option B: Battery-Powered (future / wireless version)

| Battery | Capacity | Weight | Estimated autonomy |
|---|---|---|---|
| LiPo 3.7V 500 mAh | 500 mAh | ~10 g | ~1 hr (continuous), ~4-8 hr (intermittent) |
| LiPo 3.7V 1000 mAh | 1000 mAh | ~20 g | ~2 hr (continuous), ~8-16 hr (intermittent) |
| LiPo 3.7V 2000 mAh | 2000 mAh | ~40 g | ~4 hr (continuous), ~16-32 hr (intermittent) |

**Autonomy calculation (intermittent use):**
- Average consumption with typical haptic patterns: ~100-150 mA (idle + occasional 3-4 motor bursts)
- With 1000 mAh battery: 1000 / 125 = ~8 hours
- This is acceptable for a wearable prototype demo.

**Battery requirements:** LiPo charge controller (TP4056 module: ~0.50 EUR), 3.3V regulator (already on Pico), and protection circuit.

**Decision: USB-powered for prototype with firmware current limiting. Add TP4056 + LiPo as optional upgrade.**

Sources:
- [Haptic Energy Consumption - TI Application Note](https://www.ti.com/lit/pdf/sloa194)
- [Haptics and Battery Drain](https://thebatterytips.com/battery-specifications/does-haptics-consume-battery/)
- [Design Guidance for Haptic Wearables - Precision Microdrives](https://www.precisionmicrodrives.com/design-guidance-for-haptic-wearables)
- [Improve Haptic Motor Power-efficiency - Quadrant](https://www.quadrant.us/blog/1684.html)

---

## 2.5 Mechanical Design Options

### 2.5.1 Band/Enclosure Fabrication

| Method | Pros | Cons | Cost | Time |
|---|---|---|---|---|
| **3D printing (TPU/NinjaFlex)** | Fast iteration, flexible, no mold needed, design flat and wrap | Requires tuned printer, layer lines visible, less comfortable than silicone | 2-5 EUR filament per band | 2-4 hours per band |
| **3D printing (PLA) + fabric sleeve** | Easy to print rigid mounts, fabric provides comfort | Two-part assembly, less integrated | 1-3 EUR | 1-2 hours print + sewing |
| **Silicone molding** | Most comfortable, waterproof, professional feel | Needs 3D-printed mold first, curing time, messy, harder to iterate | 10-20 EUR for silicone | 1-2 days (mold + cure) |
| **Fabric + velcro** | Most comfortable, adjustable, washable | Requires sewing skills, less rigid motor positioning | 5-10 EUR fabric/velcro | 2-4 hours |
| **Elastic band + 3D-printed motor housings** | Quick, adjustable, modular | Less polished look | 3-5 EUR | 1-2 hours |

**RECOMMENDED approach for prototype:**
1. **3D print rigid motor housing pods** in PLA (small clips holding each coin motor).
2. **Mount pods on elastic/neoprene band** using snap buttons or small bolts.
3. This allows repositioning motors during development.
4. For the defense demo, upgrade to TPU printed bands or fabric integration.

### 2.5.2 Connector Strategy

| Connector Type | Use Case | Pros | Cons |
|---|---|---|---|
| **JST-SH 1.0mm** | Board-to-board (Pico to PCA9685) | Tiny, reliable, rated 1A | Needs crimping tool |
| **JST-PH 2.0mm** | Motor connections | Easy to hand-solder, common in hobby | Slightly larger |
| **Snap buttons (conductive)** | Detachable wearable connections | Sew to fabric, solder to PCB, easy disconnect | Higher contact resistance |
| **FFC/FPC ribbon** | Necklace (long flexible run) | Very flat, flexible | Fragile, needs ZIF connector |
| **Dupont headers** | Prototyping phase | Cheap, universal, breadboard-compatible | Not wearable-friendly |
| **Soldered + heat shrink** | Permanent motor connections | Most reliable, cheapest | Not detachable |

**RECOMMENDED approach:**
- **Prototyping:** Dupont headers and breadboard.
- **Integrated prototype:** JST-PH for motor connections (detachable), direct solder for permanent runs. Snap buttons for wearable attachment/detachment points.

### 2.5.3 PCB Design Considerations

For a 3-month prototype, **custom PCBs are optional but achievable:**

- **JLCPCB / PCBWay** can produce 5 rigid PCBs for ~5-8 EUR (5-7 day lead time).
- A small carrier PCB for the PCA9685 + ULN2803A + motor connectors would clean up wiring significantly.
- KiCad is the recommended tool (open-source, matches project philosophy).
- **Flex PCBs are NOT recommended** for prototype: too expensive (~30-50 EUR minimum), long lead times, and unnecessary when rigid PCB + flexible wire achieves the same result.

Sources:
- [Wearable PCB Design with KiCad - AllPCB](https://www.allpcb.com/blog/pcb-knowledge/wearable-pcb-design-with-kicad-a-comprehensive-tutorial.html)
- [Designing Wearables - Altium Resources](https://resources.altium.com/p/designing-wearables-that-work-pcb-layout)
- [Wearable PCB Design Guidelines - Proto-Electronics](https://www.proto-electronics.com/blog/wearable-pcb-design-guidelines)
- [Snap Connectors for Wearables - MDPI](https://www.mdpi.com/2673-7248/4/3/19)
- [Connectors for Electronic Textiles - Wiley](https://onlinelibrary.wiley.com/doi/full/10.1002/eng2.12491)
- [3D Printed Band for Apple Watch - Adafruit](https://learn.adafruit.com/3d-printed-band-for-apple-watch/overview)
- [TPU vs TPE vs Silicone - Lanxin](https://siliconemakers.com/tpu-vs-tpe-vs-silicone-which-material-fits-your-product-best/)

---

## 2.6 Bill of Materials (Final Recommendation)

### Core Electronics

| Component | Qty | Unit Price (EUR) | Total (EUR) | Source |
|---|---|---|---|---|
| Raspberry Pi Pico | 1 | 4.00 | 4.00 | Farnell / Melopero |
| PCA9685 breakout board | 1 | 2.50 | 2.50 | AliExpress |
| ULN2803A Darlington array | 2 | 0.50 | 1.00 | AliExpress / Mouser |
| 10mm coin ERM motors (3V) | 20 (16+4 spare) | 0.40 | 8.00 | AliExpress |
| MPU6050 breakout (GY-521) | 3 (2+1 spare) | 1.50 | 4.50 | AliExpress |
| USB cable (data + power) | 1 | 2.00 | 2.00 | Local |
| Breadboard + jumper wires | 1 set | 3.00 | 3.00 | AliExpress |
| **Subtotal electronics** | | | **25.00** | |

### Power (optional battery upgrade)

| Component | Qty | Unit Price (EUR) | Total (EUR) | Source |
|---|---|---|---|---|
| TP4056 LiPo charger module | 1 | 0.50 | 0.50 | AliExpress |
| LiPo battery 3.7V 1000mAh | 1 | 4.00 | 4.00 | AliExpress |
| 5V boost converter | 1 | 1.00 | 1.00 | AliExpress |
| **Subtotal power** | | | **5.50** | |

### Mechanical / Wearable

| Component | Qty | Unit Price (EUR) | Total (EUR) | Source |
|---|---|---|---|---|
| TPU filament (small spool, 250g) | 1 | 10.00 | 10.00 | Amazon |
| PLA filament (already owned or shared) | - | 0.00 | 0.00 | - |
| Elastic neoprene band (1m) | 1 | 5.00 | 5.00 | Amazon / fabric store |
| Velcro strips | 1 pack | 3.00 | 3.00 | Local |
| JST-PH connectors (assorted) | 1 kit | 5.00 | 5.00 | AliExpress |
| Heat shrink tubing | 1 pack | 2.00 | 2.00 | AliExpress |
| Wire (26 AWG, silicone, flexible) | 5m | 3.00 | 3.00 | AliExpress |
| **Subtotal mechanical** | | | **28.00** | |

### PCB (optional but recommended)

| Component | Qty | Unit Price (EUR) | Total (EUR) | Source |
|---|---|---|---|---|
| Custom PCB (5 pcs, JLCPCB) | 1 order | 5.00 | 5.00 | JLCPCB |
| Shipping | 1 | 3.00 | 3.00 | JLCPCB |
| **Subtotal PCB** | | | **8.00** | |

### Budget Summary

| Category | Cost (EUR) |
|---|---|
| Core electronics | 25.00 |
| Power (optional) | 5.50 |
| Mechanical | 28.00 |
| PCB (optional) | 8.00 |
| **Shipping buffer (~15%)** | **10.00** |
| **TOTAL** | **76.50** |
| **TOTAL (without optionals)** | **63.00** |

**Well within the <100 EUR budget, with ~25 EUR margin for unexpected costs or upgrades.**

---

## 2.7 Feasibility Assessment (3 months, <100 EUR)

### Timeline Breakdown

| Week | Milestone | Deliverable |
|---|---|---|
| **1-2** | Component ordering + breadboard prototype | Single motor driven by Pico + PCA9685 via MicroPython |
| **3-4** | 16-motor array working on breadboard | All motors individually addressable, basic patterns |
| **5-6** | IMU integration + gesture detection | Raise/shake/tilt detection on MPU6050, threshold-based |
| **7-8** | USB serial protocol + Python daemon | PC can send pattern commands, daemon receives and dispatches |
| **9-10** | Wearable integration (3D print + assembly) | Motors mounted in bands, wiring routed, wearable form factor |
| **11-12** | API + client library + polish | `haptic('swipe_left', intensity=0.8)` one-liner works end-to-end |
| **13 (buffer)** | Demo preparation, bug fixes, documentation | Working demo for defense |

### Risk Assessment

| Risk | Impact | Likelihood | Mitigation |
|---|---|---|---|
| AliExpress shipping delays | High | Medium | Order in week 1, have backup EU sources (Mouser/Farnell for critical parts) |
| ERM motor failure/inconsistency | Medium | Medium | Order 20% extra, test each on arrival |
| I2C bus issues with long wires | Medium | Medium | Keep I2C runs short (<30 cm), use pull-up resistors, consider I2C bus extender |
| Power insufficient from USB | Medium | Low | Firmware current limiting, external 5V supply as backup |
| MPU6050 gesture recognition too noisy | Medium | Medium | Use averaging/filtering, upgrade to LSM6DS3 if needed |
| 3D printing access issues | Low | Low | Most EFREI labs have printers; alternatively use online services |
| Team member availability | High | Medium | Document everything, modular architecture allows parallel work |

### What is Realistically Achievable

**HIGH CONFIDENCE (core deliverables):**
- 16 ERM motors individually controllable via PCA9685 + Pico
- USB serial communication to PC
- Python daemon with basic pattern API
- 2 gesture types detected (raise hand, shake)
- 3 wearable bands with motors mounted (even if aesthetically rough)
- Live demo: notification triggers vibration pattern, gesture dismisses it

**MEDIUM CONFIDENCE (stretch goals):**
- 4+ gesture types with reliable classification
- Custom PCB (clean wiring)
- Battery power option
- Spatial mapping (different motors for different notification sources)
- Client library with 10+ predefined patterns

**LOW CONFIDENCE (aspirational):**
- Wireless (Bluetooth) operation via Pico 2 W or ESP32
- ML-based gesture recognition
- Multi-user communication between wearers
- Flex PCB design

### Final Verdict

**The project is feasible within 3 months and <100 EUR.** The core architecture (Pico + PCA9685 + ERM motors + MPU6050 + USB + Python daemon) uses well-documented, cheap, widely-available components with existing library support. The main risk is shipping time from AliExpress -- order immediately and have EU-sourced backups for the Pico and PCA9685.

The recommended stack:
- **MCU:** Raspberry Pi Pico (~4 EUR)
- **PWM driver:** PCA9685 + 2x ULN2803A (~4 EUR)
- **Motors:** 16x 10mm coin ERM 3V (~8 EUR)
- **IMU:** 2x MPU6050 GY-521 (~3 EUR)
- **Power:** USB (free) with optional LiPo upgrade (~5.50 EUR)
- **Bands:** 3D printed PLA mounts + elastic bands (~15 EUR)
- **Total: ~63-77 EUR**
