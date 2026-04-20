#import "@preview/splendid-mdpi:0.1.0"

#show: splendid-mdpi.template.with(
  title: [HAPTIC.SKIN --- Rapport de Recherche Approfondi],
  authors: (
    (
      name: "Marc-Alexis MANSO-PETERS",
      department: "ING2",
      institution: "EFREI Paris",
      city: "Paris",
      country: "France",
      mail: "",
    ),
  ),
  date: (
    year: 2026,
    month: "Avril",
    day: 8,
  ),
  keywords: (
    "Haptique",
    "Wearable",
    "Open-Source",
    "Vibrotactile",
    "IMU",
    "Raspberry Pi Pico",
  ),
  doi: none,
  abstract: [
    Ce rapport présente une analyse approfondie pour le projet HAPTIC.SKIN, une plateforme haptique portable bidirectionnelle open-source composée d'un collier et de deux bracelets équipés de 16 moteurs vibrants ERM et de capteurs IMU. La plateforme permet de recevoir des informations par vibrations et de répondre par gestes --- sans écran ni son. Nous passons en revue l'état de l'art des wearables haptiques, analysons les options matérielles et logicielles, explorons les cas d'usage de l'accessibilité au gaming, évaluons la viabilité marché, examinons les fondements scientifiques de la perception haptique, traitons l'éco-conception, et tirons les leçons de projets similaires. Nos résultats confirment qu'aucune plateforme haptique portable, abordable et open-source n'existe actuellement, positionnant HAPTIC.SKIN pour combler ce vide. Nous fournissons des recommandations concrètes pour un plan de développement de 3 mois avec un budget inférieur à 100~EUR.
  ],
  details: [
    *Projet Innovation EFREI ING2 2025--2026*

    Encadrant~: Olivier Girinsky

    Contact~: projets.transverses\@efrei.fr
  ],
)

// ============================================================
= Introduction
// ============================================================

HAPTIC.SKIN est une plateforme haptique portable bidirectionnelle open-source conçue pour ajouter une nouvelle couche sensorielle au corps humain. Le système comprend un collier et deux bracelets équipés de 16 moteurs vibrants ERM (pilotés via PCA9685 PWM + transistors Darlington ULN2803A) et deux capteurs IMU MPU6050 pour la reconnaissance gestuelle, le tout contrôlé par un Raspberry Pi Pico connecté en USB à un PC hôte exécutant un démon Python asyncio.

Ce rapport synthétise la recherche sur huit axes~: état de l'art, matériel, architecture logicielle, cas d'usage, analyse marché, fondements scientifiques, éco-conception et retours d'expérience de projets similaires. Les conclusions principales sont~:

- *Aucune plateforme haptique portable open-source, abordable et bidirectionnelle n'existe* sur le marché actuel.
- Le marché de la technologie haptique croît de 14--16\% par an vers \~10 milliards~\$ d'ici 2028.
- *Découverte matérielle critique*~: le PCA9685 ne peut pas piloter directement les moteurs ERM (10~mA max en sortie vs 80--100~mA requis). Des transistors Darlington ULN2803A sont indispensables.
- Le BOM proposé de \~63~EUR est réalisable avec des composants standards.
- Un calendrier de 3 mois est serré mais faisable pour un prototype fonctionnel.
- *Séquence de démo recommandée* pour la soutenance~: (1)~musique-vers-vibration, (2)~navigation à l'aveugle, (3)~communication silencieuse bidirectionnelle.

#figure(
  image("images/architecture.png", width: 95%),
  caption: [Architecture système de HAPTIC.SKIN~: trois couches logicielles (client, démon, firmware) et deux couches matérielles (contrôleur, actionneurs/capteurs).],
) <fig-archi>

#colbreak()

// ============================================================
= État de l'Art
// ============================================================

== Produits Commerciaux

Le marché des wearables haptiques est dominé par des acteurs propriétaires ciblant le gaming et la VR d'entreprise. Aucun produit n'offre une plateforme open-source, abordable et bidirectionnelle.

*bHaptics* est le leader du marché grand public. Leur gamme 2025--2026 inclut le TactSuit Pro (32~moteurs, 500\$, 13.5h batterie, BLE), le TactSuit Air (16~moteurs, 250\$), le TactSleeve (3~moteurs par bras, 200\$/paire) et le TactGlove DK2 (12~actionneurs, 269\$). Compatible avec 100+ jeux Meta Quest et 200+ titres PC VR. SDK propriétaire pour Unity/Unreal. @bhaptics

*OWO Skin* utilise l'électrostimulation musculaire (EMS) plutôt que des moteurs vibrants. 10~zones EMS, BLE~5.2, 499\$. Sensations physiques plus fortes que la vibration mais problèmes de confort et sécurité. @owo

*Teslasuit*~: solution entreprise avec 80~canaux EMS + 5~canaux thermiques + 14~capteurs IMU pour la capture de mouvement corps entier. \~20~000\$ (entreprise uniquement). Seul système commercial bidirectionnel, mais à 200× le coût de HAPTIC.SKIN. @teslasuit

*Woojer Vest~4*~: 6~transducteurs haptiques convertissant l'audio en vibration (1--250~Hz), 349\$. Piloté par audio, pas par moteurs individuels. @woojer

*Lofelt*~: SDK vibrotactile sophistiqué et subwoofer portable "The Basslet". Acquis par Meta en 2022. Leur format `.haptic` (enveloppes JSON amplitude/fréquence) a influencé le domaine. @lofelt

== Projets Open-Source

Plusieurs projets haptiques open-source existent, mais aucun ne combine format portable, bidirectionnalité et API développeur~:

*Google VHP (Vibrotactile Haptics Platform)*~: Référence en haptique open-source. 12~canaux indépendants à 2~kHz, nRF52840, BLE + série. Licence Apache~2.0. Publié à ACM UIST~'21. Sortie uniquement. @google-vhp

