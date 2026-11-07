# Tooling and Agent Workflow — Decision Log

Created: 2026-11-07
Scope: Godot tooling scaffold, strict-only fault ladder, verification workflow and AGENTS.md evolution.

## Purpose and provenance

This is a living record of decisions and their motivations, not a command transcript or a claim that every proposed change has been installed. Reconstructed from the supplied EXP-01 completion card and the conversation dated 2026-11-05 through 2026-11-07. Dates use the displayed local conversation dates. The earlier EXP-01 date is taken from its card. No repository inspection or new Godot run was performed for this log.

The evidence distinguishes user choices, jointly accepted proposals, analytical recommendations, experimental observations and unresolved hypotheses. Where approval or execution is not shown, the entry says so. Do not convert an interpretation or a generated file into a claim of deployment.

## Relationship to other documentation

- AGENTS.md: current operating agreement, selected conventions and project procedures.
- Experiment completion cards: setup, actual observations, results and limitations.
- This log: why decisions were made, what was rejected, what changed, and when to revisit.
- Discovery log: surprises and next questions. A discovery may motivate a decision without itself being a decision.

## Maintenance convention

1. Give each consequential decision a permanent D-XXX ID. Do not reuse IDs.
2. Append new decisions. For changed decisions, retain the old rationale, mark its status, link the successor and add a dated amendment.
3. Separate acceptance from implementation: a generated document is not proof the repository was updated.
4. Link evidence to experiment/round IDs or repository documents as those acquire stable paths. Evidence labels here identify records, not fabricated paths.
5. Retain uncertainty. Record whether a prediction was pre-run or reconstructed.
6. Update the index and change history when substantive decisions change. Avoid logging every wording edit.

Status vocabulary: Adopted; Proposed; Experimental; Deferred; Superseded; Unresolved. Qualifiers explicitly state deployment/evidence limits.

## Decision index

| ID | Date | Status | Decision |
|---|---|---|---|
| D-001 | 2026-11-04 | Adopted | Use a small Godot scaffold to establish the agent/tooling pipeline |
| D-002 | 2026-11-04 | Adopted | Review generated agent instructions rather than trusting them |
| D-003 | 2026-11-05 | Adopted | Choose strict typing as the working default |
| D-004 | 2026-11-05 | Superseded | Run a strict-versus-default baseline comparison |
| D-005 | 2026-11-05 | Adopted | Run a strict-only validation ladder |
| D-006 | 2026-11-06 | Adopted | Judge verification from layered evidence, not exit status alone |
| D-007 | 2026-11-06 | Adopted | Use a fixed verification task, not an open-ended review |
| D-008 | 2026-11-06 | Adopted | Separate verification authority from repair authority |
| D-009 | 2026-11-06 | Adopted; early protocol not fully followed | Use fresh sessions for detector rounds |
| D-010 | 2026-11-06 | Proposed; not established as adopted | Commit plants on throwaway branches to reduce diff clues |
| D-011 | 2026-11-06 | Adopted | Defer standing-policy edits until the ladder review |
| D-012 | 2026-11-06 | Adopted | Make summaries agree with per-check evidence |
| D-013 | 2026-11-06 | Adopted | Distinguish observations, hypotheses and untested fixes |
| D-014 | 2026-11-06 | Unresolved; no exception adopted | Keep the TextEdit diagnostic separate and non-whitelisted |
| D-015 | 2026-11-06 to 2026-11-07 | Adopted | Preserve pre-existing work and prefer targeted repairs |
| D-016 | 2026-11-07 | Adopted | Keep fixture expectations out of reusable standing policy |
| D-017 | 2026-11-07 | Adopted; replacement file generated | Organise AGENTS.md into four layers in one file |
| D-018 | 2026-11-07 | Adopted | Specificity does not silently expand authority |
| D-019 | 2026-11-06 to 2026-11-07 | Experimental | Retain suppression and Variant-bypass restrictions as provisional |
| D-020 | 2026-11-07 | Adopted | Record command scope and historical verification honestly |
| D-021 | 2026-11-07 | Adopted | Separate experiment identity from round identity |
| D-022 | 2026-11-06 to 2026-11-07 | Core ladder complete; follow-ons deferred | Stop detector expansion after the five core rounds |
| D-023 | 2026-11-07 | Adopted; initial log generated | Maintain a living rationale log alongside experiment evidence |

