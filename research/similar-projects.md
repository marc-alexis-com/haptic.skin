# 8. Lessons from Similar Projects

## 8.1 Student/Academic Projects Review

### 8.1.1 University Research Projects

**Tasbi (Rice University / MAHI Lab)**
Tactile And Squeeze Bracelet Interface -- a multisensory haptic wristband for AR/VR combining squeeze and vibrotactile feedback. Developed by a university lab with multiple graduate students. Published at IEEE World Haptics Conference 2019. This is a higher-complexity project than HAPTIC.SKIN (squeeze actuation + vibration), but validates that wrist-worn multi-actuator devices are achievable in academic settings.
- Source: <https://mahilab.rice.edu/sites/default/files/publications/tasbi_whc2019.pdf>

**WRIST Haptic Wristband (Rice University, student team)**
The WRIST (Wearable Radial Interface for Sensory hapTic feedback) team -- students from mechanical and electrical/computer engineering -- built a lightweight, modular bracelet delivering squeeze and vibrotactile feedback. Won top prize in a global design contest in 2025. Demonstrates that student teams can produce competition-winning haptic wearables.
- Source: <https://news.rice.edu/news/2025/rice-students-win-top-prize-global-design-contest-cutting-edge-haptic-wristband>

**HapConnect (ASEE Educational Project)**
A modular, reconfigurable, vibration-based wearable haptic device designed specifically for teaching undergraduate engineering students about haptics and inclusive design. Uses an easy-to-assemble architecture so students can explore vibrotactile feedback during a semester-long class project. Directly relevant as a precedent for student-built haptic wearables.
- Source: <https://peer.asee.org/board-134-the-hapconnect-teaching-about-haptics-and-inclusive-design-with-modular-wearable-technology.pdf>

**Stanford Haptic Bracelet (Hojung Choi et al.)**
Ph.D. research on a wrist-worn haptic device studying how users perceive haptic inputs. Published in IEEE Robotics and Automation Letters. Provides useful data on wrist vibrotactile perception thresholds relevant to HAPTIC.SKIN's bracelet design.
- Source: <https://cheme.stanford.edu/haptic-bracelet-mechanistic-understanding-wrist-worn-haptic-device>

**MIT Fifth Sense Project**
Low-cost, open-source wearable haptic array from MIT CSAIL. Developed a preliminary wearable waist/neck belt for spatial haptic feedback. Directly comparable in ambition: open-source, low-cost, wearable, multi-motor haptic array.
- Source: <https://projects.csail.mit.edu/bocelli/wha.html>

**Snaptics (Rice University / MAHI Lab)**
An open-source, low-cost, multi-sensory haptics platform designed for rapid prototyping of fully wearable haptic devices. Built from inexpensive and readily available components. Provides a strong precedent for HAPTIC.SKIN's open-source, affordable approach.
- Source: <https://mahilab.rice.edu/sites/default/files/publications/Snaptics_2021.pdf>

### 8.1.2 Maker / Open-Source Community Projects

**Wearable Haptic Bands (Hackster.io -- IdeaZero)**
Open-source multi-modal platform featuring multiple wearable haptic bands. Uses XIAO ESP32-C3 microcontrollers with ERM vibration motors, batteries, switches, LEDs, and 3D-printed components. Includes PCB design, ESP-NOW wireless communication, and a web app that converts audio/dance files to haptic PWM patterns. Full schematics, 3D printing files, and code are published. This is the closest community project to HAPTIC.SKIN in scope.
- Source: <https://www.hackster.io/IdeaZero/wearable-haptic-bands-12ea4c>

**PCA9685 ERM Haptic Driver Flex Module (Hackaday.io / Fyber Labs)**
A flex PCB module using the PCA9685 to drive up to 16 ERM motors via Darlington arrays (ULN2803A). Sold on Tindie. Directly validates the PCA9685 + ERM approach that HAPTIC.SKIN plans to use. Important finding: this project uses Darlington arrays because the PCA9685 can only source 10mA / sink 25mA per pin, which is insufficient for most ERM motors (typically 50-100mA).
- Source: <https://hackaday.io/project/2829-pca9685-erm-haptic-driver-flex-module>
- Tindie: <https://www.tindie.com/products/fyberlabs/16ch-erm-haptic-flex-module/>

**SenseShift / OpenHaptics (GitHub)**
Open-source firmware for DIY haptic vests and gloves, compatible with bHaptics-enabled VR games. Started as "OpenHaptics" in summer 2021, rebranded to SenseShift. Uses ESP32, supports multiple motor configurations. Hardware designs released under Creative Commons, firmware under GPL-3.0. Shows the viability of open-source haptic firmware ecosystems.
- Firmware: <https://github.com/senseshift/senseshift-firmware>
- Hardware: <https://github.com/openhaptics/openhaptics-hardware>
- Docs: <https://docs.senseshift.io/docs/about>