*Snaptics (Rice University)*~: Plateforme modulaire à clipser pour prototypage rapide d'haptique multi-sensorielle (vibration, compression, torsion, étirement de peau). Imprimable en 3D. IEEE Transactions on Haptics 2024. @snaptics

*SenseShift*~: Firmware ESP32 open-source pour gilets et gants haptiques DIY pour la VR. BOMs communautaires et guides de montage. Sortie uniquement. @senseshift

*MIT Fifth Sense (CSAIL)*~: Réseau haptique portable basse coût pour la navigation des déficients visuels. Format ceinture/collier avec matrice de moteurs. Dirigé par Prof. Daniela Rus. @mit-fifth-sense

== Recherche Académique

*Interfaces haptiques bidirectionnelles*~: Un article IEEE 2022 a démontré un système portable sans fil combinant reconnaissance gestuelle (94,48\% de précision sur 6~gestes) avec retour vibrotactile LRA. @ieee-bidirectional Nature Communications~(2022) a publié des bagues tactiles augmentées avec capteurs triboélectriques + vibreurs pour I/O bidirectionnel. @nature-rings Nature Communications~(2025) a présenté un réseau de suivi de mouvement corps entier + retour haptique avec classification gestuelle par deep learning. @nature-fullbody

*Navigation vibrotactile*~: Van Erp et al.~(2005) ont démontré une précision quasi parfaite pour l'information directionnelle avec une ceinture vibrotactile. @van-erp

*Sensations fantômes*~: Israr et Poupyrev~(2011) ont montré que le mouvement tactile apparent entre deux moteurs discrets peut doubler la résolution spatiale perçue ("Tactile Brush"). @tactile-brush

== Tableau Comparatif des Concurrents

#figure(
  table(
    columns: 7,
    align: (left, center, center, center, center, center, center),
    table.header(
      [*Produit*], [*Prix*], [*Actionneurs*], [*Entrée*], [*Open Source*], [*Bidirectionnel*], [*Format*],
    ),
    [bHaptics Pro], [500\$], [32 ERM], [Aucune], [Non], [Non], [Gilet],
    [bHaptics Air], [250\$], [16 ERM], [Aucune], [Non], [Non], [Gilet],
    [OWO Skin], [499\$], [10 EMS], [Aucune], [Non], [Non], [T-shirt],
    [Teslasuit], [20k\$], [80 EMS], [14 IMUs], [Non], [Oui], [Combinaison],
    [Woojer Vest], [349\$], [6 transd.], [Aucune], [Non], [Non], [Gilet],
    [Google VHP], [\~50--100\$], [12 LRA], [Aucune], [Oui], [Non], [Bracelet],
    [SenseShift], [\~50--150\$], [16--40 ERM], [Aucune], [Oui], [Non], [Gilet],
    [*HAPTIC.SKIN*], [*\<100~EUR*], [*16 ERM*], [*2× IMU*], [*Oui*], [*Oui*], [*Cou+poignets*],
  ),
  caption: [Comparaison des produits haptiques portables. HAPTIC.SKIN est unique en combinant open-source, bidirectionnalité et coût inférieur à 100~EUR.],
) <tab-comp>

#figure(
  image("images/market_comparison.png", width: 90%),
  caption: [Comparaison des prix des solutions haptiques commerciales. HAPTIC.SKIN se positionne très en dessous de tous les concurrents.],
) <fig-prix>

== Lacunes Identifiées

+ *Aucun wearable haptique bidirectionnel open-source n'existe.* Tous les projets open-source (Google VHP, Snaptics, SenseShift) sont en sortie uniquement.
+ *Aucun système multi-dispositif distribué abordable.* Aucun produit ne propose une topologie coordonnée collier~+~bracelets.
+ *Pas d'API développeur simple.* Tous les SDK commerciaux sont complexes et propriétaires. Aucune interface one-liner `haptic('swipe_left')`.
+ *Pas de format collier.* La plupart des wearables haptiques sont des gilets, gants ou combinaisons. Le collier est unique et validé par la recherche @kaul-neck.
+ *ERM sous-utilisé en open-source.* À 0,30--0,50\$/unité, 16~ERMs pour \~8\$ obtiennent une résolution spatiale que les produits commerciaux facturent 250--500\$.
+ *Pas de protocole standard.* Chaque produit utilise son propre SDK et ses propres formats de patterns.

#colbreak()

// ============================================================
= Analyse Matérielle
// ============================================================

== Comparaison des Microcontrôleurs

#figure(
  table(
    columns: 6,
    align: (left, center, center, center, center, center),
    table.header(
      [*Caractéristique*], [*Pico*], [*Pico W*], [*ESP32*], [*ESP32-S3*], [*STM32F4*],
    ),
    [Prix], [\~4~EUR], [\~6~EUR], [\~4~EUR], [\~5~EUR], [\~8~EUR],
    [CPU], [Dual M0+], [Dual M0+], [Dual Xtensa], [Dual Xtensa], [ARM M4F],
    [Horloge], [133~MHz], [133~MHz], [240~MHz], [240~MHz], [168~MHz],
    [Bus I2C], [2], [2], [2], [2], [3],
    [WiFi/BT], [Non], [Oui], [Oui], [Oui], [Non],
    [USB natif], [Oui], [Oui], [Via UART], [Oui], [Via UART],
    [MicroPython], [Excellent], [Excellent], [Bon], [Bon], [Limité],
    [Consommation], [\~25~mA], [\~40~mA], [\~80~mA], [\~80~mA], [\~50~mA],
  ),
  caption: [Comparaison des microcontrôleurs. Le Raspberry Pi Pico offre le meilleur compromis coût/USB/I2C/MicroPython.],
)

*Recommandation*~: Raspberry Pi Pico (sans WiFi) pour v1. USB natif, deux bus I2C (un pour PCA9685, un pour IMUs), excellent support MicroPython, coût le plus bas. ESP32-S3 comme voie d'évolution pour une v2 sans fil.

== Comparaison des Technologies d'Actionneurs

