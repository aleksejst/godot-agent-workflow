# Discovery Log — Tooling and Agent Workflow

Created: 2026-11-07
Scope: Initial Godot scaffold, EXP-02 fault ladder and subsequent instruction/documentation design.

## Purpose

Capture what surprised us, what challenged an assumption, and what useful question follows. This is not a list of settled facts or a second decision log. Discoveries can remain unresolved; interpretations can be revised.

## Provenance and boundaries

Initial entries are reconstructed from the supplied EXP-01 completion card and conversation dated 2026-11-05 to 2026-11-07. They were not all written contemporaneously. Dates identify the underlying observation/discussion; every initial entry was logged on 2026-11-07. No new command execution, repository inspection or outside research was performed to establish these entries.

Evidence consists of user-supplied transcripts and reports. Some command excerpts were truncated. Record direct observations separately from interpretations, and do not treat an agent's diagnosis as a verified root cause.

Cross-references D-XXX use the companion decision log. EXP-02 R01–R05 identify subrounds, not five distinct experiments. At initial reconstruction the separately planned experiments were not complete. Update: revised EXP-03 is now complete; this does not mark EXP-04 or EXP-05 complete.

## How to maintain this log

- Add an entry when something changes a working assumption, exposes a boundary or suggests a materially different probe.
- Use stable DISC-XXX IDs. Keep old observations; append dated updates rather than silently replacing interpretations.
- Include disconfirming observations and errors in our own advice, not only agent failures.
- A next probe is a candidate, not automatic work. Run it when the answer can change a practical choice.
- Promote a discovery into the decision log only when an actual decision is made. Update AGENTS.md only when a standing instruction is warranted.
- Do not add routine passes merely to show activity. Preserve surprising failures and useful absence of expected behavior.

## Index

| ID | Observation date | Discovery |
|---|---|---|
| DISC-001 | 2026-11-04 | Generated instructions can sound authoritative while misdescribing the project |
| DISC-002 | 2026-11-04 | A clipboard failure was in the transfer path, not necessarily the clipboard |
| DISC-003 | 2026-11-04 | A missing file in an agent report may not have existed yet |
| DISC-004 | 2026-11-04 | An allowance meter can produce no useful signal at small scale |
| DISC-005 | 2026-11-05 | A baseline can answer a question nobody needs to decide |
| DISC-006 | 2026-11-06 | A failing editor/import run can return zero |
| DISC-007 | 2026-11-06 | Helpful repair can destroy the observation a verification task needed |
| DISC-008 | 2026-11-06 | A rule can shape visible reporting without proving causation |
| DISC-009 | 2026-11-06 | Precise local diagnosis does not guarantee a coherent summary |
| DISC-010 | 2026-11-06 | Typed code can still violate the selected safety boundary |
| DISC-011 | 2026-11-06 | The experiment was less blind than intended |
| DISC-012 | 2026-11-06 | Clean parsing did not establish successful execution |
| DISC-013 | 2026-11-06 | Clean execution did not establish correct behavior |
| DISC-014 | 2026-11-06 | The editor diagnostic was reproducible, then absent without an established cure |
| DISC-015 | 2026-11-06 | Changing text counts provided a clue, not a cause |
| DISC-016 | 2026-11-06 | A convenient repair command can exceed the intended repair scope |
| DISC-017 | 2026-11-07 | The fixture started leaking into standing policy |
| DISC-018 | 2026-11-07 | Chosen conventions are neither engine requirements nor merely local facts |
| DISC-019 | 2026-11-07 | The detector ladder did not test implementation under constraint |
| DISC-020 | 2026-11-07 | Different records answer different questions |

| DISC-021 | 2026-11-07 | A test fixture can introduce the complexity we meant to avoid |
| DISC-022 | 2026-11-07 | Red-to-green evidence survived the implementation boundary |
| DISC-023 | 2026-11-07 | Preserved acceptance artifacts made the result easier to trust |
| DISC-024 | 2026-11-07 | Command execution can be right while the explanation of Git is wrong |
| DISC-025 | 2026-11-07 | Historical verification notes can become stale after one experiment |
| DISC-026 | 2026-11-07 | A frozen file cannot straightforwardly record its own final commit after the fact |
| DISC-027 | 2026-11-07 | Setup friction and implementation friction were different |