| D-024 | 2026-11-07 | Adopted; EXP-03 complete | Use a reviewed red-to-green implementation experiment |
| D-025 | 2026-11-07 | Adopted for EXP-03 fixture | Preserve independent reference data and prefer the fixed typed interface |
| D-026 | 2026-11-07 | Adopted; policy file generated | Protect acceptance artifacts without making tests immutable |
| D-027 | 2026-11-07 | Adopted; policy file generated | Update command procedures with exercised runner support |
| D-028 | 2026-11-07 | Adopted | Close the required tooling gate after EXP-03 |
| D-029 | 2026-11-07 | Adopted as maintenance direction | Extract skills from recurring concrete procedures, not length alone |

## D-001 — Use a small Godot scaffold to establish the agent/tooling pipeline

- Date: 2026-11-04
- Status: Adopted
- Decision: Establish editing, parsing and headless execution on hello.gd/hello.tscn before adding simulation complexity.
- Motivation / evidence: A small fixture keeps failures attributable and makes command output easy to inspect. EXP-01 recorded an end-to-end working path.
- Alternative considered: Begin directly with game systems.
- Consequences and limits: Success on a trivial fixture does not establish simulation competence or visual correctness.
- Revisit trigger: Revisit when actual development exposes needs the scaffold cannot represent.
- Evidence record: EXP-01 completion card; scaffold work

## D-002 — Review generated agent instructions rather than trusting them

- Date: 2026-11-04
- Status: Adopted
- Decision: Replace generated AGENTS.md claims with a hand-reviewed working agreement. Use plan review before implementation when decisions are not yet settled.
- Motivation / evidence: EXP-01 recorded confidently incorrect generated project-setting claims and an overbroad verification claim.
- Alternative considered: Accept the generated file unchanged.
- Consequences and limits: Generated instructions are proposals, not authoritative descriptions of repository state.
- Revisit trigger: Review when tools regenerate instructions or project assumptions change.
- Evidence record: EXP-01 completion card

## D-003 — Choose strict typing as the working default

- Date: 2026-11-05
- Status: Adopted
- Decision: Use explicit GDScript typing; target Error for Untyped Declaration and unsafe property/method/call-argument access; Warn for Unsafe Cast.
- Motivation / evidence: Human prior Godot experience and the analytical preference for early precise diagnostics converged. Rounds 2–3 subsequently demonstrated two restrictions in the actual headless syntax check.
- Alternative considered: Continue with permissive defaults.
- Consequences and limits: Not all warning settings were independently tested. The thread does not prove strict mode is universally better or quantify productivity effects.
- Revisit trigger: Revisit repeated implementation friction, escape hatches or disproportionate iteration cost.
- Evidence record: Strictness discussion; EXP-02 R02–R03

## D-004 — Run a strict-versus-default baseline comparison

- Date: 2026-11-05
- Status: Superseded
- Decision: Initially proposed preserving baseline rounds and comparing both configurations. Replaced by D-005.
- Motivation / evidence: The initial rationale was attribution: identify the effect of strictness.
- Alternative considered: Adopt strict settings without comparative rounds.
- Consequences and limits: The comparison did not inform the decision the user actually faced.
- Revisit trigger: Retained to explain why comparative evidence was not collected.
- Evidence record: Baseline discussion

## D-005 — Run a strict-only validation ladder

- Date: 2026-11-05
- Status: Adopted
- Decision: Drop the non-strict baseline and test whether the chosen configuration and verification workflow work. Keep settings changes separately reviewable/reversible.
- Motivation / evidence: The user would choose strict settings regardless of comparison results; extra baseline runs would mainly satisfy curiosity.
- Alternative considered: D-004 baseline comparison.
- Consequences and limits: This sacrifices comparative claims. It is a pragmatic configuration validation, not a strict-versus-default performance study. Separate settings commit was recommended; commit completion is not established here.
- Revisit trigger: Add comparison only if it could change an actual decision.
- Evidence record: User baseline challenge and accepted revised approach