#figure(
  image("images/actuator_comparison.png", width: 75%),
  caption: [Diagramme radar comparant les technologies d'actionneurs sur 5~axes. Les ERM offrent le meilleur compromis coût/simplicité pour un premier prototype.],
) <fig-actuator>

#figure(
  table(
    columns: 5,
    align: (left, center, center, center, center),
    table.header(
      [*Caractéristique*], [*ERM*], [*LRA*], [*Piézo*], [*EMS*],
    ),
    [Coût unitaire], [0,30--1\$], [1--3\$], [3--10\$], [2--5\$],
    [Temps de réponse], [50--100~ms], [5--25~ms], [\<1,5~ms], [\<5~ms],
    [Fréquence], [50--250~Hz], [150--250~Hz], [1--300~Hz], [N/A],
    [Puissance/moteur], [50--100~mW], [20--50~mW], [10--30~mW], [Variable],
    [Driver requis], [PWM + transistor], [Driver AC], [Driver HV], [Complexe],
    [Qualité haptique], [Diffuse], [Précise], [Très précise], [Contraction],
  ),
  caption: [Comparaison détaillée des technologies d'actionneurs.],
)

*Recommandation*~: Moteurs ERM pour v1. À 16~unités pour \~8\$, c'est la seule option dans le budget. Les LRA nécessiteraient 16× DRV2605L (\~80~EUR), dépassant le budget.

== Circuit de Pilotage des Moteurs

*Découverte critique des projets similaires*~: le PCA9685 délivre au maximum 10~mA (drain) / 25~mA (source) par canal. Les moteurs ERM consomment 80--100~mA en pleine vitesse. *Le PCA9685 ne peut pas piloter directement les moteurs ERM.* Des transistors Darlington ULN2803A sont indispensables comme amplificateurs de courant.

*Circuit recommandé*~:
```
Sortie PCA9685 → Entrée ULN2803A → Sortie ULN2803A → Moteur ERM (+ diode de flyback 1N4148)
```

Deux ULN2803A (8~canaux chacun) pilotent les 16~moteurs. Coût total~: \~1~EUR. Les diodes de flyback sont obligatoires sur chaque moteur pour supprimer les pics de contre-EMF qui peuvent endommager le driver et le MCU.

== Capteurs IMU

*Recommandation*~: MPU6050 (breakout GY-521) pour v1. Le processeur de mouvement numérique (DMP) intégré décharge les calculs d'orientation du Pico. Deux modules partagent un bus I2C avec des adresses différentes (broche AD0). Le LSM6DS3 est la voie d'évolution si le bruit/dérive pose problème --- il intègre la détection de tap/tilt et un cœur ML.

== Architecture d'Alimentation

Pour v1 (câblé USB)~: Pico alimenté via USB (5V, 500~mA). 16~moteurs ERM à pleine puissance tirent \~1,28A, dépassant la limite USB. *Le firmware doit limiter les moteurs actifs simultanément* (max 6--8 à pleine intensité) ou utiliser une alimentation externe 5V.

== Nomenclature (BOM) Recommandée

#figure(
  table(
    columns: 4,
    align: (left, center, center, right),
    table.header(
      [*Composant*], [*Qté*], [*Prix unitaire*], [*Sous-total*],
    ),
    [Raspberry Pi Pico], [1], [4~EUR], [4~EUR],
    [PCA9685 breakout], [1], [3~EUR], [3~EUR],
    [ULN2803A Darlington], [2], [0,50~EUR], [1~EUR],
    [Diodes flyback 1N4148], [16], [0,05~EUR], [1~EUR],
    [Moteurs ERM (10~mm coin)], [16], [0,50~EUR], [8~EUR],
    [MPU6050 (GY-521)], [2], [1,50~EUR], [3~EUR],
    [Perfboard / PCB (JLCPCB)], [1], [5~EUR], [5~EUR],
    [Câblage, connecteurs JST-PH], [---], [---], [10~EUR],
    [Filament 3D (PLA+TPU)], [---], [---], [15~EUR],
    [Bandes néoprène, Velcro], [---], [---], [8~EUR],
    [Câble USB], [1], [3~EUR], [3~EUR],
    [Condensateurs, résistances], [---], [---], [2~EUR],
    table.hline(),
    [*TOTAL*], [], [], [*63~EUR*],
  ),
  caption: [BOM recommandée incluant les transistors Darlington et les diodes de flyback. Bien dans le budget de 100~EUR avec marge pour itération.],
) <tab-bom>

== Évaluation de Faisabilité

Un prototype fonctionnel est réalisable en 3~mois, mais *pas la vision complète*~:

- *Réalisable*~: 1~collier (8~moteurs) + 1~bracelet (4~moteurs + IMU), firmware de base, démon, API REST, reconnaissance gestuelle par seuils, 2--3~scénarios de démo.
- *Objectif ambitieux*~: Système complet 16~moteurs avec 2~bracelets.
- *Irréaliste pour v1*~: Reconnaissance gestuelle ML, sans fil, boîtiers production, PCB custom.

*Chemin critique*~: Commander les composants en semaine~1 (livraison AliExpress 2--3~semaines), prototype breadboard du circuit PCA9685~+~ULN2803A~+~moteur validé en semaine~3.

#colbreak()

// ============================================================
= Architecture Logicielle
// ============================================================

== Revue des SDK Existants