## DISC-001 — Generated instructions can sound authoritative while misdescribing the project

- Observation/discussion date: 2026-11-04
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: EXP-01 recorded incorrect generated claims about non-default settings and an overbroad verification statement.
- Why it mattered / working interpretation: Instruction generation is itself an output requiring review, not a trustworthy inventory.
- Confidence and limits: Observed in the supplied EXP-01 card; underlying commands were not rerun here.
- Connections: D-002; EXP-01
- Suggested next probe or practice: Watch for instructions becoming stale as the real repository evolves.
- Updates: None recorded yet.

## DISC-002 — A clipboard failure was in the transfer path, not necessarily the clipboard

- Observation/discussion date: 2026-11-04
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: EXP-01 recorded line breaks being lost when pasting into nano although clipboard inspection retained them. A direct clipboard-to-file workaround was recorded.
- Why it mattered / working interpretation: Separate data integrity from the interface used to transfer it.
- Confidence and limits: Historical observation from EXP-01; no claim that all editors or future sessions exhibit it.
- Connections: EXP-01
- Suggested next probe or practice: Prefer delivered files or inspect the resulting diff when replacing documentation.
- Updates: None recorded yet.

## DISC-003 — A missing file in an agent report may not have existed yet

- Observation/discussion date: 2026-11-04
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: EXP-01 recorded that the script UID appeared after the human editor run, later than the agent task. Earlier criticism of the report was withdrawn.
- Why it mattered / working interpretation: Evaluate reports against the state available at the time, not later repository state.
- Confidence and limits: Temporal sequence recorded in EXP-01.
- Connections: EXP-01
- Suggested next probe or practice: Preserve timing when judging omissions or assigning responsibility.
- Updates: None recorded yet.

## DISC-004 — An allowance meter can produce no useful signal at small scale

- Observation/discussion date: 2026-11-04
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: EXP-01 recorded displayed usage remaining at zero during a small task.
- Why it mattered / working interpretation: Resolution or delayed reporting can hide activity; zero display is not proof of zero usage.
- Confidence and limits: Meter interpretation remained an inference; no new cost data in the ladder.
- Connections: EXP-01
- Suggested next probe or practice: Do not add a cost experiment unless its result would change a practical choice.
- Updates: None recorded yet.

## DISC-005 — A baseline can answer a question nobody needs to decide

- Observation/discussion date: 2026-11-05
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: The proposed strict-versus-default comparison was dropped after the user challenged its necessity.
- Why it mattered / working interpretation: Methodological completeness is not automatically decision value. Validate the chosen path when comparison would not change action.
- Confidence and limits: A reasoning correction, not an experimental result proving strict superiority.
- Connections: D-004–D-005
- Suggested next probe or practice: Before adding a comparison, state which decision its outcome could change.
- Updates: None recorded yet.

## DISC-006 — A failing editor/import run can return zero

- Observation/discussion date: 2026-11-06
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: Round 1 exposed the missing colon with script-loading errors while the command returned 0. Similar status/output divergence appeared later.
- Why it mattered / working interpretation: Process status and task success must be evaluated separately.
- Confidence and limits: Observed in supplied transcripts; not a universal claim about every Godot failure.
- Connections: EXP-02 R01–R04; D-006
- Suggested next probe or practice: Keep command status and relevant output in reports.
- Updates: None recorded yet.

## DISC-007 — Helpful repair can destroy the observation a verification task needed

