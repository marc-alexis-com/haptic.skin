+----------------------------------------------------------------------+
| **Template for System Requirements Specification (CDC)**             |
+======================================================================+
| The template starts on the following page                            |
+----------------------------------------------------------------------+
| **What this is**                                                     |
|                                                                      |
| An annotated outline for a system requirements specification         |
| (*Cahier des Charges* in French) in the ING3 PFE project. Note that  |
| we retain the abbreviation of the French term (CDC) for the PFE.     |
|                                                                      |
| The CDC is created early in the project to describe the requested    |
| behavior of a system, generally through the task of requirements     |
| analysis (*analyse fonctionnelle* in French).                        |
+----------------------------------------------------------------------+
| **Why it's useful**                                                  |
|                                                                      |
| The success of a system is determined by the extent to which it      |
| satisfies the end user's or client's requirements. The CDC           |
| formalizes these requirements by the definition of functions         |
| (services) required of, and constraints imposed on, the system by    |
| the client.                                                          |
|                                                                      |
| The CDC supports a dialogue between the client and the project team  |
| that helps the project team understand what the client needs.        |
|                                                                      |
| For each function the CDC defines measurable criteria and expected   |
| values that will be useful to quantitatively measure the degree to   |
| which the realized system satisfies the client's needs.              |
|                                                                      |
| The CDC defines the problems that the system must solve and a set of |
| measurable criteria that allow the team to provide the optimal       |
| response to the requirements.                                        |
|                                                                      |
| The CDC defines an initial project plan for satisfying requirements, |
| that can work as a sanity check : Do we have the resources (human    |
| and material) to satisfy these requirements?                         |
+----------------------------------------------------------------------+
| **How to use it**                                                    |
|                                                                      |
| The CDC is drafted in the early stages of the project, through the   |
| task of functional analysis.                                         |
|                                                                      |
| This template is a guide and should be followed where appropriate,   |
| but students should not artificially fill sections that do not apply |
| to them.                                                             |
|                                                                      |
| The template may and should be adapted to fit your project's         |
| specificities, [subject to the approval of your mentor]{.underline}. |
|                                                                      |
| When preparing the document, remember to remove this information     |
| page and the help text (generally in *italics*) included in the      |
| guide, and replace the different placeholders (document code, logos, |
| publication dates ...) with details specific to your project.        |
|                                                                      |
| Références officielles                                               |
|                                                                      |
| 📘 ***IEEE 29148-2018 (Systems and Software Engineering -- Life      |
| Cycle Processes -- Requirements Engineering***)                      |
+----------------------------------------------------------------------+

  ----------------------------------- ----------------------------------------------------
  Partner logo if                       ![](media/image1.gif){width="2.0833333333333335in"
                                                            height="0.8333333333333334in"}

  ----------------------------------- ----------------------------------------------------

  ----------------------------------- -----------------------------------

  ----------------------------------- -----------------------------------

Project logo

System Requirements Specification

for

Project name

[A TELERGER]{.mark}

ING3-CDC-PROJECTCODE-YYYYMMDD

Publication Date

  -----------------------------------------------------------------------
  Mentor                
  --------------------- -------------------------------------------------
  Partner / Client      

  Keywords / Mots-clés  3 à 5 mots-clés représentatifs

  Short description /   5--6 lignes : objectif du projet, problème
  Résumé                traité, solution envisagée, principaux enjeux
                        techniques et sociétaux.

  Expected deliverables Liste synthétique (prototype, rapport,
  / Livrables attendus  démonstrateur, etc.)

  Sustainable impact /  Indiquez l'impact environnemental ou sociétal
  Impact durable        visé (ex. réduction d'énergie, accessibilité,
                        data for good).
  -----------------------------------------------------------------------

#  Revision history

*Use the revision history to document the changes included in each new
[published]{.underline} version.*

  ----------------------------------------------------------------
  Date     Author(s)        Description of changes
  -------- ---------------- --------------------------------------
                            

                            

                            

                            

                            
  ----------------------------------------------------------------

# 

#  Table of Contents

*The table of contents should preferably fit on a single page for
readability and navigability. Playing with the TOC styles can help get
it to fit.*

#  Scope & Purpose

*Scope paragraph describing the system's boundaries, actors, and
context.*

*Explain the purpose of the requirements document - design, call for
tenders, consultation with service providers, school project, etc.
Clarify what the reader can expect to find in this document.*