#figure(
  table(
    columns: 5,
    align: (left, center, center, center, left),
    table.header(
      [*SDK*], [*Architecture*], [*Format pattern*], [*IPC*], [*Enseignement clé*],
    ),
    [bHaptics], [Service arrière-plan], [JSON timeline], [WebSocket], [Modes Dot/Path],
    [Lofelt], [Runtime embarqué], [JSON enveloppes], [In-process], [Courbes d'amplitude],
    [Core Haptics], [Framework OS], [AHAP (JSON)], [In-process], [Transitoire/continu],
    [CHAI3D], [Thread par device], [Procédural], [In-process], [Thread haptique 1~kHz],
  ),
  caption: [SDK haptiques existants. Le modèle démon~+~WebSocket de bHaptics et le format AHAP d'Apple sont les principales inspirations architecturales.],
)

== Architecture Recommandée

Stack en trois couches~:

*Firmware (Pico, MicroPython)*~: Reçoit des commandes série binaires, pilote les sorties PWM PCA9685 via ULN2803A, lit les données IMU MPU6050, envoie les événements gestuels en amont. Protocole binaire avec octets de tramage (`0xAA` descendant, `0xBB` montant) et checksum XOR.

*Démon (PC hôte, Python~3 asyncio)*~: Architecture mono-processus asynchrone. Gère la communication série via `pyserial`/`aioserial`, le séquençage des patterns à 200~Hz, le traitement des événements gestuels et l'exposition de l'API. File de priorité `asyncio.PriorityQueue` pour l'ordonnancement des commandes moteur.

*Bibliothèque cliente (package Python)*~: Interface one-liner~:
```python
haptic('swipe_left', intensity=0.8)
haptic('heartbeat', repeat=3, interval_ms=800)
```

== Analyse des Protocoles de Communication

#figure(
  table(
    columns: 4,
    align: (left, center, center, left),
    table.header(
      [*Méthode*], [*Latence*], [*Complexité*], [*Usage*],
    ),
    [Socket Unix], [\~10--50~µs], [Faible], [Principal (clients Python locaux)],
    [WebSocket], [\~100--500~µs], [Moyenne], [Interfaces web, multi-langage],
    [REST/HTTP], [\~1--5~ms], [Faible], [Debug/admin],
  ),
  caption: [Comparaison des protocoles IPC. Socket Unix recommandé comme canal principal pour la latence minimale.],
)

*Série démon-vers-Pico*~: `pyserial` à 921600~bauds (le CDC-ACM USB du Pico tourne à USB Full Speed 12~Mbps quelle que soit la vitesse configurée). Le goulot d'étranglement est le bus I2C du PCA9685~: à 400~kHz, l'écriture des 16~canaux prend \~2--3~ms.

== Moteur de Patterns

Inspiré d'Apple AHAP et bHaptics, les patterns sont des fichiers JSON avec contrôle moteur basé sur une timeline~:

```json
{
  "name": "swipe_left",
  "duration_ms": 400,
  "timeline": [
    {"time_ms": 0,   "type": "continuous",
     "motors": [0,1,2,3], "intensity": 0.8,
     "duration_ms": 150, "fade_out_ms": 50},
    {"time_ms": 100, "type": "continuous",
     "motors": [4,5,6,7,8,9,10,11],
     "intensity": 0.6, "duration_ms": 200},
    {"time_ms": 250, "type": "continuous",
     "motors": [12,13,14,15], "intensity": 0.8,
     "duration_ms": 150}
  ]
}
```

*Composition*~: Quand plusieurs patterns sont actifs, utiliser `max()` par moteur (pas additif) pour éviter le clipping. Approche validée par bHaptics et Core Haptics.

*Bibliothèque intégrée*~: 10--15~patterns prédéfinis~: `pulse`, `double_pulse`, `swipe_left/right`, `heartbeat`, `alert_urgent`, `confirm`, `deny`, `navigate_left/right`.

== Reconnaissance Gestuelle

*Phase~1 (prototype/démo)*~: Détection par seuils pour 4~gestes~:

#figure(
  table(
    columns: 2,
    align: (left, left),
    table.header(
      [*Geste*], [*Règle de détection*],
    ),
    [Lever la main], [acc_z > 1,5g maintenu > 300~ms],
    [Secouer (refuser)], [oscillations acc_x > 4 en 1~s, amplitude > 1,0g],
    [Incliner gauche/droite], [gyro_z > 100~deg/s maintenu > 200~ms],
    [Rotation poignet], [gyro_x > 150~deg/s maintenu > 200~ms],
  ),
  caption: [Règles de détection gestuelle par seuils pour le MVP.],
)

*Phase~2*~: DTW avec calibration par utilisateur (5~enregistrements modèles par geste). *Phase~3*~: Classifieur Random Forest/SVM sur features extraites (scikit-learn, \<1~ms inférence).

Machine à états anti-rebond~: IDLE → CONFIRMATION~(100~ms) → ACTIF → REFROIDISSEMENT~(300~ms) → IDLE.

#colbreak()

// ============================================================
= Cas d'Usage et Applications
// ============================================================

== Accessibilité

Le retour haptique pour les déficients visuels est l'application la plus impactante. Précédents clés~:

- *Sunu Band*~: sonar ultrasonique au poignet avec vibration de proximité, \~299\$. Validé comme complément de canne blanche. @sunu
- *Wayband (WearWorks)*~: bracelet de navigation haptique. Un coureur aveugle a complété le Marathon de New York 2017 guidé uniquement par Wayband. @wayband
- *Carnegie Mellon NavCog*~: balises BLE + smartphone + bracelet vibrant pour navigation intérieure. @navcog
- Des études montrent que 4--8~moteurs vibrants sur le torse transmettent l'information directionnelle avec >90\% de précision après \~20~min d'entraînement. @jner-haptic

Le collier de HAPTIC.SKIN fournit un retour directionnel à 360°~; les bracelets renforcent gauche/droite. Les gestes IMU permettent une interaction mains-libres et yeux-libres.

== Navigation

Au-delà de l'accessibilité, la navigation haptique réduit la charge cognitive de 30--40\% par rapport aux instructions audio~:

- *FeelSpace/naviGürtel (Uni.~Osnabrück)*~: ceinture à 30~vibrotacteurs, un pointant toujours le nord. Après 6~semaines de port continu, les utilisateurs ont développé un sens magnétique intuitif. @feelspace
- *CycleSense (Uni.~Bristol)*~: poignées haptiques pour cyclistes, préférées à la navigation audio. @cyclesense

Les 8~moteurs du collier HAPTIC.SKIN correspondent naturellement aux directions cardinales. "Vibration à 2~heures sur le collier" signifie intuitivement "tournez légèrement à droite".

== Gaming et VR