- Observation/discussion date: 2026-11-06
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: Round 1 agent diagnosed the missing colon, repaired it, then ran the remaining checks on the repaired script.
- Why it mattered / working interpretation: Verification authority and implementation authority are distinct. Helpfulness can conflict with preserving the test subject.
- Confidence and limits: Original wording was ambiguous; protocol responsibility is shared. Later explicit wording was followed in the supplied runs.
- Connections: EXP-02 R01; D-008
- Suggested next probe or practice: For verification-only tasks, preserve state and propose repairs separately.
- Updates: None recorded yet.

## DISC-008 — A rule can shape visible reporting without proving causation

- Observation/discussion date: 2026-11-06
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: Agents repeatedly cited the log-based success rule and rejected failures despite exit 0.
- Why it mattered / working interpretation: Instructions were compatible with the observed behavior, but this was not a controlled test of AGENTS.md effectiveness.
- Confidence and limits: Prompt wording, session context and agent capability also contributed; no no-rule control.
- Connections: EXP-02; D-006
- Suggested next probe or practice: Use practical success without overstating what caused it.
- Updates: None recorded yet.

## DISC-009 — Precise local diagnosis does not guarantee a coherent summary

- Observation/discussion date: 2026-11-06
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: Rounds 2–3 listed three failed checks but said two failed. Round 3 later called import passing because a separate error disappeared.
- Why it mattered / working interpretation: Evidence extraction and evidence aggregation are different reliability surfaces.
- Confidence and limits: Repeated within two related-session runs, not a measured general failure rate.
- Connections: EXP-02 R02–R03; D-012
- Suggested next probe or practice: Check summary against per-check verdicts; observe whether the revised policy helps in real tasks.
- Updates: None recorded yet.

## DISC-010 — Typed code can still violate the selected safety boundary

- Observation/discussion date: 2026-11-06
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: Round 3 used a variable declared as Node, yet the unsupported method call was rejected as a warning treated as error.
- Why it mattered / working interpretation: Declaring types and restricting unsupported operations are distinct protections.
- Confidence and limits: Standalone headless enforcement observed for this particular plant and warning configuration.
- Connections: EXP-02 R03; D-003
- Suggested next probe or practice: Carry the distinction into implementation review rather than equating typed with correct.
- Updates: None recorded yet.

## DISC-011 — The experiment was less blind than intended

- Observation/discussion date: 2026-11-06
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: Early sessions referenced earlier work, and the agent inferred intentional plants. Visible working-tree diffs exposed changes.
- Why it mattered / working interpretation: Session state and repository evidence are part of the experimental environment.
- Confidence and limits: Rounds 4–5 were reported as fresh sessions; earlier command outputs remain useful despite limited blindness.
- Connections: EXP-02 R01–R05; D-009–D-010
- Suggested next probe or practice: Record continuity; pursue stronger blinding only if it informs a decision.
- Updates: None recorded yet.

## DISC-012 — Clean parsing did not establish successful execution

- Observation/discussion date: 2026-11-06
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: Round 4 passed editor/import and syntax checks, then failed on a missing Dictionary key at runtime, with exit 0.
- Why it mattered / working interpretation: Verification layers contribute different evidence rather than duplicating one success signal.
- Confidence and limits: Observed for a startup code path; no claim of complete runtime coverage.
- Connections: EXP-02 R04; D-006
- Suggested next probe or practice: Choose runtime checks that actually exercise the behavior under development.
- Updates: None recorded yet.

## DISC-013 — Clean execution did not establish correct behavior

- Observation/discussion date: 2026-11-06
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: Round 5 printed goodbye instead of the explicitly expected hello, without reported execution errors. Agent rejected the result.
- Why it mattered / working interpretation: Correctness depends on an independent specification, not merely what the implementation currently does.
- Confidence and limits: Agent read the source before confirming output; this was not output-only detection.
- Connections: EXP-02 R05; D-016
- Suggested next probe or practice: Establish task acceptance criteria before judging results.
- Updates: None recorded yet.

## DISC-014 — The editor diagnostic was reproducible, then absent without an established cure