# References and terminology

## Reference documents

*List all documents directly referred to by this CDC, as well as
additional documents that may be useful to understand the CDC or place
it in a particular context.*

  -----------------------------------------------------------------------------------------
  **Document**   **Number**   **Attached?**   **Application**
  -------------- ------------ --------------- ---------------------------------------------
  Document name  Code,        Yes/No          The role of the document relative to the CDC
                 number,                      
                 version                      

  -----------------------------------------------------------------------------------------

## Glossary

specify: standards, contractual documents, and a unified glossary.

### Terms

*Define all terms used in the CDC that are unlikely to be familiar to
the reader. This should include rare and unusual words, unusual
interpretations of common words and domain-specific jargon.*

  -------------------------------------------------------------------------
  **Term**   **Definition**
  ---------- --------------------------------------------------------------
  Term       Definition

  -------------------------------------------------------------------------

### Acronyms

*Define the meaning of all acronyms and abbreviations used in the CDC.
When the literal meaning of the acronym or abbreviation is not
sufficiently clear or precise, provide an additional explanatory text.*

  -------------------------------------------------------------------------------
  **Acronym**   **Meaning**   **Explanation**
  ------------- ------------- ---------------------------------------------------
  Acronym       Meaning       Explanation

  -------------------------------------------------------------------------------

# Stakeholder Needs & Business Context

Highlight stakeholder needs (client, users, partners) and the business
justification

*In the sub sections that follow, describe the role and use of the
system, and place it in its enclosing context. Please note: The
discussion should concern the final "target" system and not be limited
to the prototype that will be developed in the PPE (we will define the
prototype in detail in a later document).*

## Initial justification

*Describe the original need that is the origin of justification for this
system. If the system is part of a larger system, describe the original
need of that system, and the role of your system in the whole. Identify
the final user(s) and define the main nominal use cases. An UML use case
diagram and a sketchnote representation would be valuable to provide a
macro-level understanding of the project.*

*Clarify the major characteristics of the need for this system: Who
needs it? Why? When? How? How much? For how long ...? Clarify the
expected benefits of the system for the client / end users.*

*Describe how it is expected that the need will evolve over time:
Potential for growth, integration of new needs, integration of new
interfaces, etc.*

## Context / State of the art

*This section may be a development (more detailed explanation) of the
initial justification above, or an entirely distinct discussion. The
objective of this section is to provide a clear description of existing,
related, or competing systems within the same context, in order to
highlight the difference or added value of your system. If your
valorization requires a complete state-of-the-art study, provide a
summary here with a reference to a separate document. Include a
comparative table with a list of functional and technical criteria
justifying the selection of the new product or solution*

## Valorisation strategy

*Describe the strategy that you will be developing to valorize the
contribution of this system.*

#  Requirements Definitions

*This is the heart of the CDC document.*

## System Lifecycle

*Identify the initial and final states of the system (the state from
which the system is considered to exist and the states leading to its
end of life).*

*Define the other distinct states or phases that the system will go
through during its lifecycle, based on the principles of Green IT and
eco-design.*

*These principles aim to reduce the system's environmental footprint at
each stage (design, use, maintenance, end of life) and to include
measurable indicators such as energy consumption, component lifespan, or
effective usage rate.*

*If the system has multiple modes of operation, describe each as a
distinct state.*

*You must provide a graphical representation of the system's lifecycle.
Both informal and formal formats (such as a UML state diagram) are
acceptable.*

## Functional Requirement

*Identify the different actors (users) of the system and the use cases
for each one. Provide a use case diagram and a sequence diagram to
illustrate the scenario*

##  Non Functional Requirements

*Specify the key qualities and attributes that the system must
demonstrate, such as:*

- ***Performance:** Define how quickly the system should respond to user
  requests or process transactions.*

- ***Scalability:** Describe how effectively the system can handle
  increases in users, data volume, or workload without performance
  degradation.*

- ***Security:** Explain how the system will protect against
  unauthorized access, data breaches, and other security threats.*

- ***Usability:** Specify how intuitive and user-friendly the system
  should be, ensuring an efficient and pleasant user experience.*

- ***Maintainability:** Indicate how easily the system can be updated,
  modified, or debugged over time.*

## Systeme Constraints

*Identify the technical, regulatory, security, and other relevant
constraints affecting the system*

### Traceability / Acceptance

## System Environment