L'intégration haptique suit trois schémas~: *événementiel* (explosion → pattern prédéfini), *mapping spatial* (position 3D → moteur correspondant sur le corps), et *retour continu* (battement de cœur s'intensifiant avec les PV bas).

HAPTIC.SKIN peut servir d'alternative open-source budget à bHaptics pour les développeurs indépendants. L'IMU ajoute une dimension unique~: lancer de sorts ou changement d'arme par geste. Intégration via WebSocket depuis le moteur de jeu vers le démon.

== Musique et Art

*Not Impossible Labs — Music:~Not Impossible*~: combinaisons vibrotactiles à 24~moteurs pour que les sourds "ressentent" les concerts live. Chaque instrument mappé sur une zone corporelle différente. @not-impossible

*Hapbeat (Uni.~Tsukuba)*~: dispositif au format collier convertissant les basses en vibration sur la clavicule. @hapbeat

HAPTIC.SKIN peut exécuter une analyse audio temps réel (Python librosa)~: bandes de fréquence mappées sur les groupes moteurs (basses → centre du collier, médiums → côtés, aigus → poignets). Une personne sourde ressentant la musique à travers le collier a un impact émotionnel et social énorme pour un jury.

== Santé et Médical

- *Correction posturale*~: l'IMU détecte l'affaissement → vibration douce de rappel (comparable à Upright Go, \~100\$). @upright
- *Biofeedback respiratoire*~: le collier pulse à 6~respirations/min (cohérence cardiaque) pour guider les personnes stressées. @breathing-biofeedback
- *Rééducation*~: l'IMU du bracelet mesure les angles du bras pendant les exercices~; la vibration guide l'amplitude de mouvement. @hocoma

_Note~: Éviter toute revendication de dispositif médical pour ne pas déclencher les exigences du Règlement européen sur les dispositifs médicaux (MDR)._

== Communication

La nature bidirectionnelle de HAPTIC.SKIN permet une communication unique~:

- Meta~(2018) a démontré un manchon à 16~actionneurs encodant les phonèmes anglais comme patterns vibratoires. Après entraînement, les participants reconnaissaient 100+ mots à vitesse conversationnelle. @meta-phonemes
- Deux porteurs de HAPTIC.SKIN pourraient échanger silencieusement des messages~: le geste d'une personne → le pattern vibratoire de l'autre. Un canal de communication privé et silencieux.

== Industriel et Militaire

- *Elitac (Pays-Bas)*~: ceinture de navigation haptique pour pompiers en fumée opaque. Testée avec les services d'incendie néerlandais. @elitac
- *DARPA TSAS*~: gilet vibrotactile pour pilotes d'hélicoptère encodant l'orientation de l'appareil, réduisant la désorientation spatiale. @darpa-tsas

Haute valeur mais plus difficile à démontrer et mieux adapté à une v2 sans fil.

== Matrice de Classement des Cas d'Usage