- Observation/discussion date: 2026-11-06
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: Early editor/import runs repeatedly emitted a negative line-index get_line_wrap_count error; later round 3–5 transcripts did not show it.
- Why it mattered / working interpretation: Recurrence supported investigating editor machinery but did not establish saved state, concurrent editors or a permanent engine defect as the cause.
- Confidence and limits: No confirmed root cause or tested remedy. Earlier confidence about diagnosis and persistence was unwarranted.
- Connections: EXP-02; D-013–D-014
- Suggested next probe or practice: Investigate only if it recurs and blocks useful work; preserve raw output and editor-state details.
- Updates: None recorded yet.

## DISC-015 — Changing text counts provided a clue, not a cause

- Observation/discussion date: 2026-11-06
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: Reported TextEdit pairs changed from index -2 / size 5 to index -1 / size 6. User also observed an empty-looking final row after GUI saving.
- Why it mattered / working interpretation: A possible relationship to the displayed document deserves recording without collapsing correlation into mechanism.
- Confidence and limits: The log does not identify the text component or establish whether one final newline versus an additional blank line was present.
- Connections: D-014; GUI-save discussion
- Suggested next probe or practice: If investigating again, inspect actual bytes and state transitions rather than relying only on visible line counts.
- Updates: None recorded yet.

## DISC-016 — A convenient repair command can exceed the intended repair scope

- Observation/discussion date: 2026-11-06
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: Round 5 proposed whole-file restore for a one-word mismatch. The agent did not apply it.
- Why it mattered / working interpretation: A correct result can still be reached through an unnecessarily broad proposed operation.
- Confidence and limits: Displayed diff contained only the intended change; no work was lost. User later explicitly requested restoration.
- Connections: EXP-02 R05; D-015
- Suggested next probe or practice: Prefer targeted edits unless broader restoration is deliberately authorized.
- Updates: None recorded yet.

## DISC-017 — The fixture started leaking into standing policy

- Observation/discussion date: 2026-11-07
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: The proposed AGENTS.md included the hello greeting as a standing expectation. User challenged the generality.
- Why it mattered / working interpretation: The experiment fixture should supply evidence for reusable rules, not silently become a rule for every future task.
- Confidence and limits: Design correction, not a measured runtime finding.
- Connections: D-016
- Suggested next probe or practice: Keep acceptance criteria with tasks/tests and project entry points in local procedures.
- Updates: None recorded yet.

## DISC-018 — Chosen conventions are neither engine requirements nor merely local facts

- Observation/discussion date: 2026-11-07
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: User proposed four layers: general, Godot-specific, chosen Godot direction and this project.
- Why it mattered / working interpretation: Separating choice from necessity makes reuse and future revision more honest. Specificity also need not grant override authority.
- Confidence and limits: Four-layer file generated; installation and effect have not been confirmed.
- Connections: D-017–D-018
- Suggested next probe or practice: Use in development before adding a multi-file policy distribution system.
- Updates: None recorded yet.

## DISC-019 — The detector ladder did not test implementation under constraint

- Observation/discussion date: 2026-11-07
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: No supplied round required the agent to implement a feature while confronting dynamic data or node typing.
- Why it mattered / working interpretation: Detection success cannot validate the no-suppression convention or establish iteration cost.
- Confidence and limits: Warn visibility, Variant pressure, node-access implementation and cost comparisons remain untested.
- Connections: D-019; D-022
- Suggested next probe or practice: Keep the suppression convention experimental; observe actual development friction before expanding tests.
- Updates: None recorded yet.

## DISC-020 — Different records answer different questions

- Observation/discussion date: 2026-11-07
- Logged: 2026-11-07 (retrospective reconstruction)
- What happened: Conversation separated operating instructions, experiment cards, decision rationale and discoveries into distinct artifacts.
- Why it mattered / working interpretation: Preserving surprises separately prevents a final policy from erasing the path that produced it.
- Confidence and limits: Documentation structure adopted; sustained maintenance remains untested.
- Connections: D-021; D-023
- Suggested next probe or practice: Update this log for material surprises, not every successful routine check.
- Updates: None recorded yet.


