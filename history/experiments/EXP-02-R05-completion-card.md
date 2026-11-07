# Experiment Completion Card — EXP-02 / Round 05: Wrong output without execution error

Date: 2026-11-06
Project: Godot agent tooling pipeline, Godot test scaffold
Domain (Cynefin): Complicated — verification workflow calibration
Status: Specification-mismatch detection PASS; not an isolated test of log-only detection because source was inspected first.

## 1. Setup

- Godot 4.6.3.stable.arch_linux, as printed in supplied logs.
- Files: hello.gd and hello.tscn; strict warning configuration enabled.
- Agent: OpenCode workflow; provider/model not independently reconfirmed during this round.
- Evidence: user-supplied command transcripts and reports, not commands executed by this card's author.
- Session independence: rounds 1–3 had continuity with earlier work; rounds 4–5 were reported as fresh sessions.

## 2. Hypothesis and prediction provenance

Checks will execute cleanly, but the agent will reject the scene output against the supplied expectation.

AI prediction stated before run; no separate human prediction supplied in the transcript.

## 3. Plant and procedure

print("goodbye from hello.gd") instead of the explicitly expected hello greeting.

Fresh agent session. Agent inspected the script and diff before scene execution, then confirmed the wrong output at runtime. No changes applied.

Commands used: editor/import (`godot --headless -e --quit`, sometimes wrapped in `timeout 20`); standalone syntax (`godot --headless --check-only -s res://hello.gd`); scene execution (`timeout 20 godot --headless --path . res://hello.tscn --quit-after 2`). Commands refer to the supplied transcript, not newly executed checks.

## 4. Results

| Check / tested state | Exit code | Observed output | Verdict |
|---|---|---|---|
| Editor/import | 0 | No reported errors | PASS |
| Standalone syntax | 0 | Banner only | PASS |
| Scene run | 0 | goodbye from hello.gd; expected hello greeting absent | FAIL |

## 5. Verified versus not established

- Established within the supplied evidence: results and sequence above.
- Not established: general reliability across tasks, models, larger projects or repeated independent trials.
- Early editor/import outputs were truncated in displayed excerpts; some diagnostics are preserved in the agent's final report rather than a complete raw log.
- No visual rendering conclusion is drawn.

## 6. Findings and surprises

The agent proposed whole-file git restore for a one-word change. Its intent caveat could blur whether the current specification still failed. It did not execute the restore.

## 7. Allowance and cost

Not measured for this round. No inference about cost or allowance is made.

## 8. Challenge / limitation ledger

- Verification versus repair: round 1 exposed ambiguity; explicit verification-only wording prevented reported repairs in rounds 2–5.
- Blindness: early session continuity and visible working-tree diffs limit claims of concealed fault testing.
- Causal attribution: suspected TextEdit/editor-state causes remain unconfirmed.
- This round is a subcard of EXP-02, not evidence that the separately planned EXP-03–05 were completed.

## 9. Decisions

Prefer targeted repair proposals; intentional behavior changes require a specification decision, not automatic reclassification as passing.

Changes to AGENTS.md were deferred until review of the whole ladder; later proposed changes are not assumed installed.

## 10. Session reflection

What landed: Specification-mismatch detection PASS; not an isolated test of log-only detection because source was inspected first.

What did not / limitations: see findings and evidence limits above.

Next probe: consolidate this round with the remaining ladder results before adding standing rules; no automatic repetition required.

## 11. Discovery log line

> EXP-02/R05: Specification-mismatch detection PASS; not an isolated test of log-only detection because source was inspected first. The agent proposed whole-file git restore for a one-word change. Its intent caveat could blur whether the current specification still failed. It did not execute the restore.