#figure(
  table(
    columns: 6,
    align: (left, center, center, center, center, center),
    table.header(
      [*Cas d'usage*], [*Faisabilité*], [*Effet wow*], [*Impact social*], [*Simplicité*], [*Score /20*],
    ),
    [Musique-vers-vibration], [4], [5], [5], [3], [*17*],
    [Navigation (aveugle)], [5], [5], [4], [2], [*16*],
    [Communication silencieuse], [4], [5], [4], [3], [*16*],
    [Accessibilité (obstacles)], [3], [4], [5], [4], [*16*],
    [Rééducation], [3], [3], [5], [4], [*15*],
    [Navigation pompier], [4], [4], [4], [2], [*14*],
    [Gaming/VR spatial], [4], [4], [2], [3], [*13*],
    [Correction posturale], [4], [3], [4], [2], [*13*],
  ),
  caption: [Classement des cas d'usage. Score~: 1~(faible) à 5~(élevé). Pour la simplicité, score élevé = moins complexe.],
) <tab-usecases>

*Séquence de 3~démos recommandée pour la soutenance (5~min)*~:
+ *Musique-vers-vibration (30~s)*~: Accroche émotionnelle --- un membre du jury porte le collier et ressent une chanson.
+ *Navigation à l'aveugle (2~min)*~: Interactif --- un volontaire les yeux bandés est guidé à travers un parcours d'obstacles.
+ *Communication silencieuse (2~min)*~: Profondeur technique --- deux personnes communiquent par gestes et vibrations.

#colbreak()

// ============================================================
= Analyse de Marché
// ============================================================

== Taille du Marché et Tendances

Le marché mondial de la technologie haptique était évalué à \~4,5~milliards~\$ en 2023, projeté à 9,8--15,7~milliards~\$ d'ici 2028--2033 (TCAC 14--16\%). @grandview @marketsandmarkets @precedence

Facteurs de croissance~: XR/spatial computing (Apple Vision Pro, Meta Quest), Acte européen d'accessibilité (application depuis 2025), mouvement open hardware, réduction des coûts des actionneurs MEMS.

Le marché de la technologie portable est plus large (\~70--75~milliards~\$ en 2023, projeté 150--180~milliards~\$ d'ici 2028), avec les wearables santé et les accessoires XR en croissance la plus rapide.

== Segments Cibles

#figure(
  table(
    columns: 4,
    align: (left, left, center, center),
    table.header(
      [*Segment*], [*Description*], [*Propension à payer*], [*Priorité*],
    ),
    [Makers / Éducation], [Universités, hackathons, STEM], [40--100~EUR], [*HAUTE*],
    [Développeurs XR/VR], [Développeurs indépendants], [80--200~EUR], [*HAUTE*],
    [Technologie d'accessibilité], [Aides à la navigation], [50--150~EUR], [*HAUTE*],
    [Prototypage wearable (B2B)], [Entreprises prototypant UX haptique], [100--300~EUR], [MOYENNE],
    [Gamers passionnés], [PC/console], [60--150~EUR], [MOYENNE],
  ),
  caption: [Segments de marché cibles. Makers/Éducation et développeurs XR comme tête de pont.],
)

== Analyse SWOT

*Forces*~: Seule plateforme haptique open-source~; coût \<100~EUR (vs 300\$+ concurrents)~; bidirectionnel (unique)~; API Python simple~; conception modulaire.

*Faiblesses*~: Petite équipe étudiante~; 16~moteurs vs 32--40 pour bHaptics~; câblé USB en v1~; ERM moins précis que LRA/EMS.

*Opportunités*~: Aucun concurrent open-source~; Acte d'accessibilité UE~; boom du marché XR~; subventions françaises/UE (NGI, BPI)~; communauté crowdfunding réceptive au matériel ouvert.

*Menaces*~: bHaptics pourrait baisser ses prix ou ouvrir son code~; Apple/Meta entrent sur le marché~; perturbations supply chain~; charge réglementaire CE pour la commercialisation.

== Modèle Économique

Trajectoire éprouvée du matériel open-source (modèle Adafruit/SparkFun)~:
+ *Phase~1 --- Crowdfunding*~: Lancement sur Crowd Supply à 59--99~EUR. Cible~: 30k--80k~EUR. Benchmarks~: bHaptics \~300k\$, OWO \~700k\$, Pine64 \~200k\$.
+ *Phase~2 --- Vente directe*~: Site web + Tindie, packs éducation (5 unités 399~EUR).
+ *Phase~3 --- Plateforme*~: Kits dev B2B, certification "HAPTIC.SKIN compatible".

== Considérations Réglementaires

Pour v1~(prototype)~: aucune exigence réglementaire. Avant commercialisation~:
- *Marquage CE*~: autocertification Directive CEM (\~500--1~500~EUR en labo accrédité).
- *RoHS/REACH*~: composants conformes standards des grands distributeurs.
- *DEEE*~: inscription auprès d'un éco-organisme français (Ecologic) @ecologic.
- *Directive basse tension*~: probablement exempt (3,3/5V DC, sous le seuil de 50V).
- *RED*~: non applicable pour v1 (câblé). Requis si Bluetooth ajouté --- significativement plus coûteux (\~3k--10k~EUR). *Garder v1 câblé.*

#colbreak()

// ============================================================
= Fondements Scientifiques
// ============================================================

== Science de la Perception Haptique

*Canaux mécanorecepteurs*~: La peau humaine contient quatre types de mécanorecepteurs. Pour les wearables vibrotactiles, deux sont critiques~:
- *Corpuscules de Meissner* (10--50~Hz)~: répondent aux vibrations basse fréquence, acuité spatiale plus faible.
- *Corpuscules de Pacini* (40--1000~Hz, pic de sensibilité 200--300~Hz)~: mécanorecepteurs profonds les plus sensibles à la vibration. Les moteurs ERM (100--250~Hz) tombent dans cette plage optimale. @verrillo

*Seuil de discrimination à deux points*~: Distance minimale pour que deux vibrations simultanées soient perçues comme distinctes~:
- *Poignet*~: \~40--60~mm pour les stimuli vibrotactiles.
- *Cou (postérieur)*~: \~30--40~mm.
- Les 8~moteurs du collier HAPTIC.SKIN à \~45~mm d'espacement et les 4~moteurs de bracelet à \~40--45~mm sont au-dessus de ces seuils. @weinstein

#figure(
  image("images/motor_placement.png", width: 70%),
  caption: [Placement des moteurs sur le corps. 8~moteurs autour du cou (espacement \~45~mm) et 4~par poignet (espacement \~40~mm). Les points verts représentent les capteurs IMU.],
) <fig-placement>

*Loi de Weber*~: La différence juste perceptible (JND) en intensité de vibration est \~17--21\% de l'intensité de référence. Cela donne seulement 4--5~niveaux d'intensité perceptuellement distinguables (pas les 4096 du PWM 12~bits du PCA9685). Implication pratique~: des paliers d'intensité à 0, 0,25, 0,50, 0,75, 1,0 suffisent. @craig

*Résolution temporelle*~: La perception confortable de patterns séquentiels nécessite 50--200~ms d'espacement par élément. Un "swipe" à travers 4~moteurs devrait durer 200--500~ms. @gescheider

== Placement Optimal des Actionneurs

*Cou (8~moteurs)*~: Bonne sensibilité vibrotactile sur les surfaces postérieures et latérales. Recherche sur les colliers haptiques (Kaul et al., 2016)~: 95\% de précision de reconnaissance directionnelle. @kaul-neck

*Poignet (4~moteurs chacun)*~: Études montrant 90,6\% de précision de localisation avec 4~moteurs au poignet, et fait intéressant, 4~moteurs surpassent 8 en préférence utilisateur (modèle mental plus simple). @cholewiak

*Sensations fantômes*~: En variant l'intensité relative de deux moteurs adjacents, une vibration perçue peut être créée entre eux. Le "Tactile Brush" d'Israr et Poupyrev~(2011) a démontré que cela double la résolution spatiale effective. Les 8~moteurs du collier peuvent créer l'illusion de 16~positions~; les 4~du bracelet peuvent simuler 8. @tactile-brush

== Évaluation TRL

#figure(
  table(
    columns: 3,
    align: (center, left, left),
    table.header(
      [*TRL*], [*Description*], [*Statut HAPTIC.SKIN*],
    ),
    [1], [Principes de base observés], [Complet],
    [2], [Concept technologique formulé], [*Actuel (avril 2026)*],
    [3], [Preuve de concept expérimentale], [Cible~: mai 2026],
    [4], [Technologie validée en labo], [*Cible~: soutenance juillet 2026*],
    [5], [Validation en environnement réel], [Post-projet (stretch)],
  ),
  caption: [Progression TRL. Objectif pour la soutenance~: TRL~4 avec démonstration fonctionnelle en laboratoire.],
)

#colbreak()

// ============================================================
= Éco-Conception et Durabilité
// ============================================================

