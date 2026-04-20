# 6. Scientific Foundations

## 6.1 Haptic Perception Science

### 6.1.1 Mechanoreceptor Channels

Human skin contains four types of mechanoreceptors, organized into two key channels for vibrotactile perception:

| Channel | Receptor | Location | Frequency Range | Function |
|---------|----------|----------|----------------|----------|
| RA (FAI) | Meissner corpuscle | Superficial, glabrous skin | 10--50 Hz | Flutter, light touch, low-freq vibration |
| PC (FAII) | Pacinian corpuscle | Deep dermis, widespread | 40--1000 Hz (peak ~200--300 Hz) | High-frequency vibration, pressure changes |
| SA I | Merkel disk | Superficial | Static--5 Hz | Sustained pressure, texture |
| SA II | Ruffini ending | Deep | Static--? | Skin stretch, joint position |

For vibrotactile wearables like HAPTIC.SKIN, the two relevant channels are RA (Meissner) and PC (Pacinian). The Pacinian channel has the lowest absolute detection threshold, peaking in sensitivity around 200--300 Hz, while the RA channel dominates perception below ~50 Hz.

**Source:** Bolanowski et al. (1988), "Four channels mediate the mechanical aspects of touch," *J. Acoust. Soc. Am.*, 84(5), 1680--1694. Also: [Tactile sensory channels -- eLife](https://elifesciences.org/articles/46510)

### 6.1.2 Vibrotactile Frequency Sensitivity

Human skin sensitivity to vibration follows a U-shaped curve (inverted) when plotted as threshold vs. frequency:

- **Below 40 Hz**: Detection thresholds are high (~100 um displacement). Perception mediated by Meissner corpuscles (RA channel).
- **40--80 Hz**: Transition zone where both RA and PC channels contribute.
- **80--300 Hz**: Lowest detection thresholds (~0.1--1 um at 200--250 Hz). Pacinian corpuscle dominance. This is the "sweet spot" for vibrotactile perception.
- **Above 300 Hz**: Thresholds rise again; perceptual benefit diminishes.

For wearable design, the practical optimal range is **100--250 Hz**, with peak perceptual sensitivity around **150--200 Hz** on hairy skin (wrist, neck). Research on wrist-specific thresholds found maximum sensitivity at 100--275 Hz (peaking at 200 Hz) for the volar (inside) wrist and 75--250 Hz (peaking at 125 Hz) for the dorsal (outside) wrist.

**Sources:**
- [Vibrotactile Threshold Measurements at the Wrist -- ACM TAP](https://dl.acm.org/doi/10.1145/3529259)
- [Improving Wearable Haptics Through Measuring Vibrotactile Sensitivity -- JUS](https://uxpajournal.org/wearable-haptics-vibrotactile/)
- Verrillo (1963), "Effect of contactor area on the vibrotactile threshold," *J. Acoust. Soc. Am.*

### 6.1.3 Two-Point Discrimination Thresholds

The two-point discrimination (2PD) threshold is the minimum distance at which two simultaneous touches are perceived as distinct. For vibrotactile stimuli, these thresholds are significantly larger than for static pressure:

| Body Region | Static 2PD Threshold | Vibrotactile 2PD Threshold | Notes |
|-------------|---------------------|---------------------------|-------|
| Fingertip | 2--3 mm | 5--10 mm | Highest receptor density |
| Palm | 8--12 mm | ~15--20 mm | Good resolution |
| Volar forearm | 25--40 mm | 40--90 mm | Moderate; orientation matters |
| Dorsal wrist | 25--35 mm | ~40--60 mm | Hairy skin, lower density |
| Neck (posterior) | 25--30 mm | ~30--40 mm | Moderate acuity |
| Torso (abdomen) | 30--40 mm | 20--40 mm (varies by axis) | Better near midline (~10 mm horizontal) |

**Key implication for HAPTIC.SKIN:** On the wrist (circumference ~150--180 mm), spacing 4 motors at ~40 mm apart aligns well with vibrotactile 2PD thresholds, allowing reliable localization. On the neck (circumference ~350--400 mm), 8 motors at ~45 mm spacing is within the threshold range for spatial discrimination, though localization to the exact motor may be difficult -- users reliably identify the correct region (within 1 motor).

**Sources:**
- Weinstein (1968), "Intensive and extensive aspects of tactile sensitivity as a function of body part, sex, and laterality," in *The Skin Senses*
- [Two-Point Discrimination of Vibrotactile Stimuli on the Forearm -- ACM](https://dl.acm.org/doi/10.1145/3743721)
- [Tactile spatial discrimination on the torso -- PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC8541989/)
- [Measuring the spatial acuity of vibrotactile stimuli -- arXiv](https://arxiv.org/pdf/2308.05497)

### 6.1.4 Weber's Law and Vibrotactile Intensity

Weber's Law states that the just noticeable difference (JND) in stimulus intensity is a constant proportion of the reference intensity:

> Delta I / I = k (Weber fraction)

For vibrotactile amplitude perception:

- **Weber fraction for vibration amplitude: ~0.17--0.21** (17--21%)
- At 100 Hz: JND is ~21% of reference amplitude
- At 150 Hz and above: JND drops to ~17%
- The law holds well across a wide range of suprathreshold intensities

**Practical design implication:** To create perceptibly distinct intensity levels, each step must differ by at least 20%. With ERM motors, this means:

| Perceived Levels | Min Amplitude Ratio (step = 20%) | Usable Distinct Steps |
|-----------------|--------------------------------|----------------------|
| Level 1 | 1.0 (baseline) | Minimum perceivable |
| Level 2 | 1.2x | Clearly different |
| Level 3 | 1.44x | Strong |
| Level 4 | 1.73x | Very strong |
| Level 5 | 2.07x | Maximum |

This gives approximately **4--5 reliably distinguishable intensity levels** across the dynamic range of a typical ERM motor, which is sufficient for HAPTIC.SKIN's notification encoding.

**Sources:**
- [Vibrotactile amplitude discrimination follows Weber's Law -- PubMed](https://pubmed.ncbi.nlm.nih.gov/18651137/)
- [Vibrotactile perception: coding and JND -- Springer](https://link.springer.com/article/10.1007/s00530-007-0105-x)
- Craig (1972), "Difference threshold for intensity of tactile stimuli," *Perception & Psychophysics*

### 6.1.5 Phantom Sensations and Haptic Illusions

Three key tactile illusions allow a sparse array of actuators to create richer perceptual experiences than the physical motor count suggests:

**Phantom Sensation (Funneling Illusion)**
When two actuators vibrate simultaneously with varying relative amplitudes, the perceived location shifts continuously between them. By modulating the amplitude ratio, a single "phantom" point can be placed anywhere along the line connecting two motors. This effectively multiplies spatial resolution.

- With 4 physical motors on a wrist band, phantom sensation can create the perception of **8 distinct locations**
- Works best when inter-actuator distance is < 60 mm on the forearm

**Apparent Tactile Motion (Phi Phenomenon)**
Sequential activation of neighboring actuators with appropriate timing (SOA: 50--200 ms between onsets) creates the illusion of a point "moving" across the skin. This is the tactile equivalent of a moving light on a marquee.

- Optimal stimulus onset asynchrony (SOA): 70--150 ms for smooth motion
- Duration of each stimulus: 50--100 ms
- Used for directional cues (e.g., "swipe left" sensation)

**Sensory Saltation (Cutaneous Rabbit)**
Brief sequential taps at location A followed by taps at location B create the illusion of evenly spaced taps "hopping" between A and B, even at locations where no actuator exists. Discovered by Geldard & Sherrick (1972).

- Works with 2--3 taps per location
- Inter-tap interval: 50--150 ms
- Creates perceived stimulation at phantom intermediate positions

**Implication for HAPTIC.SKIN:** These illusions are essential design tools. With 8 physical motors on the necklace, phantom sensation and apparent motion can produce the perceptual equivalent of 16+ distinguishable positions, enabling directional "swipe" patterns around the neck and smooth motion effects with only discrete actuators.

**Sources:**
- [Phantom sensation threshold and quality -- ScienceDirect](https://www.sciencedirect.com/science/article/pii/S0141938224000404)
- [Tactile Information Transmission by 2D Stationary Phantom Sensations -- CHI 2018](https://dl.acm.org/doi/10.1145/3173574.3173832)
- [Body-Penetrating Tactile Phantom Sensations -- CHI 2020](https://dl.acm.org/doi/fullHtml/10.1145/3313831.3376619)
- Geldard & Sherrick (1972), "The cutaneous rabbit: A perceptual illusion," *Science*, 178(4057), 178--179
- [Sensory Saltation and Phantom Sensation for Vibrotactile Display -- ResearchGate](https://www.researchgate.net/publication/254926123)

---

## 6.2 Optimal Actuator Placement

### 6.2.1 Neck (Necklace) -- 8 Motors Recommended

The neck is a favorable body site for vibrotactile feedback due to moderate spatial acuity and high social discretion.

**Prior work -- Haptic Collar (Schaack et al., 2019):**
Tested 4, 6, and 8 actuators arranged circumferentially around the neck for directional guidance. Key findings:
- **8 actuators** achieved **up to 95% direction recognition** for 8 cardinal/intercardinal directions across 528 triggers
- 6 actuators could encode 8 directions using phantom sensation, but with lower accuracy
- 4 actuators limited to 4-direction encoding without illusions
- Spacing of ~45 mm between motors (for average neck circumference ~360 mm) is at or slightly above the vibrotactile 2PD threshold
- Users could reliably identify the stimulus area even if not the exact motor

**Prior work -- HapticPointer (Rekimoto Lab):**
A necklace with **16 vibration motors** on a flexible string, used for remote collaboration directional cues. This is remarkably close to HAPTIC.SKIN's design. The system uses intensity modulation across motors to encode both horizontal and vertical direction information.

**Recommendation for HAPTIC.SKIN necklace (8 ERM motors):**
- 8 motors spaced evenly at ~45 mm intervals around the neck
- Use phantom sensation to interpolate to 16 perceived positions
- Use apparent motion for directional "flow" patterns
- Avoid placing motors directly on the trachea (front center) -- use slight lateral offset
- Posterior neck has slightly better acuity; bias more motors toward the back if asymmetric placement is considered

**Sources:**
- [Haptic Collar: Vibrotactile Feedback around the Neck -- ACM](https://dl.acm.org/doi/10.1145/3311823.3311840)
- [HaptiCollar: Investigating Tactile Acuity on the Neck -- ResearchGate](https://www.researchgate.net/publication/368824228)
- [HapticPointer -- Rekimoto Lab](https://lab.rekimoto.org/projects/hapticpointer/)

### 6.2.2 Wrist (Bracelets) -- 4 Motors Each Recommended

The wrist has moderate vibrotactile acuity and is an established site for wearable haptics.

**Prior work -- Angular accuracy studies (Hong et al., 2016, U. Washington):**
- 4-motor wristband at 0, 90, 180, 270 degrees achieves ~90.6% localization accuracy
- 8-motor configuration was slower and less preferred by users, despite finer resolution
- Single-motor activation with 4 motors was faster, more accurate, and most preferred compared to 8 motors

**Prior work -- Tasbi (Rice University, MAHI Lab):**
A multimodal haptic bracelet combining squeeze and vibrotactile feedback, demonstrating that wrist-worn devices benefit from combining modalities rather than simply adding more motors.

**Prior work -- 8-tactor cuboid wristband:**
Using phantom sensation with 8 actuators on the wrist, researchers could encode **up to 26 directions** in 3D space. However, this requires precise amplitude control not easily achievable with basic ERM motors.

**Recommendation for HAPTIC.SKIN bracelets (4 ERM motors each):**
- 4 motors at cardinal positions (dorsal, volar, ulnar, radial)
- Sufficient for 4-direction encoding with >90% accuracy
- Use phantom sensation between adjacent motors for 8-direction interpolation
- Volar (inner) wrist position most sensitive; consider biasing notification motor to this location
- Keep IMU (MPU6050) on the dorsal side for best gesture recognition (less soft tissue interference)
- Total: 4 motors + 1 IMU per bracelet

**Sources:**
- [Evaluating Angular Accuracy of Wrist-based Haptic Directional Guidance -- GI 2016](https://makeabilitylab.cs.washington.edu/media/publications/Hong_EvaluatingAngularAccuracyOfWristBasedHapticDirectionalGuidanceForHandMovement_GI2016.pdf)
- [Tasbi: Multisensory Squeeze and Vibrotactile Wrist Haptics -- Rice MAHI Lab](https://mahilab.rice.edu/sites/default/files/publications/tasbi_whc2019.pdf)
- [Design of Vibrotactile Direction Feedbacks on Wrist -- Springer](https://link.springer.com/chapter/10.1007/978-3-030-49788-0_13)

### 6.2.3 Motor Count Summary

| Wearable | Motors | Spacing | Physical Directions | With Phantom Sensation |
|----------|--------|---------|--------------------|-----------------------|
| Necklace | 8 | ~45 mm | 8 | 16 |
| Left bracelet | 4 | ~40 mm | 4 | 8 |
| Right bracelet | 4 | ~40 mm | 4 | 8 |
| **Total** | **16** | -- | **16** | **32** |

This 16-motor architecture is well-justified by the psychophysical literature: it sits at the practical limit where adding more motors would not improve perceptual resolution (given ERM motor characteristics and vibrotactile 2PD thresholds at these body sites), while fewer motors would sacrifice meaningful spatial information.

### 6.2.4 ERM Motor Characteristics and Limitations

ERM motors couple frequency and amplitude (spinning faster = stronger vibration AND higher frequency). This limits fine control compared to LRAs or piezoelectric actuators.

| Parameter | Typical ERM Spec | Perceptual Impact |
|-----------|-----------------|-------------------|
| Frequency range | 80--250 Hz | Covers the peak sensitivity zone |
| Rise time | 30--50 ms | Slow compared to LRA (~5 ms); limits temporal resolution |
| Amplitude control | Via PWM duty cycle | ~4--5 distinguishable intensity levels (Weber's Law) |
| Size (coin type) | 8--12 mm diameter | Fits wrist/neck band well |
| Power | 60--100 mA each | 16 motors = ~1--1.6 A total (USB-powered feasible) |

Despite their limitations, ERMs are the correct choice for HAPTIC.SKIN at this stage: low cost (~0.50 EUR each), simple drive circuit (PCA9685 PWM), no resonance tuning needed, and sufficient for the spatial/temporal resolution achievable on neck and wrist.

**Sources:**
- [ERM Vibration Motor overview -- MicroDcMotors](https://microdcmotors.com/erm-vibration-motor)
- [Haptics components: LRA, ERM, and piezo -- Power Electronic Tips](https://www.powerelectronictips.com/haptics-components-pt-1-lra-erm-and-piezo-actuators/)
- [Driving Haptic Vibration in Wearables -- Altium](https://resources.altium.com/p/driving-haptic-vibration-and-feedback-wearables)

---

## 6.3 TRL Assessment

### 6.3.1 Technology Readiness Level Scale

The TRL scale (NASA, 1989; adopted by EU Horizon framework) measures technology maturity from basic research (TRL 1) to flight-proven system (TRL 9):

| TRL | Definition | Evidence Required |
|-----|-----------|------------------|
| 1 | Basic principles observed | Published research identifying principles |
| 2 | Technology concept formulated | Practical application identified, speculative |
| 3 | Experimental proof of concept | Analytical/lab studies validating predictions |
| 4 | Technology validated in lab | Component integration in lab environment |
| 5 | Technology validated in relevant environment | Integrated components tested in simulated environment |
| 6 | Technology demonstrated in relevant environment | Prototype demo in representative conditions |
| 7 | System prototype demonstrated in operational environment | Near-final prototype tested by users in real conditions |
| 8 | System complete and qualified | Final product tested and approved |
| 9 | Actual system proven in operational environment | Deployed and proven in the field |

**Source:** [Technology Readiness Levels -- NASA](https://www.nasa.gov/directorates/somd/space-communications-navigation-program/technology-readiness-levels/) and [EU TRL definitions -- EURAXESS](https://euraxess.ec.europa.eu/career-development/researchers/manual-scientific-entrepreneurship/major-steps/trl)

### 6.3.2 HAPTIC.SKIN Current TRL Assessment

**Current status: TRL 2 (Technology concept formulated)**

| Criterion | Status | Evidence |
|-----------|--------|----------|
| Basic principles identified | Done | Vibrotactile perception science well-established |
| Practical application identified | Done | Silent notification, gesture response, navigation |
| Component-level feasibility known | Partial | All components (Pico, PCA9685, ERM, MPU6050) are proven individually |
| Integrated proof of concept | Not yet | No integrated prototype exists |

### 6.3.3 Target TRL Progression

| Date | Target TRL | Milestone | Evidence to Produce |
|------|-----------|-----------|-------------------|
| April 2026 (now) | TRL 2 | Concept and state of the art complete | This research report, specifications document |
| May 2026 | TRL 3 | Experimental proof of concept | Single motor + Pico + PCA9685 driving vibration patterns; IMU reading gestures on breadboard |
| June 2026 | TRL 4 | Lab validation | All 16 motors integrated, daemon running, basic API functional; tested on bench |
| Late June 2026 | TRL 5 | Relevant environment validation | Wearable bands fabricated, system worn by test users, gesture recognition working |
| July 2026 (defense) | TRL 5--6 | Prototype demo | Full system demonstrated on a human subject performing defined use case (e.g., navigation, notification) |

**Reaching TRL 6 by defense is ambitious but feasible** if the team maintains focus. TRL 6 requires demonstration in a representative environment (i.e., a person wearing the device and performing real tasks, not just lab bench tests).

### 6.3.4 How to Document TRL Progression

For the EFREI report, document each TRL transition with:

1. **Test description**: What was tested, under what conditions
2. **Results**: Quantitative where possible (recognition accuracy, latency, user comfort ratings)
3. **Photos/video**: Visual evidence of prototype at each stage
4. **Delta from previous TRL**: What changed since the last assessment
5. **Risks identified**: What could prevent reaching the next level

**Source:** [Technology Readiness Assessment Guidebook -- DoD (Feb 2025)](https://www.cto.mil/wp-content/uploads/2025/03/TRA-Guide-Feb2025.v2-Cleared.pdf)

---

## 6.4 Key Academic References

### 6.4.1 Major Research Labs

| Lab | Institution | Focus | Key Contributions |
|-----|------------|-------|-------------------|
| **Tangible Media Group** | MIT Media Lab | Shape-changing interfaces, tactile displays | Haptic Edge Display (24--40 pin tactile array), inFORCE shape display |
| **CHARM Lab** | Stanford University | Haptic interaction, wearable haptics | Mechanistic understanding of wrist-worn haptic devices, wearable haptic solutions for everyday activities |
| **BDML (Biomimetics & Dextrous Manipulation)** | Stanford University | Wearable haptics, skin-mounted actuators | Fingertip and wrist-worn tactile feedback systems |
| **HCI Tech Lab** | KAIST, South Korea | Adaptive XR wearable interfaces | Novel sensing, hardware/devices, realistic haptic rendering |
| **Bristol Interaction Group** | University of Bristol, UK | Ultrasonic haptics, mid-air tactile displays | Ultrahaptics (now Ultraleap); focused ultrasound for touchless haptics |
| **MAHI Lab** | Rice University | Medical/assistive haptics | Tasbi multimodal haptic bracelet |
| **Rekimoto Lab** | University of Tokyo | Augmented human, wearable computing | HapticPointer (16-motor necklace for directional cues) |
| **Makeability Lab** | University of Washington | Accessible wearable haptics | Wrist-based directional haptic guidance evaluation |
| **Haptx / Haptic Design Group** | Various | High-fidelity haptic gloves | VR haptic glove design principles |
| **Elitac Wearables** | Netherlands (spin-off) | Tactile navigation vests | Commercial vibrotactile vest for navigation |

**Sources:**
- [MIT Media Lab -- Wearable Computing](https://www.media.mit.edu/wearables/)
- [Stanford CHARM Lab](http://charm.stanford.edu/Main/Research)
- [Stanford BDML -- Wearable Haptics](http://bdml.stanford.edu/Main/WearableHapticsHome)
- [KAIST HCI Tech Lab -- CHI 2024](https://dl.acm.org/doi/10.1145/3613905.3648652)
- [Rekimoto Lab -- HapticPointer](https://lab.rekimoto.org/projects/hapticpointer/)

### 6.4.2 Foundational Papers

**Perception and Psychophysics:**

1. Bolanowski, S.J., Gescheider, G.A., Verrillo, R.T., & Checkosky, C.M. (1988). "Four channels mediate the mechanical aspects of touch." *Journal of the Acoustical Society of America*, 84(5), 1680--1694. -- Defines the four mechanoreceptive channels.

2. Verrillo, R.T. (1963). "Effect of contactor area on the vibrotactile threshold." *Journal of the Acoustical Society of America*, 35(12), 1962--1966. -- Foundational work on vibrotactile detection thresholds.

3. Weinstein, S. (1968). "Intensive and extensive aspects of tactile sensitivity as a function of body part, sex, and laterality." In D.R. Kenshalo (Ed.), *The Skin Senses* (pp. 195--222). -- Classic body map of tactile spatial resolution.

4. Geldard, F.A. & Sherrick, C.E. (1972). "The cutaneous rabbit: A perceptual illusion." *Science*, 178(4057), 178--179. -- Discovery of sensory saltation.

5. Craig, J.C. (1972). "Difference threshold for intensity of tactile stimuli." *Perception & Psychophysics*, 11(2), 150--152. -- Weber fraction for vibrotactile amplitude.

**Wearable Haptic Systems:**

6. Schaack, S., Chernyshov, G., & Kunze, K. (2019). "Haptic Collar: Vibrotactile Feedback around the Neck for Guidance Applications." *Proc. 10th Augmented Human Int'l Conference (AH '19)*, ACM. [DOI:10.1145/3311823.3311840](https://dl.acm.org/doi/10.1145/3311823.3311840) -- Directly relevant: 4/6/8 motor neck band evaluation.

7. Alvina, J., et al. (2023). "HaptiCollar: Investigating Tactile Acuity Towards Vibrotactile Stimuli on the Neck." [ResearchGate](https://www.researchgate.net/publication/368824228) -- Spatial discrimination on the neck.

8. Luces, J.V.S. & Okabe, K. "A Phantom-Sensation Based Paradigm for Continuous Vibrotactile Wrist Guidance in Two-Dimensional Space." [Semantic Scholar](https://www.semanticscholar.org/paper/Luces-Okabe/e35e0fa13ef483b4392be7f0e582ec5b0723b9eb) -- Phantom sensation on wrist.

9. Pezent, E., et al. (2019). "Tasbi: Multisensory Squeeze and Vibrotactile Wrist Haptics for Augmented and Virtual Reality." *IEEE World Haptics Conf.* [PDF](https://mahilab.rice.edu/sites/default/files/publications/tasbi_whc2019.pdf) -- Multimodal wrist haptic design.

10. Hong, S., et al. (2016). "Evaluating Angular Accuracy of Wrist-based Haptic Directional Guidance for Hand Movement." *Graphics Interface 2016*. [PDF](https://makeabilitylab.cs.washington.edu/media/publications/Hong_EvaluatingAngularAccuracyOfWristBasedHapticDirectionalGuidanceForHandMovement_GI2016.pdf) -- 4 vs 8 motor wrist comparison.

**Tactile Illusions:**

11. Israr, A. & Poupyrev, I. (2011). "Tactile Brush: Drawing on skin with a tactile grid display." *Proc. CHI 2011*, ACM. -- Seminal work on apparent tactile motion algorithms.

12. Lee, J., et al. (2018). "Tactile Information Transmission by 2D Stationary Phantom Sensations." *Proc. CHI 2018*, ACM. [DOI:10.1145/3173574.3173832](https://dl.acm.org/doi/10.1145/3173574.3173832) -- 2D phantom sensation encoding.

13. Kim, H., et al. (2020). "Body-Penetrating Tactile Phantom Sensations." *Proc. CHI 2020*, ACM. [DOI:10.1145/3313831.3376619](https://dl.acm.org/doi/fullHtml/10.1145/3313831.3376619) -- Phantom sensations across body segments.

**Spatial Acuity Measurement:**

14. Hefner, J., et al. (2023). "Measuring the spatial acuity of vibrotactile stimuli: A new approach to determine universal and individual thresholds." *Displays*. [arXiv preprint](https://arxiv.org/pdf/2308.05497) -- Modern methodology for vibrotactile 2PD.

15. Jansen, Y., et al. (2021). "Tactile spatial discrimination on the torso using vibrotactile and force stimulation." *Experimental Brain Research*. [PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC8541989/) -- Torso spatial acuity.

16. Krause, J., et al. (2025). "Two-Point Discrimination of Vibrotactile Stimuli on the Forearm." *Proc. ACM Hum.-Comput. Interact.* [DOI:10.1145/3743721](https://dl.acm.org/doi/10.1145/3743721) -- Recent forearm-specific 2PD data.

**Breakthrough (Recent):**

17. (2025). "Toward human-resolution haptics: A high-bandwidth, high-density, wearable tactile display." *Science Advances*. [DOI:10.1126/sciadv.adz5937](https://www.science.org/doi/10.1126/sciadv.adz5937) -- VoxeLite: 0.1 mm-thick electroadhesive array at 110 nodes/cm^2, representing the frontier of wearable tactile display technology.

### 6.4.3 Key Takeaways for HAPTIC.SKIN Design

1. **16 ERM motors (8 neck + 4+4 wrist) is scientifically well-justified.** It matches the vibrotactile spatial resolution limits of these body sites.

2. **ERM frequency range (80--250 Hz) covers peak human sensitivity.** The Pacinian channel's optimal zone is well-served by these motors.

3. **4--5 distinguishable intensity levels are achievable** via PWM control, constrained by Weber's Law (JND ~20%).

4. **Phantom sensation and apparent motion are essential** to maximize the perceptual resolution from a limited number of physical actuators. These illusions should be implemented in the pattern engine from the start.

5. **The project targets TRL 5--6 by July 2026**, which is realistic for a prototype demonstrated on a person in a representative scenario.

6. **The design is original in the academic space**: no published system combines bidirectional (vibration output + IMU gesture input) wearable haptics across neck and both wrists as an open platform. The closest prior work is Haptic Collar (output only, neck only) and various wrist-only haptic bracelets.