## D-006 — Judge verification from layered evidence, not exit status alone

- Date: 2026-11-06
- Status: Adopted
- Decision: Use editor/import, standalone syntax and scene execution checks for their distinct scopes. Inspect full output and require specified behavior as applicable.
- Motivation / evidence: Rounds 1–4 included logged failures with exit 0; round 4 passed static checks but failed at runtime; round 5 ran cleanly with wrong output.
- Alternative considered: Treat exit 0 or successful parsing as sufficient.
- Consequences and limits: No finite smoke check establishes all behavior. The current policy treats errors/timeouts as non-passing for normal checks.
- Revisit trigger: Revisit when a real test harness introduces intentional negative tests or richer machine-readable results.
- Evidence record: EXP-01; EXP-02 R01–R05

## D-007 — Use a fixed verification task, not an open-ended review

- Date: 2026-11-06
- Status: Adopted
- Decision: Keep the verification prompt stable across plants and explicitly supply the expected output.
- Motivation / evidence: A generic review invites broad interpretation and source-reading diagnosis rather than a consistent verification workflow.
- Alternative considered: Please review the project for gaps.
- Consequences and limits: Source inspection was not prohibited; round 5 found the mismatch in source before confirming it through execution. This was not a tools-only detector test.
- Revisit trigger: Change prompts only for a stated purpose; record the change.
- Evidence record: Verification prompt discussion; R05

## D-008 — Separate verification authority from repair authority

- Date: 2026-11-06
- Status: Adopted
- Decision: Verification-only means inspect/run/report; propose fixes but do not apply them. Run all safe applicable checks against the unchanged test subject.
- Motivation / evidence: Round 1 agent repaired the colon before subsequent checks. The explicit boundary was followed in rounds 2–5.
- Alternative considered: Allow helpful automatic repair during verification.
- Consequences and limits: The original broad prompt was ambiguous; the result does not establish malicious disregard or isolate AGENTS.md effects. Normal implementation tasks are not converted into permission-per-edit workflows.
- Revisit trigger: Revisit scope wording if real tasks show uncertainty or obstruction.
- Evidence record: R01; revised prompt; R02–R05

## D-009 — Use fresh sessions for detector rounds

- Date: 2026-11-06
- Status: Adopted; early protocol not fully followed
- Decision: Start a fresh agent session for each round and avoid revealing the plant or predictions.
- Motivation / evidence: Earlier session continuity let the agent reference prior work and infer that it was being tested. User acknowledged this and used fresh sessions for rounds 4–5.
- Alternative considered: Continue all rounds in one conversation.
- Consequences and limits: Do not retrospectively label rounds 1–3 independent or fully blind. Visible diffs also expose changes.
- Revisit trigger: Record session continuity in future cards; rerun only if independence matters to a decision.
- Evidence record: R03 review; user acknowledgement; R04–R05

## D-010 — Commit plants on throwaway branches to reduce diff clues

- Date: 2026-11-06
- Status: Proposed; not established as adopted
- Decision: A neutral commit/branch per plant was suggested as an optional blinding technique.
- Motivation / evidence: Uncommitted diffs make the deliberate change conspicuous.
- Alternative considered: Leave plants as working-tree changes.
- Consequences and limits: The supplied later runs show uncommitted hello.gd changes. Branch-based concealment was not demonstrated and does not guarantee blindness.
- Revisit trigger: Use only if stronger blinding is needed; do not add ceremony automatically.
- Evidence record: Prompt-protocol discussion; R02–R05 diffs

## D-011 — Defer standing-policy edits until the ladder review

- Date: 2026-11-06
- Status: Adopted
- Decision: Record candidate changes during rounds; revise AGENTS.md after observing the full core ladder. Allow necessary experimental-control changes to the prompt immediately.
- Motivation / evidence: Avoid encoding every isolated imperfection as a permanent rule. The user explicitly asked to park verify-versus-repair policy changes until review.
- Alternative considered: Edit AGENTS.md after every round.
- Consequences and limits: Prompt changed after round 1, so conditions were not identical throughout. This change is part of the record.
- Revisit trigger: Apply the same evidence threshold to future instruction growth.
- Evidence record: Post-R01/Rerun discussion; end-of-ladder revision