**OpenHaptics Firmware (Pfuggs)**
Another open-source firmware for wearable haptic-feedback devices for VR. Targets DIY haptic vests and gloves. GPL-3.0 licensed.
- Source: <https://github.com/Pfuggs/openhaptics-firmware>

**HapticHardware (JanThar, GitHub)**
Driver configurations for 16 vibration motors based on the Adafruit PCA9685 16-channel servo board. Designed for a haptic vest for visually impaired users (OpenVNAVI project). Directly relevant: same PCA9685 + 16 motors architecture as HAPTIC.SKIN.
- Source: <https://github.com/JanThar/HapticHardware>

**Haptic-Rehab-Device (GitHub)**
Real-time motion correction system for physical therapy using IMU sensors and haptic feedback. Combines gesture/motion detection with vibration motor output -- a bidirectional haptic system similar to HAPTIC.SKIN's concept.
- Source: <https://github.com/Customize5773/Haptic-Rehab-Device>

**Haptic Vest with 48 Motors (Hackaday Prize 2014)**
A Hackaday Prize semifinalist project using 48 vibration motors in a vest form factor. Demonstrates the complexity scaling challenges when increasing motor count.
- Source: <https://hackaday.com/2014/09/21/thp-semifinalist-a-haptic-vest-with-48-vibration-motors/>

### 8.1.3 Industry/Research Open-Source Platforms

**Google VHP (Vibrotactile Haptics Platform)**
Published at ACM UIST 2021. A low-power miniature board driving up to 12 independent haptic channels with arbitrary waveforms at 2 kHz. Battery-powered, 3-25 hours battery life. Used to build an audio-to-tactile bracelet for lipreading assistance. Hardware and software released under Apache 2.0 on GitHub. This is the gold standard for open-source haptic wearable platforms.
- Research blog: <https://research.google/blog/an-open-source-vibrotactile-haptics-platform-for-on-body-applications/>
- GitHub: <https://github.com/google/audio-to-tactile>
- Paper: <https://dl.acm.org/doi/10.1145/3472749.3474772>

### 8.1.4 Relevant Gesture Recognition Projects

**Embedded Sentry (MPU6050 + Arduino)**
Gesture recognition using a single MPU6050 accelerometer on Arduino. Records hand movement sequences as unlock gestures. Threshold-based approach. Demonstrates that basic gesture recognition with MPU6050 is achievable without ML.
- Source: <https://github.com/ninawekunal/Embedded-Sentry-MPU6050-Arduino>

**MPU6050 + ESP8266 Gesture Recognition**
Gesture recognition program combining MPU6050 sensor data with wireless communication.
- Source: <https://github.com/cookiestroke/Gesture-Recognition>

**Arduino TinyML Gesture Recognition**
Uses TensorFlow Lite Micro on Arduino with MPU6050 for gesture classification. Demonstrates that ML-based gesture recognition can run on microcontrollers, though adds significant complexity.
- Tutorial: <https://www.survivingwithandroid.com/arduino-tinyml-gesture-recognition-with-tensorflow-lite-micro/>
- Medium: <https://medium.com/swa-tutorials/arduino-tinyml-gesture-recognition-with-tensorflow-lite-micro-using-mpu6050-f9d4a11f17b5>

**Gesture Recognition Wearable (Hackaday.io)**
A wearable using IMU + ML on an Adafruit board with LSM6DSOX sensor.
- Source: <https://hackaday.io/project/173777/instructions>

### 8.1.5 Key Libraries and Tools for Pico + PCA9685

**PCA9685 MicroPython library for Pico**
A dedicated MicroPython library exists for driving the PCA9685 from a Raspberry Pi Pico over I2C.
- Source: <https://github.com/kevinmcaleer/pca9685_for_pico>
- Tutorial: <https://learn.adafruit.com/micropython-hardware-pca9685-pwm-and-servo-driver/micropython>

Note: The original Adafruit MicroPython PCA9685 library has been deprecated in favor of CircuitPython versions, but community forks for Pico exist.
- Deprecated original: <https://github.com/jposada202020/MicroPython_PCA9685>

---

## 8.2 Common Pitfalls

Based on forum discussions, project post-mortems, and technical documentation from the projects above, these are the most frequently encountered problems:

### 8.2.1 Power and Current Issues (CRITICAL)

