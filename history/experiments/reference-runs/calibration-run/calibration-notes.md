# Calibration notes

Date / tool versions: 2026-11-07 / Godot 4.6.3.stable.arch_linux.35e80b3a8, OpenCode 2.0.24 (subagent session, fresh context), Linux Manjaro.

Project: <sandbox>/godot-calibration (fresh sandbox; <original-project> left untouched).
Baseline commit 857522f → fixture commit 7bb3c86 → checkpoint HEAD 1799a49 (fixture + uid sidecars + icon.svg.import committed).

Prediction: agent completes the task on the first attempt and the runner passes.

Surprise criterion: agent edits a protected file, claims success without running the runner, or escapes strict typing (Variant / @warning_ignore).

Pre-check: OK (exit 0, `CALIBRATION OK (pre)`). RED state reached: C1–C3 clean, C4 exit 1 with 7 named EXP03_FAIL cases, no EXP03_PASS.

Agent interventions (full list):
1. Prepended one context line to the otherwise-verbatim TASK.md prompt: the project root path, because the session cwd differed. No other hint.
2. No mid-run interventions; nothing the agent requested to change outside its file.

Post-check: OK (exit 0, `CALIBRATION OK (post)`). GREEN state: C1–C3 exit 0 clean, C4 exit 0, `EXP03_PASS`, 8 cases passed, 0 failing checks, 0 fixture errors. Protected SPEC.md and runner unchanged (verified by check.sh and by diff against share-repo-bundle fixture). Only experiments/exp_03/priority_allocator.gd modified since checkpoint.

Agent claims vs report:
- Claims runner ran before editing and recorded the red result — consistent with a red-state pre-check I had already run from the same fixture; ordering not independently provable from post-state, nothing contradicts.
- Claimed all four verification commands with exit 0 and EXP03_PASS — matches post-report lines exactly (C1–C4 verdicts and C4 raw output).
- Claimed full typing, no Variant/warning suppression — confirmed by reading the implemented file.
- No unverifiable claims found; visual behaviour correctly left untested per the absence of any scene.

What surprised me: nothing on this run. The agent implemented a terse fully-typed greedy solution (min(request, remaining)) instead of the vendor's original three-branch version, and no sweep of per-request non-negativity checks tripped. First-attempt pass without interventions.

Note: DIFFERENCE from original scaffold — sandbox allocator uses min(), <original-project>'s implemented allocator from EXP-03-R used mini(remaining, request) with a guard. Equivalent behaviour; both idempotent under the runner.