## D-012 — Make summaries agree with per-check evidence

- Date: 2026-11-06
- Status: Adopted
- Decision: Report each command, status and relevant output; keep different diagnostics and initial/post-repair states distinct.
- Motivation / evidence: Rounds 2–3 said 2 of 3 failed although three failures were listed. R03 also called import passing when only its separate TextEdit error disappeared.
- Alternative considered: Rely on a high-level success summary.
- Consequences and limits: Adding a rule is not evidence that future reports will obey it. No post-revision validation has been shown.
- Revisit trigger: Revisit if summary contradictions persist; consider structured reporting only if needed.
- Evidence record: R02–R03; proposed revised AGENTS.md

## D-013 — Distinguish observations, hypotheses and untested fixes

- Date: 2026-11-06
- Status: Adopted
- Decision: Do not call an error harmless or a known engine bug without evidence; qualify causal explanations and proposed remedies.
- Motivation / evidence: The agent repeatedly promoted a possible layout explanation into a diagnosis and predicted a remedy without testing it. The TextEdit diagnostic later disappeared without the proposed reset being reported.
- Alternative considered: Accept confident plausible explanations as facts.
- Consequences and limits: The source location suggests text-editing machinery, not a proven root cause.
- Revisit trigger: Update causal status only when a discriminating observation supports it.
- Evidence record: TextEdit discussion; R03–R05

## D-014 — Keep the TextEdit diagnostic separate and non-whitelisted

- Date: 2026-11-06
- Status: Unresolved; no exception adopted
- Decision: Record its occurrence without treating it as the planted fault or silently exempting it from check verdicts.
- Motivation / evidence: Recurring get_line_wrap_count errors appeared during earlier editor/import runs, changed reported line values, then were absent in later supplied runs.
- Alternative considered: Whitelist it; clear caches immediately; assume an open editor is the cause.
- Consequences and limits: Negative indices, changing text sizes and GUI final-newline observation are clues, not proof. No cache-reset remedy or causal isolation was demonstrated.
- Revisit trigger: Investigate if it recurs and blocks useful work.
- Evidence record: TextEdit reruns; R02–R05; GUI-save observation

## D-015 — Preserve pre-existing work and prefer targeted repairs

- Date: 2026-11-06 to 2026-11-07
- Status: Adopted
- Decision: Do not restore/revert/overwrite user changes without permission. Prefer a narrow proposed edit to whole-file restoration.
- Motivation / evidence: R05 proposed git restore for a one-word change. It was not executed. Later the user explicitly requested restoration to the committed fixture.
- Alternative considered: Use whole-file checkout/restore as a routine fix.
- Consequences and limits: Whole-file restoration is valid when deliberately authorized; the policy is about scope and ownership, not banning Git restore.
- Revisit trigger: Revisit only if a documented workflow grants specific broader authority.
- Evidence record: R05; user Git restoration request; AGENTS.md revision

## D-016 — Keep fixture expectations out of reusable standing policy

- Date: 2026-11-07
- Status: Adopted
- Decision: Get expected behavior from the task, tests or relevant documentation; never derive the specification solely from current implementation output.
- Motivation / evidence: The hardcoded hello greeting overfit AGENTS.md to the experiment. R05 showed why expectations must be independent of implementation.
- Alternative considered: Keep the greeting in general instructions.
- Consequences and limits: When acceptance criteria are missing, describe verification limits or ask; do not invent them.
- Revisit trigger: Project-specific test entry points may be documented, without turning a single fixture output into universal policy.
- Evidence record: User generalisation challenge; four-layer discussion

## D-017 — Organise AGENTS.md into four layers in one file

- Date: 2026-11-07
- Status: Adopted; replacement file generated
- Decision: Use General Policy; Godot-Specific Policy; Chosen Godot Conventions; Project Context and Procedures.
- Motivation / evidence: Separates universal working agreements, engine handling, deliberate development choices and local facts. User proposed the fourth layer to distinguish Godot requirements from chosen 2D/typing conventions.
- Alternative considered: Mixed flat rules; earlier three-layer structure; four physical files immediately.
- Consequences and limits: Repository installation of the generated replacement is not confirmed. One-file structure avoids premature distribution machinery.
- Revisit trigger: Split files only when real cross-repository maintenance warrants it.
- Evidence record: User four-part proposal and approval; generated replacement

