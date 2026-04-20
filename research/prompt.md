# MEGA-PROMPT: Deep Research for HAPTIC.SKIN Project

Read the CLAUDE.md in this directory for full project context. Then execute the following research plan by launching **all agents in parallel**. Each agent explores a different axis. Once all agents return, compile everything into a single structured Markdown document (`research-report.md`) ready for PDF export via pandoc.

---

## RESEARCH AGENTS TO LAUNCH (all in parallel)

### Agent 1 — State of the Art: Haptic Wearables
Search the web exhaustively for:
- Existing haptic wearable products (bHaptics, Teslasuit, Woojer, Subpac, OWO Game, SenseGlove, HaptX, Lofelt)
- Open-source haptic projects on GitHub, Hackaday, Instructables
- Research papers on wearable haptic feedback (IEEE, ACM, arXiv)
- Patents in the field (Google Patents)
- What vibration patterns exist (linear resonant actuators vs ERM vs piezo)
- Current limitations and unsolved problems
- Price comparison table of all existing solutions

### Agent 2 — Hardware Deep Dive
Research and compare:
- Raspberry Pi Pico vs Pico W vs ESP32 vs STM32 for this use case
- ERM motors vs LRA vs piezoelectric actuators: pros/cons/specs for wearables
- PCA9685 vs TLC5940 vs direct GPIO PWM multiplexing
- MPU6050 vs BMI160 vs LSM6DS3 for gesture recognition IMU
- Power options: USB-powered vs battery (LiPo), autonomy calculations
- PCB design considerations for flexible/wearable circuits
- Connector types for wearable electronics
- 3D printing vs silicone molding vs fabric integration for bands
- What is realistically achievable in 3 months with <100EUR budget

### Agent 3 — Software Architecture
Research:
- Existing haptic SDKs and APIs (OpenHaptics, CHAI3D, bHaptics SDK, Lofelt SDK)
- Best practices for real-time haptic daemon design on Linux
- USB serial communication protocols and latency benchmarks (pyserial vs libusb)
- Pattern engines: how to define and sequence haptic patterns (timeline-based, event-based)
- Gesture recognition algorithms for IMU data (threshold-based, DTW, simple ML classifiers)
- Integration examples: how other platforms let developers trigger haptic events
- REST vs WebSocket vs Unix socket vs D-Bus for local IPC

### Agent 4 — Use Cases & Applications
Research concrete applications in depth:
- Accessibility: haptic aids for visually impaired (existing products, research, what works)
- Navigation: haptic navigation systems (Wayband, Feel The Way, research prototypes)
- Gaming/VR: haptic feedback integration patterns, Unity/Godot haptic APIs
- Music/Art: haptic music experiences, sonification-to-vibration mapping
- Health/Medical: haptic biofeedback, posture correction, rehabilitation
- Communication: tactile languages (Tadoma, vibrotactile Braille, skin-reading research)
- Industrial: silent alerts for noisy environments, equipment operators
- Military/emergency: tactical haptic communication systems
- Rank each use case by: feasibility for demo, wow factor for jury, social impact, technical complexity

### Agent 5 — Market & Business Analysis
Research:
- Haptic technology market size, growth projections, key players
- Wearable technology market trends 2024-2028
- Open-source hardware business models (Adafruit, SparkFun, Arduino model)
- Potential target markets for an open-source haptic platform
- Pricing strategy: cost breakdown vs potential selling price
- Competitor SWOT analysis (bHaptics, OWO, Teslasuit vs HAPTIC.SKIN)
- Crowdfunding examples of haptic/wearable projects (Kickstarter, Indiegogo stats)
- EU/French regulations for wearable electronic devices (CE marking, REACH)

### Agent 6 — Scientific & Academic Angle
Research:
- Key academic labs working on haptic wearables (MIT Media Lab, Bristol Interaction Group, etc.)
- TRL scale: what level is this project and how to document progression
- Haptic perception science: two-point discrimination threshold, vibrotactile frequency sensitivity, body regions sensitivity map
- Weber's law applied to vibration intensity perception
- Phantom sensations and haptic illusions (creating apparent motion with discrete motors)
- How many actuators are needed for meaningful spatial resolution on neck/wrist
- Psychophysics of vibrotactile feedback: what frequencies/amplitudes feel best

