# Experiment Completion Card — EXP-02: Strict-only ladder of faults

Date run: 2026-11-06
Card prepared: 2026-11-07
Project: Godot agent tooling pipeline
Status: Core detector ladder complete. All five faults detected; qualifications below.

## 1. Setup

Godot 4.6.3 on the existing hello scaffold. Strict warning configuration was chosen as the operating default, not compared with a non-strict baseline. Results come from user-supplied agent transcripts. Five companion subcards preserve per-round results.

## 2. Hypothesis

The verification workflow can discriminate static rejection, runtime failure and output-specification failure without relying on exit code alone.

AI predictions were written before rounds 2–5. Separate human predictions are not present in the supplied record. Round 1's hypothesis is reconstructed. This is a process limitation, not something to fill in retrospectively.

## 3. Results

| Round | Plant | Key observation |
|---|---|---|
| 1 | Missing colon | Editor/import detected it, exit 0; agent repaired before other checks |
| 2 | Untyped variable | Standalone syntax rejected it, exit 1; import and scene failures exited 0 |
| 3 | Unsafe method call | Standalone syntax rejected it, exit 1; import and scene failures exited 0 |
| 4 | Missing Dictionary key | Static checks passed; runtime error and missing greeting, exit 0 |
| 5 | Wrong greeting | Clean execution, exit 0; rejected for incorrect output |

## 4. Conclusions and limits

- The standalone syntax command enforced the tested untyped-declaration and unsafe-method restrictions.
- Runtime execution added evidence not supplied by static checks in round 4.
- Explicit expected output enabled rejection of clean but incorrect behavior in round 5.
- Explicit verification-only wording was followed in rounds 2–5. The broad prompt in round 1 was followed by an unsolicited repair.
- Detailed detection was stronger than summary consistency: rounds 2–3 miscounted failures; round 3 contradicted its import verdict.
- No claim that all strict settings were tested, that AGENTS.md alone caused success, or that the workflow is generally reliable.
- No non-strict baseline, randomized prompt comparison or repeated independent trials. Rounds 1–3 had session continuity; rounds 4–5 were fresh sessions.

## 5. Separate TextEdit observation — unresolved

Earlier import runs emitted get_line_wrap_count errors at text_edit.cpp:6380. Reported values included (-2, size 5) and (-1, size 6). The diagnostic was absent in round 3 and subsequent supplied ladder runs. GUI saving was observed to add an empty-looking final row. These observations do not establish a causal link, a confirmed engine defect, an open-editor conflict or a remedy. Do not whitelist the diagnostic on this evidence.

## 6. Decisions / policy candidates

- Define verification-only as inspect/run/report, without repair authority.
- Judge checks separately; preserve initial and post-repair results.
- Require summaries to agree with detailed verdicts.
- Separate facts, hypotheses and untested repair predictions.
- Preserve pre-existing changes and prefer targeted repairs.
- Keep task-specific acceptance criteria outside reusable verification rules.
- Retain suppression policy as experimental: behavior under implementation pressure was not tested.

## 7. Not completed

Warn-level Unsafe Cast visibility probe, node-access implementation task, Variant-pressure implementation task and iteration-cost measurement were not run in this ladder. The prior EXP-01 card's separately planned EXP-03–05 must not be marked complete on this evidence. No new cost/allowance readings or visual checks were supplied.

## 8. Reflection

What landed: different verification layers caught different failure classes; explicit task scope restrained repair.
What did not: report aggregation and causal humility were less reliable than diagnostic detection.
Connection: success needs a task-level behavioral specification, not just tool completion.
Next probe: use the revised workflow in actual development before expanding the tooling experiment suite.

## 9. Discovery log line

> EXP-02 complete: five planted fault classes detected. Exit 0 accompanied both script-loading and runtime failures; wrong output required an explicit specification. Verification-only wording restrained repair, but summaries and causal claims remained weaker than detailed diagnostic reading. TextEdit issue unresolved.