## D-018 — Specificity does not silently expand authority

- Date: 2026-11-07
- Status: Adopted
- Decision: Later sections may specialise earlier rules but must surface conflicts rather than silently override prohibitions.
- Motivation / evidence: A project-specific instruction should not accidentally negate preservation or Git restrictions.
- Alternative considered: More specific always wins.
- Consequences and limits: This is the internal document rule, not a replacement for the hosting agent system's instruction hierarchy.
- Revisit trigger: Revisit when explicit exceptions become necessary; document approval and scope.
- Evidence record: Four-layer discussion and replacement AGENTS.md

## D-019 — Retain suppression and Variant-bypass restrictions as provisional

- Date: 2026-11-06 to 2026-11-07
- Status: Experimental
- Decision: Require explanation and approval before suppressions or Variant used merely to evade typing checks. Keep the rule tagged experimental.
- Motivation / evidence: Concern was plausible but implementation-pressure behavior was not tested in the detector ladder.
- Alternative considered: Ban all legitimate Variant use; remove the safeguard; declare it proven.
- Consequences and limits: The policy is about evasion, not all Variant use. Do not claim the ladder validated it.
- Revisit trigger: Revisit after actual node-access/dynamic-data implementation tasks.
- Evidence record: Strictness discussion; AGENTS.md evolution

## D-020 — Record command scope and historical verification honestly

- Date: 2026-11-07
- Status: Adopted
- Decision: Use a short scene run as a smoke check only; choose task-appropriate duration/tests. Distinguish exercised command forms from current project success. Run project checks sequentially.
- Motivation / evidence: The hello fixture exercises early startup, not later behavior. Historical verified labels can be mistaken for current status. Sequential execution keeps the prescribed workflow simple and avoids introducing concurrent project operations.
- Alternative considered: Treat --quit-after 2 as general behavioral proof; parallelize all checks; label commands simply verified.
- Consequences and limits: Concurrency failure was not demonstrated. Syntax-check timeout wrapper was added as a safety measure and not separately exercised in supplied runs.
- Revisit trigger: Adapt to the real test runner and simulation acceptance criteria.
- Evidence record: AGENTS.md revisions; R04–R05; generalisation discussion

## D-021 — Separate experiment identity from round identity

- Date: 2026-11-07
- Status: Adopted
- Decision: Record the fault ladder as EXP-02 with rounds R01–R05 and an overall completion card.
- Motivation / evidence: Preserves relationship among probes without claiming separately planned EXP-03–05 were run. User explicitly endorsed the distinction.
- Alternative considered: Assign each fault a new top-level experiment number.
- Consequences and limits: Cards are retrospective records based on supplied transcripts, not independent reruns.
- Revisit trigger: Use new experiment identifiers when the question or design is genuinely distinct.
- Evidence record: EXP-01 card; generated EXP-02 cards; user acknowledgement

## D-022 — Stop detector expansion after the five core rounds

- Date: 2026-11-06 to 2026-11-07
- Status: Core ladder complete; follow-ons deferred
- Decision: Consolidate findings and carry the workflow into development rather than automatically extending tooling tests.
- Motivation / evidence: Core static/runtime/specification boundaries were exercised; more tooling experiments need a decision-relevant purpose.
- Alternative considered: Automatically run every optional extension.
- Consequences and limits: Warn-level visibility, node-access implementation, Variant pressure and iteration costs remain untested. Their deferral does not establish they are unnecessary forever.
- Revisit trigger: Resume when a concrete uncertainty affects development or policy.
- Evidence record: End-of-R05 recommendation; experiment summary

## D-023 — Maintain a living rationale log alongside experiment evidence

