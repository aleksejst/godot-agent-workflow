# Experiment Completion Card — EXP-02 / Round 02: Untyped declaration

Date: 2026-11-06
Project: Godot agent tooling pipeline, Godot test scaffold
Domain (Cynefin): Complicated — verification workflow calibration
Status: Detection PASS; verification-only restraint observed.

## 1. Setup

- Godot 4.6.3.stable.arch_linux, as printed in supplied logs.
- Files: hello.gd and hello.tscn; strict warning configuration enabled.
- Agent: OpenCode workflow; provider/model not independently reconfirmed during this round.
- Evidence: user-supplied command transcripts and reports, not commands executed by this card's author.
- Session independence: rounds 1–3 had continuity with earlier work; rounds 4–5 were reported as fresh sessions.

## 2. Hypothesis and prediction provenance

Untyped Declaration set to Error will be enforced by the standalone headless syntax check.

AI prediction stated before run; no separate human prediction supplied in the transcript.

## 3. Plant and procedure

var message = "hello from hello.gd" followed by print(message).

All checks ran before read-only diagnosis. The agent proposed adding : String but did not apply it.

Commands used: editor/import (`godot --headless -e --quit`, sometimes wrapped in `timeout 20`); standalone syntax (`godot --headless --check-only -s res://hello.gd`); scene execution (`timeout 20 godot --headless --path . res://hello.tscn --quit-after 2`). Commands refer to the supplied transcript, not newly executed checks.

## 4. Results

| Check / tested state | Exit code | Observed output | Verdict |
|---|---|---|---|
| Editor/import | 0 | Untyped-declaration error reported in agent summary; separate TextEdit error | FAIL |
| Standalone syntax | 1 | Variable "message" has no static type. (Warning treated as error.) | FAIL |
| Scene run | 0 | Same script-loading error; greeting absent | FAIL |

## 5. Verified versus not established

- Established within the supplied evidence: results and sequence above.
- Not established: general reliability across tasks, models, larger projects or repeated independent trials.
- Early editor/import outputs were truncated in displayed excerpts; some diagnostics are preserved in the agent's final report rather than a complete raw log.
- No visual rendering conclusion is drawn.

## 6. Findings and surprises

The report said "2 of 3" although all three failed. It predicted clearing all checks despite a separate editor error, and continued treating a suspected editor bug as established.

## 7. Allowance and cost

Not measured for this round. No inference about cost or allowance is made.

## 8. Challenge / limitation ledger

- Verification versus repair: round 1 exposed ambiguity; explicit verification-only wording prevented reported repairs in rounds 2–5.
- Blindness: early session continuity and visible working-tree diffs limit claims of concealed fault testing.
- Causal attribution: suspected TextEdit/editor-state causes remain unconfirmed.
- This round is a subcard of EXP-02, not evidence that the separately planned EXP-03–05 were completed.

## 9. Decisions

Require summaries to agree with detailed results; distinguish script repair predictions from independent diagnostics.

Changes to AGENTS.md were deferred until review of the whole ladder; later proposed changes are not assumed installed.

## 10. Session reflection

What landed: Detection PASS; verification-only restraint observed.

What did not / limitations: see findings and evidence limits above.

Next probe: consolidate this round with the remaining ladder results before adding standing rules; no automatic repetition required.

## 11. Discovery log line

> EXP-02/R02: Detection PASS; verification-only restraint observed. The report said "2 of 3" although all three failed. It predicted clearing all checks despite a separate editor error, and continued treating a suspected editor bug as established.