**The PCA9685 cannot directly drive ERM motors.** This is the single most common mistake in haptic wearable builds. The PCA9685 PWM outputs can only source 10mA or sink 25mA per channel. Most ERM motors draw 50-100mA at rated voltage, with some pulling up to 75mA at 3V. Connecting motors directly to PCA9685 outputs will result in weak vibrations, erratic behavior, or damage to the IC.

**Solution:** Use external driver transistors between PCA9685 and motors. Options:
- **ULN2803A Darlington array** (8 channels, up to 500mA per channel) -- used by the Fyber Labs flex module. Two ULN2803A chips cover all 16 channels. Cost: ~1 EUR for two.
- **Individual N-channel MOSFETs** (e.g., 2N7000 or IRLZ44N) -- lower voltage drop than Darlingtons, better for battery operation.
- **TB6612 motor driver** -- 1.2A per channel, 3A peak, but only 2 channels per chip (expensive for 16 motors).

Sources:
- <https://forum.arduino.cc/t/help-with-pca9685-and-vibration-motors/1146634>
- <https://community.nxp.com/t5/-/-/m-p/713011> (motors burning out with PCA9685)
- <https://forum.arduino.cc/t/pca9685-eccentric-mass-motors-haptic-vest/847979>

**Flyback protection is mandatory.** ERM motors are inductive loads. When PWM switches off, the collapsing magnetic field generates voltage spikes (flyback) that can damage the driver IC. Always place a flyback diode (e.g., 1N4148) across each motor.

Source: <https://www.precisionmicrodrives.com/design-guidance-for-haptic-wearables>

**Power supply voltage drops under load.** Running 16 motors simultaneously can cause significant current draw (up to 1.2A total). If powered from USB, the 500mA limit will be exceeded. Symptoms: motors vibrate weakly, microcontroller resets, erratic I2C communication.

**Solution:** Use a dedicated external power supply for motors, separate from logic power. Add 100-470uF electrolytic capacitors across the motor power rail. Ensure common ground between logic and motor supplies.

Sources:
- <https://forum.arduino.cc/t/which-power-supply-for-a-pca9685/912767>
- <https://forum.arduino.cc/t/pwm-servo-driver-pca9685-doubt-with-current-and-volt-supply/548163>

### 8.2.2 I2C Communication Problems

**I2C bus reliability degrades with wire length.** In a wearable spanning neck to wrists, I2C wires can be 30-60cm. This causes signal integrity issues (ringing, crosstalk), leading to communication errors.

**Solutions:**
- Keep I2C wires as short as possible; use appropriate pull-up resistor values (2.2k-4.7k ohm).
- Use shielded cable or twisted pairs for SDA/SCL.
- Reduce I2C clock speed from 400kHz to 100kHz for longer runs.
- Consider I2C bus extenders for runs over 50cm.

**Daisy-chain failure propagation.** If one device on the I2C bus shorts or fails, it can take down the entire bus. In a wearable context, a broken wire to one bracelet kills communication with all devices.

Source: <https://www.precisionmicrodrives.com/design-guidance-for-haptic-wearables>

### 8.2.3 Motor Placement and Mechanical Issues

**Vibration coupling between adjacent motors.** If motors are mounted too close together on a rigid surface, their vibrations blend and users cannot distinguish individual positions. Minimum recommended spacing depends on body location:
- Wrist: ~20-25mm minimum spacing
- Neck: ~25-30mm minimum spacing

**Motor mounting affects perception.** Motors must be firmly pressed against skin. Loose mounting dramatically reduces perceived vibration intensity. Elastic bands with pockets or direct skin-adhesive mounting work best. 3D-printed rigid housings often create air gaps that attenuate vibration.

**Wire fatigue at joints.** Wires at wrist joints experience repeated bending. Standard hookup wire will fatigue and break within days of use. Use stranded silicone wire or flex PCBs at stress points.

### 8.2.4 Software Pitfalls

**Latency accumulation.** The chain PC -> USB serial -> Pico -> I2C -> PCA9685 -> motor introduces latency at each hop. USB serial alone can add 1-16ms depending on buffer settings. I2C transactions for 16 channels take time. Total latency from API call to motor activation can reach 20-50ms, which is noticeable for real-time feedback.

**Mitigation:** Use high baud rates (115200+), minimize USB serial buffer sizes, batch I2C writes, pre-load patterns on the Pico rather than streaming individual motor commands.

**Gesture recognition false positives.** Threshold-based gesture detection on IMU data is simple to implement but prone to false triggers during normal movement (walking, typing). ML-based approaches are more accurate but significantly harder to implement and train.