- Date: 2026-11-07
- Status: Adopted; initial log generated
- Decision: Use stable decision IDs, explicit statuses, motivations, alternatives, evidence limits and revisit triggers. Preserve superseded positions instead of rewriting history.
- Motivation / evidence: User requested durable project documentation explaining how the approach evolved, not merely its final configuration.
- Alternative considered: Keep rationale only in conversation or duplicate all raw experiment output.
- Consequences and limits: The log records choices; completion cards retain observations; AGENTS.md carries current operating instructions.
- Revisit trigger: Update when a consequential decision changes, not for every conversational suggestion.
- Evidence record: Current user request


## D-024 — Use a reviewed red-to-green implementation experiment

- Date: 2026-11-07
- Status: Adopted; EXP-03 complete
- Decision: Separate fixture creation/review from a fresh implementation session, freeze acceptance artifacts, and begin by reproducing the red state.
- Motivation / evidence: EXP-02 tested detection, not implementation. EXP-03 reported the initial seven failures, then eight passing cases with only the implementation changed.
- Alternative considered: Continue arbitrary fault plants or start without reviewing the fixture.
- Consequences and limits: Reviewed fixture checkpoint: 2c81eecff24ab1a404929b9dd8154df64eb27e7f. Commands are supported by supplied reports; source was reviewed, not rerun here.
- Revisit trigger: Revisit if real tasks expose fixture overhead or inadequate criteria.
- Evidence record: EXP-03 source review, user-supplied command reports and post-experiment discussion.

## D-025 — Preserve independent reference data and prefer the fixed typed interface

- Date: 2026-11-07
- Status: Adopted for EXP-03 fixture
- Decision: Use direct typed allocator invocation and validate request bounds against a pre-call snapshot.
- Motivation / evidence: Initial fixture used unnecessary dynamic dispatch and read bounds from potentially mutated input. Review corrected both before freeze.
- Alternative considered: Keep dynamic machinery solely because class_name is absent; use mutated inputs as the oracle.
- Consequences and limits: This is a fixture decision, not a universal prohibition on Callable or dynamic data. Failed intermediate inference source was not preserved.
- Revisit trigger: Use dynamic invocation when a real interface requires it.
- Evidence record: EXP-03 source review, user-supplied command reports and post-experiment discussion.

## D-026 — Protect acceptance artifacts without making tests immutable

- Date: 2026-11-07
- Status: Adopted; policy file generated
- Decision: Require approval before changing defective/conflicting acceptance criteria; never weaken them merely to make implementation pass.
- Motivation / evidence: Fixed specification and runner were preserved during EXP-03. Their authority previously depended on task wording rather than an explicit general policy.
- Alternative considered: Silently edit expectations; prohibit every legitimate test change.
- Consequences and limits: Implemented in the delivered AGENTS.md, not confirmed installed in the repository.
- Revisit trigger: Revisit if authority remains ambiguous during real test maintenance.
- Evidence record: EXP-03 source review, user-supplied command reports and post-experiment discussion.

## D-027 — Update command procedures with exercised runner support

- Date: 2026-11-07
- Status: Adopted; policy file generated
- Decision: Add parameterised standalone runner command and completion-evidence guidance; replace the obsolete untested-timeout note.
- Motivation / evidence: EXP-03 exercised timeout-wrapped syntax checks and standalone runner, with both red and green outcomes reported.
- Alternative considered: Keep stale procedure notes or hardcode EXP03_PASS into reusable policy.
- Consequences and limits: Historical success is not current verification. Test-specific tokens remain in their fixture.
- Revisit trigger: Revise when the actual project test harness changes.
- Evidence record: EXP-03 source review, user-supplied command reports and post-experiment discussion.

## D-028 — Close the required tooling gate after EXP-03

- Date: 2026-11-07
- Status: Adopted
- Decision: Mark EXP-03 PASS within scope and proceed toward the smallest useful simulation probe; optional recovery remains separate.
- Motivation / evidence: Implementation matched the reviewed contract; eight cases passed according to reports; checkpoint status/diff reported a single authorised file change.
- Alternative considered: Automatically expand optional tooling probes.
- Consequences and limits: Implementation commit is not supplied. No general reliability, performance, dynamic-data or cost conclusion follows.
- Revisit trigger: Reopen tooling work when it blocks a concrete development decision.
- Evidence record: EXP-03 source review, user-supplied command reports and post-experiment discussion.

