# History

This folder holds the working record behind the template. It is published for transparency and for readers who want the reasoning. You do not need it to use the template. Start with [../docs/how-to-use-the-logs.md](../docs/how-to-use-the-logs.md).

## Contents

- `decision-log.md`: decisions, motivations, alternatives, limits.
- `discovery-log.md`: surprises and corrected assumptions.
- `experiments/`: completion cards for EXP-01, EXP-02 (five rounds and a summary) and EXP-03, plus the EXP-03 setup plan.
- `experiments/reference-runs/`: saved calibration-run and dry-run reports that evidence the check scripts.

## Provenance

The files are records of one operator's work. Most log entries were reconstructed from transcripts after the experiments. Names such as `hello.gd` and `experiments/exp_03/` refer to the original working repository. The calibration task in `../calibration/` was built afterwards and is not described in these files.

## Publication edits

The files were copied unchanged, except for the edits listed here. Most replaced personal or environment-specific text. Some removed passages that depended on private project material that a reader could not use; those are marked "removed".

| File | Edit | Reason |
|---|---|---|
| `history/` files | Pre-agreed edit A: replace filename `tooling-agent-decision-log.md` with `decision-log.md` | 0 replacements made: the repository copy already uses `decision-log.md`; no old-name references were found |
| `history/experiments/EXP-01-completion-card.md` | Pre-agreed edit B: replaced the local project path in the setup table, section 1, with `<project-path>` | Absolute local path exposed the user name and machine layout |
| `history/experiments/EXP-01-completion-card.md` | Pre-agreed edit C, section 7 table: replaced the meter readings `5-hour 0%, weekly 0%, monthly 0% (resets in ~3h58m / 4d3h / 27d23h)` and the token counters `about 8k tokens (earlier fresh session: about 4.7k)` with `(omitted for publication)` | Exact usage and reset-countdown figures replaced for publication; interpretive text kept |
| `history/experiments/EXP-01-completion-card.md` | Pre-agreed edit C, section 7 note: replaced the paid-model monthly-limit figure with `(omitted for publication)` | Currency amount replaced; interpretive text kept |
| `LICENSE` | Pre-agreed edit D: replaced `<YEAR>` with `2026` and `<COPYRIGHT HOLDER>` with `Aleksejs Tokarenko` | Empty placeholders needed owner-supplied values before publishing |
| `history/experiments/EXP-01-completion-card.md` | Edit E2: replaced the plan price after the provider name with `(plan price omitted for publication)`; provider and model names kept | Currency amount in the setup table |
| `history/experiments/EXP-01, EXP-02 summary and rounds, EXP-03 cards` | Edit E3: title removed from the `Project:` header line in eight cards, replaced with `Godot agent …` | The working title of a private game project |
| `history/experiments/EXP-01-completion-card.md` | Edit E4.1: removed | Renderer-row clause rested on a private game idea |
| `history/experiments/EXP-01-completion-card.md` | Edit E4.2: removed | Challenge-ledger row listed a private reasoning-partner workflow; the `UC-nn` identifier column is also removed |
| `history/experiments/EXP-01-completion-card.md` | Edit E4.3: removed | Bullet named a private editor by name |
| `history/experiments/EXP-01-completion-card.md` | Edit E4.4: removed | Gaps bullet named the private agent; Connections bullet referenced private project instructions |
| `history/experiments/EXP-01-completion-card.md` | Edit E4.5: no sentence in section 6 referred to the project prompt, so no removal was needed | Condition not triggered |
| `history/discovery-log.md` | Edit E5: removed | Synthesis paragraph rested on private working-method vocabulary |
| `history/experiments/reference-runs/` | Edit E7: created; paths in the copied notes replaced with `<sandbox>/` and `<original-project>` | Local paths and the original project's directory name replaced in saved outputs |
| `history/README.md` | Edit E7b: replaced the edit-B row's quoted local path with `the local project path in the setup table, section 1` (summary row for the original-project directory-name sweep → `<original-project>`) | Local paths and directory name removed from the record table itself |