*Identify and define all external actors (users and systems --* milieu
extérieurs*) making up the system's environment that act on or influence
the system, or are acted on or influenced by the system, during each of
the lifecycle state(s) of the system takes place.*

*The environment actors and their relationship to the system must be
represented graphically. A UML use case or context diagram may be
appropriate for software-intensive systems.*

### Non-Functional Requirements

## System Functions

*Define the functions that the system must provide (see the definition
of a system function in the course notes).*

*For each function, identify the related actor and the corresponding
lifecycle phase of the system, and explain the added value that this
function brings to the actor.*

*Each function should be clearly written as a response to a specific
need expressed by an actor.*

*For clarity, you can group functions by actor, by purpose (added
value), or in a logical hierarchy.*

*It is recommended to start with the main (key) functions, followed by
secondary (support) functions.*

*You may also indicate the priority or importance of each function, but
this information will also appear in the table below.*

### *Make sure to number and name each function to ensure traceability in later project documents.*Key functions

#### Function F1: Function name

#### Function F1.2: Sub-function name

### Support functions

#### Function F2: Function name

### Functions required by actor X

#### Function F3: Function name

### Functions required by actor Y 

#### Function F4: Function name

#### Function F5: Function name

![](media/image2.png){width="6.302083333333333in"
height="5.010416666666667in"}

## System Constraints

*Describe the constraints that the system must satisfy. The lifecycle
can impose unexpected constraints that are not immediately obvious. Some
examples of constraints are:*

- Design constraints: *By design constraint we mean any nonfunctional
  requirement that limits the freedom of the system designer. May
  include security, scientific, legal, licensing, ergonomics, patents,
  platform, technology ... Describe and discuss the impact of each
  constraint in a new sub section.*

- Industrial and logistical constraints: *This includes nonfunctional
  requirement imposed by the fabrication and distribution methods.*

- Organizational constraints: *This includes nonfunctional requirement
  imposed by the organization in which the system will be used on the
  operation and use of the system.*

*Organise the system constraints as appropriate for your system. The
more complete you are now, the less suprises you will have later on!
**Number and name each constraint for traceability in later
documents.***

## Verification & Validation Criteria

*For each requirement (function and constraint), define the acceptance
criteria (one or many) that will be used to judge whether that
requirement is satisfied or not, and the "level" expected of each
criterion. If a requirement has no measurable criteria then it has no
impact on the system and is not a requirement, but a design choice, and
should be removed from the list of requirements.*

*Define the flexibility of each requirement. This should include which
requirements are not negotiable (I.e. must be implemented during the
project) and those which are. Within this subdivision, assign a priority
to each requirement.*

+-----------+------------+----------------------------+---------------------+-----------------+
| **Actor** | **Number** | **Requirement**            | **Acceptance**      | **Flexibility** |
+:=========:+:==========:+:==========================:+:=========:+:=======:+:===============:+
| Actor     | F1.4       | Function                   | Criterion | Level   | Negotiable?\    |
|           |            |                            |           |         | Priority        |
| Actor     | C1.2       | Constraint                 | Criterion | Level   |                 |
|           |            |                            |           |         | Negotiable?\    |
|           |            |                            |           |         | Priority        |
+-----------+------------+----------------------------+-----------+---------+-----------------+

# Project Planning & Configuration Management

This section serves to provide a rough initial map for building the
system that will satisfy these requirements. It identifies -- at a very
high level - **who**, **when** and **what** will be produced during the
project.

## Actors

*List the important stakeholders of this project. Describe their
interest, involvement and expectations. Provide contact details for
each. This list should include AT LEAST the mentor, the cluster
director, the valorization coach and the external partner or client (if
there is one, as formalized in the convention).*

## Team 

*Identify the project team members involved in this project. For each
team member, provide their full name, phone number, email address, and
professional photograph (team trombinoscope).*

*Identify the roles required for this project. Describe the activities
and responsibilities associated with each role, and specify who does
what and who makes which decisions. Roles may be shared among several
team members, and one person may hold multiple roles. The Project
Manager role is mandatory and must be assigned to a single team member.*