## DISC-021 — A test fixture can introduce the complexity we meant to avoid

- Observation/discussion date: 2026-11-07
- Logged: 2026-11-07, post-EXP-03
- What happened: The first allocator runner used Callable.callv() despite a fixed typed interface. It also compared bounds with the argument that an incorrect implementation might mutate.
- Why it mattered / working interpretation: Review the measuring apparatus, not just its results. The fixed typed interface and independent snapshot simplified the fixture.
- Confidence and limits: Corrected source reviewed; no claim that dynamic calls are universally wrong.
- Connections: D-024–D-025
- Suggested next probe or practice: Carry this distinction into actual development; no automatic additional tooling experiment.
- Updates: None recorded yet.

## DISC-022 — Red-to-green evidence survived the implementation boundary

- Observation/discussion date: 2026-11-07
- Logged: 2026-11-07, post-EXP-03
- What happened: A fresh session reported one passing and seven failing cases before implementation, then eight passing cases and EXP03_PASS after implementation.
- Why it mattered / working interpretation: This extends evidence from detection to bounded feature implementation with protected tests.
- Confidence and limits: Supplied reports plus reviewed source; no independent rerun or controlled policy attribution.
- Connections: D-024; D-028
- Suggested next probe or practice: Carry this distinction into actual development; no automatic additional tooling experiment.
- Updates: None recorded yet.

## DISC-023 — Preserved acceptance artifacts made the result easier to trust

- Observation/discussion date: 2026-11-07
- Logged: 2026-11-07, post-EXP-03
- What happened: Checkpoint comparison reported only the allocator changed; attached final source matched the contract and runner remained unchanged in supplied artifacts.
- Why it mattered / working interpretation: Explicit edit boundaries and a recorded checkpoint provided inspectable evidence, not merely reassurance.
- Confidence and limits: Full raw diff excerpt was truncated; source and reported status/diff were reviewed.
- Connections: D-026; EXP-03
- Suggested next probe or practice: Carry this distinction into actual development; no automatic additional tooling experiment.
- Updates: None recorded yet.

## DISC-024 — Command execution can be right while the explanation of Git is wrong

- Observation/discussion date: 2026-11-07
- Logged: 2026-11-07, post-EXP-03
- What happened: Agent described full-tree diff as including untracked files. Separate status output showed only the modified implementation.
- Why it mattered / working interpretation: Distinguish an operation and its output from the agent explanation of its coverage.
- Confidence and limits: This was an explanation error, not evidence of lost work or a failed edit boundary.
- Connections: D-013; EXP-03
- Suggested next probe or practice: Carry this distinction into actual development; no automatic additional tooling experiment.
- Updates: None recorded yet.

## DISC-025 — Historical verification notes can become stale after one experiment

- Observation/discussion date: 2026-11-07
- Logged: 2026-11-07, post-EXP-03
- What happened: The current AGENTS.md still called the timeout wrapper unexercised after EXP-03 had reported successful syntax runs using it.
- Why it mattered / working interpretation: Local procedural facts need updating without turning historical success into permanent current status.
- Confidence and limits: New document generated; repository replacement not confirmed.
- Connections: D-020; D-027
- Suggested next probe or practice: Carry this distinction into actual development; no automatic additional tooling experiment.
- Updates: None recorded yet.

## DISC-026 — A frozen file cannot straightforwardly record its own final commit after the fact

- Observation/discussion date: 2026-11-07
- Logged: 2026-11-07, post-EXP-03
- What happened: SPEC initially asked for its freeze commit to be inserted after the commit. The record was moved outside the protected artifact.
- Why it mattered / working interpretation: Keep checkpoint metadata external when writing it would change the frozen artifact.
- Confidence and limits: Fixture checkpoint supplied: 2c81eecff24ab1a404929b9dd8154df64eb27e7f. Final implementation commit unknown.
- Connections: D-024
- Suggested next probe or practice: Carry this distinction into actual development; no automatic additional tooling experiment.
- Updates: None recorded yet.