**Recommendation for a 3-month project:** Start with simple threshold-based detection for 3-4 discrete gestures (raise, shake, tilt left, tilt right). Avoid ML unless the team has prior experience.

Sources:
- <https://eloquentarduino.github.io/2019/12/how-to-do-gesture-identification-on-arduino/>
- <https://www.survivingwithandroid.com/arduino-tinyml-gesture-recognition-with-tensorflow-lite-micro/>

### 8.2.5 Scope Creep

Multiple Hackaday and student projects show a pattern of over-ambition:
- Starting with too many motors (16 is already ambitious; several projects started with 48 and scaled down)
- Trying to implement wireless communication early (adds weeks of debugging)
- Adding features before the basic pipeline works

**Recommendation:** Get ONE motor vibrating from a Python one-liner before scaling to 16. Build vertically (full stack for 1 motor), then scale horizontally.

---

## 8.3 Timeline Realism

### 8.3.1 Comparable Project Timelines

| Project | Scope | Team | Duration | Notes |
|---------|-------|------|----------|-------|
| Wearable Haptic Bands (Hackster.io) | Multi-band, ESP32, ERM, PCB, web app | Small team | Several months | Includes custom PCB and 3D printing |
| SenseShift | Haptic vest firmware, ESP32, bHaptics-compatible | 1-2 developers | Started summer 2021, ongoing | Firmware-only (no hardware design) took months to stabilize |
| PCA9685 Flex Module (Fyber Labs) | 16-ch ERM driver flex PCB | 1 person | ~2-3 months for PCB | Hardware module only, no software stack |
| Google VHP | 12-ch haptic platform, custom board, firmware, apps | Google research team | ~1 year to publication | Professional team, custom PCB, peer-reviewed |
| HapConnect | Educational haptic wearable | University lab + students | 1 semester (~4 months) | Designed to be student-buildable |
| Haptic-Rehab-Device | IMU + vibration motors, rehab application | Small team | ~2-3 months | Limited motor count, simpler form factor |

### 8.3.2 Assessment: Is 3 Months Realistic for HAPTIC.SKIN?

**Verdict: Realistic with aggressive scope management. Tight but achievable for the core system. Full vision (all features polished) is not realistic in 3 months.**

**What is achievable in 3 months (13 sessions):**
- 1 working wearable (bracelet) with 4-6 ERM motors driven by PCA9685 + Darlington array
- Basic Pico firmware controlling motors via I2C
- USB serial communication to PC
- Python daemon with simple REST API
- 3-4 predefined vibration patterns
- Basic threshold-based gesture recognition on 1 IMU
- Functional demo at defense

**What is risky in 3 months:**
- All 3 wearables (necklace + 2 bracelets) fully working and comfortable to wear
- 16 motors all individually addressable with reliable I2C across the full cable run
- Polished gesture recognition with low false-positive rate
- Custom PCB (design + fabrication + assembly + debugging takes 4-6 weeks minimum)

**What is unrealistic in 3 months:**
- ML-based gesture recognition trained on custom dataset
- Wireless communication between wearables
- Production-quality enclosures and bands
- Comprehensive pattern library with complex sequencing

### 8.3.3 Recommended Phasing

**Weeks 1-4 (April 10 - May 7): Foundation**
- Order all components immediately (allow 1-2 weeks for delivery)
- Build breadboard prototype: Pico + PCA9685 + ULN2803A + 1 motor
- Write MicroPython firmware for single motor control
- Establish USB serial protocol
- Write minimal Python daemon
- Deliverable: One motor vibrating from a Python one-liner

**Weeks 5-8 (May 8 - June 4): Scale and Integrate**
- Scale to 8-16 motors on breadboard
- Build first wearable form factor (one bracelet)
- Add MPU6050 and basic gesture detection
- Implement pattern engine (at least 5 patterns)
- REST API with basic endpoints
- Deliverable: One bracelet with vibration + gesture working

**Weeks 9-12 (June 5 - July 2): Polish and Demo**
- Build remaining wearables (second bracelet + necklace, even if simplified)
- End-to-end demo scenario
- Bug fixing and reliability testing
- Documentation and poster preparation
- Deliverable: Working demo for defense

### 8.3.4 Critical Path Items

1. **Component ordering** -- must happen in week 1. Late orders eat directly into build time.
2. **PCA9685 + motor driver circuit** -- this is the highest-risk hardware component. If the driver circuit does not work, nothing else matters. Prototype this first.
3. **USB serial reliability** -- if serial communication is flaky, the entire software stack is unreliable. Test early with sustained data transfer.
4. **Wearable form factor** -- 3D printing and fitting takes longer than expected. Start designing in week 3-4, iterate.

