# `efrei/` — livrables académiques EFREI Innovation Projects

> Tout le matériel pédagogique et les livrables académiques de la matière
> *Innovation Projects ING2 (FP2MAS-2526PSP01)*. Importé depuis Moodle le
> 2026-05-18 via `MoodleSession`.

Le projet technique (firmware, daemon, hardware) vit dans le reste du
repo ; **ce dossier est dédié aux livrables académiques** : focus de cours,
cahier des charges, peer eval, rapport final LaTeX, poster.

## Index

### 📥 Matériel pédagogique (téléchargé depuis Moodle)

| Item | Dossier | Source PDF |
|---|---|---|
| Présentation Kick Off | [`kickoff/`](kickoff/slides.md) | `_raw/kickoff.pdf` (19 MB, 252 images) |
| Focus 1 — État de l'art | [`focus-1-etat-de-l-art/`](focus-1-etat-de-l-art/slides.md) | `_raw/focus-1.pdf` (2.1 MB, 144 images) |
| Focus 2 — Marché | [`focus-2-marche/`](focus-2-marche/slides.md) | `_raw/focus-2.pdf` (2.9 MB, 153 images) |
| Focus 3 — Vision Produit | [`focus-3-vision-produit/`](focus-3-vision-produit/slides.md) | `_raw/focus-3.pdf` (6.5 MB, 151 images) |
| Focus 4 — Sketchnote & Business Model | [`focus-4-business-model/`](focus-4-business-model/slides.md) | `_raw/focus-4.pdf` (3.2 MB, 71 images) |
| Focus 5 — Veille Stratégique | [`focus-5-veille-strategique/`](focus-5-veille-strategique/slides.md) | `_raw/focus-5-veille.pdf` (7.2 MB, 261 images) |
| Peer Eval — Consignes étudiants | [`peer-eval-consignes/`](peer-eval-consignes/consignes.md) | `_raw/peer-eval-consignes.pdf` (726 KB, 46 images) |
| Peer Eval — Grille travail en équipe | [`peer-eval-grille/`](peer-eval-grille/grille.md) | `_raw/peer-eval-grille.pdf` (128 KB, 2 images) |
| Cahier des charges — trame | [`cdc-trame.md`](cdc-trame.md) | `_raw/cdc-trame.docx` |
| Template LaTeX (NeurIPS 2026) | [`rapport-final/`](rapport-final/) | `_raw/neurips-template.zip` |
| ChallengeMe (peer eval externe) | URL Moodle id=129112 | https://moodle.myefrei.fr/mod/url/view.php?id=129112 |

Chaque dossier de focus contient :
- `slides.md` — texte extrait page par page, avec références aux images
- `images/` — toutes les figures du PDF extraites (PNG/JPG, format
  original)

Les PDFs originaux restent dans `_raw/` pour consultation humaine
(mise en page intacte, recherche fulltext dans Zathura, etc.).

### 🚧 Livrables à produire (stubs vides)

| Livrable | Fichier | Deadline EFREI |
|---|---|---|
| Cahier des charges | [`cdc.md`](cdc.md) | — (en continu) |
| RACI équipe | [`raci.md`](raci.md) | dès kickoff |
| Notes Focus 5 (Veille) — exercice | [`focus-5-veille-strategique/notes.md`](focus-5-veille-strategique/notes.md) | aujourd'hui 2026-05-18 |
| Compte-rendus RDV mentor | [`reunions/`](reunions/) | au fil de l'eau |
| Rapport final (LaTeX) | [`rapport-final/main.tex`](rapport-final/) | **2026-07-06** |
| Poster A0 | [`poster/`](poster/) | **2026-07-03** soutenance, 2026-07-16 Poster-Prize |
| Notes peer eval | [`peer-eval/notes.md`](peer-eval/notes.md) | en cours d'année |

## Calendrier EFREI (rappel)

| Date | Activité |
|---|---|
| 2026-04-10 | Kick-off |
| 2026-04-20 | Focus 1 — État de l'art |
| 2026-04-27 | Focus 2 — Marché |
| 2026-05-04 | Focus 3 — Vision Produit · **Challenge Me 1 (obligatoire)** |
| 2026-05-15 | Focus 4 — Sketchnote & Business Model |
| **2026-05-18** | **Focus 5 — Veille Stratégique (aujourd'hui)** |
| 2026-06-03 | Focus 6 — Création d'un poster |
| 2026-06-12 | Focus 7 — Preuve de concept / TRL |
| 2026-06-17 | Focus 8 — Bien préparer sa démo |
| 2026-06-22 | Focus 9 — Quand le projet sera-t-il terminé · **Challenge Me 2** |
| 2026-07-02 | Soutenance blanche (Factory) |
| **2026-07-03** | **Soutenance finale + Poster-Prize Demo (Bat New Republic)** |
| 2026-07-06 | Deadline dépôt rapport final |
| 2026-07-16 | Poster-Prize Campus |

## Modalités d'évaluation

- **Note rapport** — production collective équipe
- **Note soutenance** — poster + démo
- **Note contrôle continu** :
  - évaluation mentor (équipe + individuelle)
  - évaluation par les pairs (ChallengeMe — voir [`peer-eval-consignes/consignes.md`](peer-eval-consignes/consignes.md) et [`peer-eval-grille/grille.md`](peer-eval-grille/grille.md))

## Qui bosse sur quoi

- **MONEYMAKER** (Lilou) — pilote `efrei/` : rapport, poster, focus, business model, marché, planning
- **FEUILLE** (Pierre) — contribue état de l'art scientifique pour rapport + focus
- **ROBOTNICS + BOUFFEUR DE CODE** — fournissent les éléments techniques pour le rapport et la démo

## Notes

- Les PDFs originaux sont volumineux (~41 MB cumulés). Si on veut les
  exclure de git plus tard : ajouter `efrei/_raw/*.pdf` au `.gitignore`
  et `git rm --cached`. Pour l'instant on garde tout commité pour que
  l'équipe ait tout au même endroit sans devoir refetcher Moodle.
- Le template "Modèles pour LaTeX" qu'EFREI fournit est le template
  **NeurIPS 2026**. Si l'école veut un format spécifique (logo EFREI,
  page de garde standard), il faudra adapter.
- Le cookie Moodle utilisé pour ce téléchargement a été supprimé à la
  fin de l'opération. Si on veut re-fetch (Focus 6+, nouveaux
  documents), il faudra recommencer la même procédure.
