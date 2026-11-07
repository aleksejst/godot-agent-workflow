# Reference runs

These are saved outputs from running the calibration task and the check scripts on one Linux machine with Godot 4.6.3 and OpenCode 2.0.24. They show what a passing run looks like and are evidence for the README's status table. They are examples, not a standard to match exactly: your versions, paths and warning settings will differ.

- `calibration-run/`: the notes and the pre/post reports from one full calibration, run in a fresh sandbox project.
- `dry-run/`: reports kept from a check of the repository itself, under the default warning profile and under a strict profile, including deliberate negative controls (a tampered runner and a restored stub), which are expected to show failures.

## Known limits of these runs

- The calibration run was set up and orchestrated by an agent, not by a human operator. The prediction and surprise criterion in its notes were written by that agent, so they are not pre-run predictions by an operator.
- The script cannot check whether the agent ran the test runner before editing; the notes say this could not be reconstructed.
- One sentence in the notes describes the original allocator as a "vendor's" three-branch version. That is inaccurate: the earlier implementation was the author's own, written in an earlier experiment.
- The implementation in the calibration run used `min()`, which returns `Variant` according to the Godot documentation, and still passed. See `docs/tests-pattern.md`.
- Paths were replaced with placeholders where noted in `history/README.md`.