### 8.3.5 Risk Mitigations from Similar Projects

- **Order spare components.** At these prices, buy 2x of everything. A dead PCA9685 or Pico costs days of debugging before you realize it is hardware failure.
- **Use breakout boards, not bare ICs.** At this timeline, soldering QFP packages is a time sink. Adafruit/generic PCA9685 breakout boards cost 3-5 EUR and work immediately.
- **Start with perfboard, not custom PCB.** Custom PCBs (even from JLCPCB) take 2-3 weeks including shipping. Perfboard with point-to-point wiring is ugly but fast. Reserve PCB for a v2 if time allows.
- **Test with a desk setup before making it wearable.** Many projects report spending weeks on enclosure/mounting issues. Get the electronics working on a desk first.

---

Sources referenced in this section:
- [Tasbi - Rice MAHI Lab](https://mahilab.rice.edu/sites/default/files/publications/tasbi_whc2019.pdf)
- [Rice WRIST team prize](https://news.rice.edu/news/2025/rice-students-win-top-prize-global-design-contest-cutting-edge-haptic-wristband)
- [HapConnect - ASEE](https://peer.asee.org/board-134-the-hapconnect-teaching-about-haptics-and-inclusive-design-with-modular-wearable-technology.pdf)
- [Stanford Haptic Bracelet](https://cheme.stanford.edu/haptic-bracelet-mechanistic-understanding-wrist-worn-haptic-device)
- [MIT Fifth Sense](https://projects.csail.mit.edu/bocelli/wha.html)
- [Snaptics](https://mahilab.rice.edu/sites/default/files/publications/Snaptics_2021.pdf)
- [Wearable Haptic Bands - Hackster.io](https://www.hackster.io/IdeaZero/wearable-haptic-bands-12ea4c)
- [PCA9685 ERM Flex Module - Hackaday.io](https://hackaday.io/project/2829-pca9685-erm-haptic-driver-flex-module)
- [SenseShift firmware](https://github.com/senseshift/senseshift-firmware)
- [SenseShift hardware](https://github.com/openhaptics/openhaptics-hardware)
- [OpenHaptics firmware](https://github.com/Pfuggs/openhaptics-firmware)
- [HapticHardware - OpenVNAVI](https://github.com/JanThar/HapticHardware)
- [Haptic-Rehab-Device](https://github.com/Customize5773/Haptic-Rehab-Device)
- [Haptic Vest 48 motors - Hackaday](https://hackaday.com/2014/09/21/thp-semifinalist-a-haptic-vest-with-48-vibration-motors/)
- [Google VHP blog](https://research.google/blog/an-open-source-vibrotactile-haptics-platform-for-on-body-applications/)
- [Google VHP GitHub](https://github.com/google/audio-to-tactile)
- [Google VHP paper](https://dl.acm.org/doi/10.1145/3472749.3474772)
- [Embedded Sentry - MPU6050 gestures](https://github.com/ninawekunal/Embedded-Sentry-MPU6050-Arduino)
- [MPU6050 ESP8266 gestures](https://github.com/cookiestroke/Gesture-Recognition)
- [TinyML gesture recognition](https://www.survivingwithandroid.com/arduino-tinyml-gesture-recognition-with-tensorflow-lite-micro/)
- [Eloquent Arduino gesture ID](https://eloquentarduino.github.io/2019/12/how-to-do-gesture-identification-on-arduino/)
- [Gesture Recognition Wearable - Hackaday.io](https://hackaday.io/project/173777/instructions)
- [PCA9685 for Pico MicroPython](https://github.com/kevinmcaleer/pca9685_for_pico)
- [Adafruit PCA9685 MicroPython guide](https://learn.adafruit.com/micropython-hardware-pca9685-pwm-and-servo-driver/micropython)
- [PCA9685 + vibration motors - Arduino Forum](https://forum.arduino.cc/t/help-with-pca9685-and-vibration-motors/1146634)
- [Motors burning out with PCA9685 - NXP](https://community.nxp.com/t5/-/-/m-p/713011)
- [PCA9685 + ERM haptic vest - Arduino Forum](https://forum.arduino.cc/t/pca9685-eccentric-mass-motors-haptic-vest/847979)
- [Precision Microdrives design guidance](https://www.precisionmicrodrives.com/design-guidance-for-haptic-wearables)
- [PCA9685 power supply - Arduino Forum](https://forum.arduino.cc/t/which-power-supply-for-a-pca9685/912767)
- [Fyber Labs Tindie module](https://www.tindie.com/products/fyberlabs/16ch-erm-haptic-flex-module/)
- [SenseShift docs](https://docs.senseshift.io/docs/about)