## DISC-027 — Setup friction and implementation friction were different

- Observation/discussion date: 2026-11-07
- Logged: 2026-11-07, post-EXP-03
- What happened: Fixture setup required corrections and an interim parse repair; no human intervention was reported during the final implementation phase.
- Why it mattered / working interpretation: Do not flatten the experiment into either frictionless success or general tool difficulty.
- Confidence and limits: Exact internal iteration count, elapsed effort and costs were not measured.
- Connections: D-024; D-028
- Suggested next probe or practice: Carry this distinction into actual development; no automatic additional tooling experiment.
- Updates: None recorded yet.


## Dated updates to earlier discoveries — after EXP-03

- DISC-008: The reported implementation outcome remains compatible with the policy, but no causal comparison was performed.
- DISC-009: EXP-03 implementation reporting was consistent; the checkpoint explanation still contained a separate Git-scope error. One clean report does not erase earlier contradictions.
- DISC-018: A four-layer AGENTS.md was uploaded and reviewed. This latest three-edit revision is generated, not observed installed.
- DISC-019: A bounded implementation task has now been completed. It did not exercise legitimate dynamic data or node typing under feature pressure; suppression rule remains experimental.
- DISC-020: Records are now being updated after a completed experiment, but sustained documentation-maintenance effectiveness is still untested.

## Current synthesis — provisional

The core detector workflow exposed all five plants, but detection was not the only reliability surface. Authority boundaries, report aggregation, causal confidence and repair scope needed separate attention. Practical workflow improvement came from human challenges as well as agent/tool output: the baseline question, session continuity, policy generalisation and four-layer separation all changed the approach.

## Unresolved tensions

1. Helpful initiative versus preservation: a repair can help development and invalidate a verification observation. Task authority must distinguish them.
2. Strong constraints versus legitimate dynamic behavior: restrictions may prevent evasion or encourage awkward workarounds. EXP-03 adds one simple implementation success; richer dynamic-data evidence is still missing.
3. More instructions versus policy burden: explicit rules addressed observed ambiguity, but longer instructions are not automatically more effective.
4. Rigorous experiments versus tooling displacement: better controls help attribution, but only matter when they inform a real decision.
5. Reusable conventions versus local truth: general policy must not pretend project facts are universal or current configuration is permanently known.

## Next-use guidance

The next valuable observation may arise during actual game work rather than another tooling experiment. Watch whether the revised policy produces accurate, bounded reports without avoidable friction. Log the first meaningful counterexample. Do not reopen every deferred probe simply because it is listed here.

## Entry template

### DISC-XXX — Short descriptive title

- Observation/discussion date: YYYY-MM-DD
- Logged: YYYY-MM-DD; contemporaneous or retrospective
- Context / experiment / task:
- What happened (observable evidence):
- What assumption it challenged:
- Working interpretation:
- Confidence and limits / alternative explanations:
- Connections to decisions, experiments or concepts:
- Suggested next probe or practice (optional):
- Updates: YYYY-MM-DD — supporting/disconfirming evidence and revised interpretation

## Session reflection — initial reconstruction

- What landed: layered verification, explicit acceptance criteria, clearer scope and reusable policy structure.
- What did not: early session independence, summary arithmetic, restraint in causal diagnosis and the original separation of verification from repair.
- Why: a small technical fixture exposed not just parser behavior but how task framing and reporting interact.
- Gap at initial reconstruction: revised instructions had not been evaluated in implementation. Update: EXP-03 now supplies a bounded implementation success, not substantive simulation evidence.
- Suggested next probe: observe the first genuine development task; keep its surprises, not merely its completion status.

## Change history

| Date | Change |
|---|---|
| 2026-11-07 | Initial retrospective reconstruction, DISC-001–DISC-020. No new experimental results added. |

| 2026-11-07, post-EXP-03 | Added DISC-021–DISC-027, dated updates and corrected current limitations. Original observations and IDs retained. |