## D-029 — Extract skills from recurring concrete procedures, not length alone

- Date: 2026-11-07
- Status: Adopted as maintenance direction
- Decision: Let skill candidates emerge from repeated concrete workflow; AGENTS.md growth can signal a candidate but is not sufficient justification.
- Motivation / evidence: User anticipated concrete-level instruction growth; discussion distinguished reusable procedures from unnecessary policy.
- Alternative considered: Create a skill pre-emptively or move bloat unchanged elsewhere.
- Consequences and limits: No new skill created or tested.
- Revisit trigger: Extract once a recurring procedure has a stable purpose and useful scope.
- Evidence record: EXP-03 source review, user-supplied command reports and post-experiment discussion.


## Dated amendments to earlier decisions — 2026-11-07, after EXP-03

Earlier entries retain their original evidence horizon. The amendments below supersede stale present-tense limitations, not the recorded history.

- D-006: A standalone runner was now exercised with intentional red and reported green states. The initial implementation remained failing; reproducing that failure was a successful setup observation, not a passing implementation.
- D-012: EXP-03 implementation reports were internally consistent in this run. That does not establish a reliable rate or isolate the effect of the reporting rule.
- D-017: The latest four-layer AGENTS.md was subsequently uploaded and used as the basis for this update. Exact installed/committed repository contents remain outside direct inspection.
- D-019: Final allocator source had no suppressions or dynamic invocation. Keep the policy experimental because legitimate dynamic-data pressure was not tested.
- D-020: The timeout-wrapped syntax and standalone runner forms were exercised in EXP-03. The earlier untested-wrapper note is obsolete.
- D-022: EXP-03 is now complete; required EXP-01–03 tooling gate closed. Optional probes remain deferred, not disproven.
- D-023: Decision and discovery logs now include EXP-03 amendments and new entries; stable earlier IDs preserved.

## Open questions and deferred probes

- What precisely triggered the TextEdit negative-line-index diagnostic? Neither an open-editor conflict nor saved layout state was isolated.
- How do conventions behave in richer implementation? EXP-03 supplied a bounded typed-function success; dynamic-data and node-access pressure remain untested.
- Will consistent reporting persist? EXP-03 supplied one consistent implementation report, not a general validation of the rules.
- Is the latest AGENTS.md installed and committed? A four-layer file was uploaded and reviewed; this newly generated revision has not been observed in the repository.
- What is the final EXP-03 implementation commit? Only the fixture checkpoint was supplied.
- Warn-level Unsafe Cast visibility was discussed but not exercised. Earlier technical explanations in the thread should not be treated as experimental findings.
- No strict-versus-default productivity or cost comparison was performed. No new allowance measurements were supplied for the ladder.

## Explicit corrections retained

- The initial insistence on a non-strict baseline was withdrawn because it would not inform the chosen action (D-004 → D-005).
- The original verification prompt permitted an avoidable ambiguity about repairs; responsibility belongs partly to the protocol (D-008).
- Early rounds were not independent fresh-session trials (D-009).
- Correct detailed diagnostics did not guarantee consistent final summaries (D-012).
- The TextEdit explanation and proposed cure were overstated earlier; cause remains unresolved (D-013–D-014).
- A fixture greeting does not belong in reusable standing policy (D-016).

## New decision template

### D-XXX — Short decision title

- Date: YYYY-MM-DD
- Status: Proposed / Adopted / Experimental / Deferred / Superseded / Unresolved
- Decision:
- Motivation / evidence:
- Alternative considered:
- Consequences and limits:
- Revisit trigger:
- Evidence record:
- Supersedes / superseded by: if applicable
- Implementation state: proposed / generated / installed / verified, with evidence

## Change history

| Date | Change |
|---|---|
| 2026-11-07 | Initial reconstruction of D-001–D-023 from the experiment record and discussion. No new experiment results added. |

| 2026-11-07, post-EXP-03 | Added D-024–D-029 and dated amendments; recorded fixture checkpoint, bounded PASS, policy adjustments and outstanding implementation-commit status. |