L'éco-conception est un axe obligatoire du programme ingénieur EFREI. Une étude 2025 dans Nature a montré que chaque dispositif portable génère 1,1--6,1~kg~CO#sub[2]-équivalent, les PCB représentant \~70\% de l'empreinte carbone totale. @nature-ecodesign

== Analyse d'Impact Environnemental

#figure(
  image("images/eco_comparison.png", width: 90%),
  caption: [Comparaison de l'empreinte carbone. HAPTIC.SKIN (2--4~kg~CO#sub[2]-eq) a un impact significativement plus faible que les alternatives commerciales et les appareils électroniques grand public.],
) <fig-eco>

#figure(
  table(
    columns: 4,
    align: (left, center, center, center),
    table.header(
      [*Critère*], [*HAPTIC.SKIN*], [*bHaptics*], [*Teslasuit*],
    ),
    [Composants BOM], [\~20], [\~200+], [\~500+],
    [Batterie], [Aucune (USB)], [35,6~Wh LiPo], [Grande LiPo],
    [Consommation], [0,3--2~W], [2--5~W], [10--20~W],
    [Radio sans fil], [Aucune], [Bluetooth], [WiFi + BT],
    [Réparabilité], [Haute (THT, docs ouvertes)], [Faible (propriétaire)], [Nulle (scellé)],
    [Pérennité logicielle], [Infinie (FOSS)], [Dépendante du vendeur], [Dépendante du vendeur],
    [CO#sub[2]-eq estimé], [2--4~kg], [15--30~kg], [50+~kg],
  ),
  caption: [Comparaison éco-conception. La conception minimale et ouverte de HAPTIC.SKIN a un impact environnemental significativement plus faible.],
)

*Avantage clé~: pas de batterie.* La production de Li-ion représente 61--106~kg~CO#sub[2]-eq par kWh de capacité. La batterie seule du bHaptics (\~35,6~Wh) représente \~2--4~kg~CO#sub[2]-eq rien que pour la fabrication.

== Choix de Conception Durables

HAPTIC.SKIN s'aligne avec la norme IEC~62430:2019 (Conception éco-responsable) et le Règlement ESPR de l'UE (2024/1781)~:

- *Modularité*~: 3~wearables séparés avec câbles détachables~; moteurs remplaçables individuellement via connecteurs JST.
- *Réparabilité*~: Composants traversants (soudables à la main), connecteurs standards, schémas open-source. Anticipe la Directive Droit à la Réparation de l'UE~(2024/1799, effective juillet 2026). @right-to-repair
- *Choix de matériaux*~: Filament PLA (bioplastique biodégradable) pour les montages rigides~; coton bio/chanvre pour les bandes en contact avec la peau~; soudure sans plomb (RoHS).
- *Longévité*~: Pas de dépendance cloud, pas d'abonnement, pas de mises à jour forcées. Firmware open-source maintenu par la communauté.
- *Fabrication locale*~: Reproductible avec des composants standard et une imprimante 3D partout dans le monde.

== Énergie et Cycle de Vie

*Énergie en utilisation*~: 0,3--2~W typique. À 1h/jour, \~0,36~kWh/an --- négligeable vs un smartphone (\~50--100~kWh/an).

*Conception pour le démontage*~: Connexions par vis/clips (pas de colle), étiquettes matériaux sur les boîtiers, électronique séparée des textiles par conception.

*Fin de vie*~: Les moteurs ERM contiennent des aimants terres rares (néodyme) --- compromis honnête à reconnaître. Métaux de PCB partiellement récupérables via collecte DEEE. Pièces PLA compostables industriellement.

*Comment présenter l'éco-conception de manière convaincante*~: (1)~Commencer par le chiffre 2--4~kg~CO#sub[2]-eq vs 15--30~kg pour les concurrents. (2)~Présenter "pas de batterie" comme un choix architectural délibéré. (3)~Positionner l'open-source comme économie circulaire. (4)~Inclure un diagramme de cycle de vie. (5)~Créer un tableau passeport matériaux. (6)~Référencer ESPR, Droit à la Réparation, IEC~62430. (7)~Reconnaître honnêtement les limites (extraction du néodyme).

#colbreak()

// ============================================================
= Leçons des Projets Similaires
// ============================================================

== Revue des Projets Étudiants et Académiques

*Projets directement pertinents*~:

- *Wearable Haptic Bands (Hackster.io)*~: Le plus proche --- 6~bandes haptiques, ESP32-C3 + moteurs ERM, protocole ESP-NOW. Topologie multi-dispositifs distribuée validée. @hackster-bands
- *Fyber Labs PCA9685 ERM Flex Module*~: Valide l'approche exacte PCA9685 + ERM. PCB flexible avec matrice de moteurs.
- *SenseShift*~: Firmware ESP32 pour gilets haptiques DIY, 16--40~moteurs. Communauté active avec guides de montage. @senseshift
- *Google VHP*~: Référence en haptique open-source. 12~canaux, nRF52840, Apache~2.0. @google-vhp
- *Snaptics (Rice University)*~: Plateforme modulaire, publiée IEEE. Système WRIST primé du même laboratoire. @snaptics

== Écueils Courants

Basé sur l'analyse de 15+~projets similaires~:

+ *Le PCA9685 ne peut pas piloter les moteurs directement.* Ses sorties plafonnent à 10--25~mA~; les ERMs ont besoin de 80--100~mA. *Les ULN2803A ou MOSFETs sont obligatoires.* C'est l'erreur \#1 des projets similaires.
+ *Diodes de flyback requises.* Sans diodes 1N4148 sur chaque moteur, les pics de contre-EMF endommagent le driver et le MCU.
+ *Dépassement du budget puissance.* 16~moteurs à pleine intensité tirent \~1,2A, dépassant la limite USB de 500~mA. Alimentation externe ou limitation firmware nécessaire.
+ *Dégradation I2C sur câbles longs.* Cou-vers-poignet = 30--60~cm. Réduire l'horloge I2C à 100~kHz, utiliser des pull-ups de 2,2--4,7~kOhm.
+ *Fatigue des fils.* Les fils rigides aux articulations du poignet cassent en quelques jours. Utiliser du fil torsadé isolé silicone avec décharge de traction à chaque point de soudure.
+ *Interférence moteur-IMU.* Les moteurs ERM génèrent du bruit affectant les lectures IMU. Lignes d'alimentation séparées, condensateurs de découplage 100~µF, maximiser la distance physique.
+ *Empilement de latence.* Chaîne complète~: USB (\~1~ms) + I2C PCA9685 (\~2--3~ms) + démarrage moteur (\~50~ms) = 20--50~ms total.
+ *Sur-dimensionnement du scope.* Commencer par 1~bracelet de bout en bout, puis répliquer.