*To clarify responsibilities, create a RACI matrix (Responsible,
Accountable, Consulted, Informed) linking each project activity or
deliverable to the corresponding team members and roles. This matrix
helps ensure transparency in task ownership and decision-making
throughout the project.*

  ------------------------------------------------------------------------
  *Role*         *Responsibilities*                     *Team members*
  -------------- -------------------------------------- ------------------
  *Project       *Task planning and allocation,         *Joe Student*
  Manager*       progress monitoring and reporting,     
                 primary interface with mentor and      
                 partner.*                              

  *Software      *Java coding and unit-testing.*        *Jane Student, Bob
  developer*                                            Student*

  *Quality       *Document quality control, acceptance  *Bob Student*
  Engineer*      test plan, version management.*        

  *...*                                                 
  ------------------------------------------------------------------------

## Milestones

*Provide the start and end dates of the project, as well as important
project dates imposed by the stakeholders (notably deliverables and
activities imposed by the PPE process PLUS the partner company PLUS the
valorization coaching). You may produce a GANTT, but this is not
required at this stage. DO NOT perform a detailed work breakdown and
planning (or at least do not include it in this document): Restrain
yourself to the macro phases and tasks imposed and the deliverables
expected.*

# Traceability Matrix & Glossary  {#traceability-matrix-glossary .Appendix}

Requirement ↔ Criterion ↔ Test ↔ Result.

#  {#section-1 .Appendix}

*Please use French section titles if your document is in French.*

Historique de versions

Table de matières

1 Objet

2 Documents et terminologie

2.1 Documents de référence

2.2 Terminologie

2.2.1 Termes

2.2.2 Acronymes

3 Justification et valorisation du système

3.1 Justification du besoin initial

3.2 Contexte / Etat de l'art

3.3 Stratégie de valorisation

4 Exigences

4.1 Processus de vie

4.2 Environnement

4.3 Fonctions du système

4.3.1 Fonctions clés

4.3.2 Fonctions secondaires

4.3.1 Fonctions pour acteur X

4.3.1 Fonctions pour acteur Y

4.4 Contraintes

4.5 Critères d'acceptation

5 Feuille de route

5.1 Acteurs

5.2 Equipe

5.1 Jalons et livrables

# Intégration des compétences de la grille dans le CDC V2 {#intégration-des-compétences-de-la-grille-dans-le-cdc-v2 .Appendix}

  ------------------------------------------------------------------------
  Section du CDC   Lien avec la grille de Commentaire d'intégration
                   compétences (GRILLE    
                   EVAL RAPPORT           
                   101125.xlsx)           
  ---------------- ---------------------- --------------------------------
  1\. Scope &      \[A304\] Reformuler la Évaluer la capacité à définir
  Purpose          demande de             clairement le besoin et les
                   l'utilisateur          objectifs du projet.

  3.1 Initial      \[A304\], \[E108\]     Identifier le besoin initial et
  Justification                           ses impacts sociaux,
                                          environnementaux ou économiques.

  3.2 Context /    \[E104\], \[E108\]     Analyse critique du contexte,
  State of the Art                        recherche d'indicateurs qualité
                                          et prise en compte du
                                          développement durable.

  4.1 System       \[E107\] Intégrer la   Appliquer les principes Green IT
  Lifecycle        durabilité dans le     / Éco-conception, définir des
                   cycle de vie           indicateurs environnementaux.

  4.2 Functional   \[A202\], \[B202\]     Capacité à spécifier des
  Requirements                            exigences claires, mesurables et
                                          traçables.

  4.3              \[E104\], \[E106\]     Définir les critères de
  Non-Functional                          performance, sécurité, ergonomie
  Requirements                            et qualité.

  4.6 System       \[A304\], \[E104\]     Identifier les fonctions clés
  Functions                               répondant à des besoins
                                          utilisateurs et quantifiables.

  4.7 System       \[E106\], \[E107\]     Prendre en compte les
  Constraints                             contraintes techniques,
                                          environnementales et
                                          réglementaires.

  4.8 Verification \[E104\], \[C202\]     Définir les critères de
  & Validation                            validation et la traçabilité
  Criteria                                exigences ↔ tests.

  5.1 Actors       \[E105\]               Identifier les parties prenantes
                                          et leurs rôles dans la
                                          gouvernance du projet.

  5.2 Team + RACI  \[E105\], \[C203\]     Travailler en équipe, répartir
  Matrix                                  les responsabilités, formaliser
                                          la gouvernance.

  5.3 Milestones   \[C201\], \[C202\]     Structurer la feuille de route,
                                          planifier les livrables, assurer
                                          le suivi projet.
  ------------------------------------------------------------------------