### Agent 7 — Eco-Design & Sustainability
Research (this is a mandatory focus in the EFREI program):
- Environmental impact of wearable electronics (lifecycle analysis)
- Eco-design principles applicable to this project
- Sustainable material choices for wearable bands
- Repairability and modularity as design principles
- Energy consumption comparison: this project vs commercial alternatives
- E-waste considerations for small electronics projects
- Green IT certifications and frameworks relevant to hardware projects
- How to frame eco-design in the project report convincingly

### Agent 8 — Similar Student/Academic Projects
Search for:
- University projects building haptic wearables (theses, capstone projects, hackathon entries)
- Instructables/Hackaday haptic wearable builds with documentation
- What worked, what failed, common pitfalls
- GitHub repos of similar scope (haptic + Pico/Arduino + Python)
- Blog posts or YouTube videos documenting similar builds
- Timeline estimates from similar projects (is 3 months realistic?)

---

## OUTPUT FORMAT

Compile ALL findings into `research-report.md` with this structure:

```markdown
---
title: "HAPTIC.SKIN — Research Report"
subtitle: "Deep Analysis for Innovation Project EFREI ING2 2025-2026"
date: 2026-04-08
author: "Marc-Alexis"
geometry: margin=2.5cm
fontsize: 11pt
toc: true
numbersections: true
---

# Executive Summary
(1 page max summarizing key findings and recommendations)

# 1. State of the Art
## 1.1 Commercial Products
## 1.2 Open-Source Projects
## 1.3 Academic Research
## 1.4 Competitor Comparison Table
## 1.5 Identified Gaps

# 2. Hardware Analysis
## 2.1 Microcontroller Comparison
## 2.2 Actuator Technology Comparison
## 2.3 IMU Sensor Options
## 2.4 Power Architecture
## 2.5 Mechanical Design Options
## 2.6 Bill of Materials (final recommendation)
## 2.7 Feasibility Assessment (3 months, <100EUR)

# 3. Software Architecture
## 3.1 Existing SDKs & APIs Review
## 3.2 Recommended Architecture
## 3.3 Communication Protocol Analysis
## 3.4 Pattern Engine Design
## 3.5 Gesture Recognition Approaches

# 4. Use Cases & Applications
## 4.1 Accessibility
## 4.2 Navigation
## 4.3 Gaming & VR
## 4.4 Music & Art
## 4.5 Health & Medical
## 4.6 Communication
## 4.7 Industrial & Military
## 4.8 Use Case Ranking Matrix

# 5. Market Analysis
## 5.1 Market Size & Trends
## 5.2 Target Segments
## 5.3 SWOT Analysis
## 5.4 Business Model Options
## 5.5 Regulatory Considerations

# 6. Scientific Foundations
## 6.1 Haptic Perception Science
## 6.2 Optimal Actuator Placement
## 6.3 TRL Assessment
## 6.4 Key Academic References

# 7. Eco-Design & Sustainability
## 7.1 Environmental Impact Analysis
## 7.2 Sustainable Design Choices
## 7.3 Energy & Lifecycle Considerations

# 8. Lessons from Similar Projects
## 8.1 Student/Academic Projects Review
## 8.2 Common Pitfalls
## 8.3 Timeline Realism

# 9. Recommendations & Next Steps
## 9.1 Recommended Technical Direction
## 9.2 Recommended Demo Use Case
## 9.3 Risk Matrix
## 9.4 Suggested Sprint Plan (13 sessions)

# References
(all URLs, papers, products cited)
```

Make sure every claim has a source URL. Use tables for comparisons. Be factual, not speculative. If something is uncertain, say so. The document should be directly convertible to PDF with `pandoc research-report.md -o research-report.pdf --pdf-engine=xelatex`.