== Réalisme du Calendrier

*Verdict~: 3~mois est réaliste pour une démo fonctionnelle, mais pas pour la vision complète.*

#figure(
  image("images/timeline.png", width: 95%),
  caption: [Planning Gantt du projet sur 13~semaines. Les jalons obligatoires (Challenge Me~1 et 2, Soutenance) sont marqués en rouge.],
) <fig-timeline>

*Réduction de scope si retard*~: Descendre à 1~collier + 1~bracelet (12~moteurs), garder uniquement les gestes lever/secouer, se concentrer sur une seule démo soignée (navigation à l'aveugle).

*Première action critique*~: Commander les composants immédiatement et prototyper le circuit PCA9685~+~ULN2803A~+~moteur. C'est l'élément matériel à plus haut risque.

#colbreak()

// ============================================================
= Recommandations et Prochaines Étapes
// ============================================================

== Direction Technique Recommandée

- *MCU*~: Raspberry Pi Pico, firmware MicroPython
- *Actionneurs*~: 16× moteurs ERM coin (10~mm)
- *Driver PWM*~: PCA9685 + 2× ULN2803A + 16× diodes 1N4148
- *IMU*~: 2× MPU6050 (breakout GY-521)
- *Communication*~: USB série (Pico vers PC), pyserial-asyncio côté hôte
- *Démon*~: Python~3 asyncio, IPC socket Unix + WebSocket/REST optionnel
- *Format de patterns*~: JSON timeline avec keyframes par moteur
- *Boîtier*~: Supports 3D imprimés PLA/PETG + bandes tissu/néoprène
- *BOM total*~: \~63~EUR

== Stratégie de Démonstration

Séquence de 3~démos pour la soutenance du 3~juillet (5~min total)~:

+ *Musique-vers-vibration (30~s)*~: Accroche émotionnelle. Un membre du jury porte le collier et ressent une chanson. Python librosa pour l'analyse fréquentielle temps réel.
+ *Navigation à l'aveugle (2~min)*~: Interactif. Un volontaire les yeux bandés est guidé à travers un parcours d'obstacles en utilisant uniquement les vibrations du collier. Contrôle Wizard-of-Oz via clavier ou GPS connecté au téléphone.
+ *Communication silencieuse bidirectionnelle (2~min)*~: Profondeur technique. Deux personnes~: l'une fait un geste (détecté par IMU), l'autre ressent le pattern vibratoire. Démontre la plateforme complète.

Progression~: réception passive → interaction active → communication bidirectionnelle complète. Chaque démo ajoute de la complexité et démontre une nouvelle capacité.

== Matrice de Risques

#figure(
  table(
    columns: 4,
    align: (left, center, center, left),
    table.header(
      [*Risque*], [*Prob.*], [*Impact*], [*Atténuation*],
    ),
    [Retard livraison composants], [Moy.], [Élevé], [Commander semaine~1, backup Amazon],
    [Pilotage moteur PCA9685], [Élevé], [Critique], [ULN2803A + diodes flyback (validé)],
    [Pannes câblage I2C], [Élevé], [Moyen], [Fil torsadé, décharge de traction],
    [Dépassement budget puissance], [Moy.], [Moyen], [Limitation firmware, max 6~moteurs],
    [Inconfort du wearable], [Élevé], [Moyen], [3+ itérations design, TPU flexible],
    [Dérive du scope], [Élevé], [Élevé], [Verrouiller les features semaine~4],
    [Interférence moteur-IMU], [Moy.], [Faible], [Bus I2C séparés, condensateurs],
    [Fiabilité de la démo], [Moy.], [Critique], [Patterns pré-programmés, répétitions],
  ),
  caption: [Matrice de risques. Le pilotage moteur et la dérive de scope sont les risques prioritaires.],
)

== Plan de Sprints Suggéré (13~semaines)

+ *Sprint~0 (10--13~avr.)*~: Lancement, commande composants, attribution des rôles.
+ *Sprint~1 (14--20~avr.)*~: Prototype breadboard~: Pico + PCA9685 + ULN2803A + 4~moteurs. _Focus~1 (État de l'Art)._
+ *Sprint~2 (21--27~avr.)*~: Ajout MPU6050, détection gestuelle basique. Squelette du démon. _Focus~2 (Réflexion Marché)._
+ *Sprint~3 (28~avr.--4~mai)*~: Bracelet de bout en bout. _Focus~3 + *Challenge Me~1*._
+ *Sprint~4 (5--18~mai)*~: Extension au collier (8~moteurs). Premier essai de boîtier 3D.
+ *Sprint~5 (19~mai--1~juin)*~: Moteur de patterns. 10+ patterns haptiques définis.
+ *Sprint~6 (2--15~juin)*~: Second bracelet. Raffinage reconnaissance gestuelle. API client.
+ *Sprint~7 (16--22~juin)*~: Développement scénarios de démo. _*Challenge Me~2*._
+ *Sprint~8 (23~juin--2~juil.)*~: Polish boîtier, tests d'intégration. _Soutenance blanche (2~juil.)._
+ *Sprint~9 (3~juil.)*~: *Soutenance finale + démo live.*
+ *Sprint~10 (3--6~juil.)*~: Finalisation rapport + poster. _Deadline~: 6~juil._

#colbreak()

// ============================================================
= Références
// ============================================================

#bibliography("refs.yml", style: "ieee")
