# Experiment Completion Card — EXP-03: Implementation Against Independent Tests

Date: 2026-11-07
Project: Godot agent tooling pipeline (Stage A)
Domain (Cynefin): Complicated — bounded implementation and workflow validation
Status: PASS within the specified scope; implementation commit not reported.
Fixture checkpoint: 2c81eecff24ab1a404929b9dd8154df64eb27e7f

## 1. Setup

| Item | Value |
|---|---|
| Engine | Godot 4.6.3.stable, according to supplied reports |
| Workflow | Separate fixture-building and fresh implementation sessions |
| Agent/model | OpenCode workflow; exact provider/model not reconfirmed for this experiment |
| Policy | Four-layer AGENTS.md supplied; strict typed GDScript conventions |
| Implementation | experiments/exp_03/priority_allocator.gd |
| Protected artifacts | experiments/exp_03/SPEC.md and test_priority_allocator.gd |
| Dependencies | No new dependency, framework, scene or UI reported |
| Evidence | User-supplied reports, command excerpts and uploaded source; no independent Godot execution by the card author |

## 2. Hypothesis and predictions

Question: Can the agent implement a small specified behaviour, preserve independent acceptance artifacts and existing work, and report actual results accurately?

Analytical prediction recorded before implementation: the agent would implement the rule using typed GDScript, retain the fixed specification/runner and obtain passing results without a new dependency.

Potential surprises named beforehand: changed expectations, typing bypasses, success claims without running tests, input mutation or fixture complexity dominating implementation.

No separate human prediction is present in the supplied record. Do not reconstruct one as contemporaneous evidence.

## 3. Contract and acceptance cases

Interface: func allocate(supply: int, requests: Array[int]) -> Array[int]

Inputs are non-negative integers. Allocate in supplied priority order, fully satisfying each request before the next until supply is exhausted. Return one value per request; preserve requests; do not exceed requests or supply. Excess supply is unused. Invalid inputs, performance, UI and simulation design are out of scope.

| Case | Supply | Requests | Expected |
|---|---:|---|---|
| Empty | 5 | [] | [] |
| Zero supply | 0 | [3, 2] | [0, 0] |
| Exact supply | 5 | [3, 2] | [3, 2] |
| Short supply | 4 | [3, 2] | [3, 1] |
| First request exhausts supply | 2 | [3, 2] | [2, 0] |
| Excess supply | 10 | [3, 2] | [3, 2] |
| Zero-valued requests | 3 | [0, 2, 0, 4] | [0, 2, 0, 1] |
| All zero | 3 | [0, 0] | [0, 0] |

Runner checks length, expected values, non-negativity, request bounds, total supply and unchanged input. Element-level checks are skipped when length is wrong; input-mutation comparison still runs. Types are enforced through the fixed typed interface. Cases are explicit examples, not exhaustive coverage.

## 4. What was done

1. Fixture agent created the specification, SceneTree runner and a typed stub returning an empty array.
2. Initial setup reported clean parsing and seven behavioural failures; the empty case passed.
3. Human/analytical review requested direct typed invocation instead of Callable.callv(), checking bounds against the original input snapshot, corrected failure accounting and an external freeze record.
4. Fixture agent applied corrections. It reported an interim inferred-instance parse failure, then a successful explicitly typed instance. Failed intermediate source/full diagnostics were not supplied, so no broad claim about new() type inference is made.
5. Revised source was reviewed. Final setup again reported one passing case and seven behavioural failures, no fixture errors, exit 1 and no EXP03_PASS.
6. User supplied the reviewed fixture checkpoint above. Frozen specification/runner were kept separate from the editable implementation.
7. Fresh implementation session ran the initial runner before editing, reproducing the red state.
8. Agent implemented an ordered loop: allocate mini(remaining, request) while remaining supply is positive; otherwise append zero. It builds a separate typed output array.
9. Agent reported all four final checks passing and no changes outside the implementation.
10. Read-only checkpoint comparison reported only priority_allocator.gd changed (13 insertions, 9 deletions). Uploaded final source was reviewed and matched the stated contract.

## 5. Results

| Check | Initial state | Final state |
|---|---|---|
| Editor/import | Clean in reviewed setup | Exit 0; no reported error lines |
| Implementation syntax | Clean typed stub | Exit 0 |
| Runner syntax | Clean after setup correction | Exit 0 |
| Behavioral runner | Exit 1; 1 passed, 7 failed, 0 fixture errors; no EXP03_PASS | Exit 0; all 8 passed; EXP03_PASS reported |
| Protected artifacts | Frozen at supplied checkpoint | Reported unchanged in checkpoint comparison |
| Editing boundary | Only implementation authorised | Only implementation changed according to status/diff report |

Commands, run sequentially from the repository root:

    timeout 20 godot --headless -e --quit
    timeout 20 godot --headless --check-only -s res://experiments/exp_03/priority_allocator.gd
    timeout 20 godot --headless --check-only -s res://experiments/exp_03/test_priority_allocator.gd
    timeout 20 godot --headless --path . --script res://experiments/exp_03/test_priority_allocator.gd

The initial behavioral run was intentionally non-passing; reproducing that expected failure validated the starting state. It was not reclassified as a passing implementation.

## 6. Verified versus not established

Reviewed directly: final runner, specification and implementation source. Final implementation is typed, preserves inputs, contains no suppression annotations or dynamic invocation, and does not branch on acceptance-case identities.

Supported by supplied reports: command outcomes, initial-to-final sequence, no new dependency, no commits/pushes, unchanged protected artifacts and single-file edit scope.

Not independently established: fresh local reruns by this author; full untruncated final output; general reliability across tasks; exhaustive correctness; performance; invalid-input handling; post-experiment implementation commit. Visual verification is not applicable to this no-UI fixture.

Checkpoint comparison nuance: git diff does not include untracked files. The separately supplied git status --porcelain listed only the modified implementation and no untracked entries. Do not treat the agent's incorrect explanation of diff scope as a capability of Git.

## 7. Findings and surprises

- Implementation proceeded without reported human intervention after the reviewed fixture was frozen. Exact internal edit/check cycle count and elapsed effort were not measured.
- Fixture construction did require substantive review: dynamic indirection and mutable reference data were unnecessary risks.
- Typed direct invocation worked in the final fixture without class_name registration.
- All-green execution exercised the runner's success branch, but does not prove the fixture has no defects.
- Reports preserved the initial failure rather than presenting only the final success.
- A residual explanation error about untracked files appeared during checkpoint review. This did not invalidate the observed change boundary.
- Passing tests supports tested behaviour; it does not establish that AGENTS.md alone caused success.

## 8. Allowance and cost

No new readings supplied. Token use, provider cost, elapsed duration and comparative iteration cost were not measured.

## 9. Challenge ledger

| Concern | Result / remaining limitation |
|---|---|
| Success claimed without exercised behavior | Addressed in this bounded run by reported red-to-green runner execution |
| Acceptance artifacts weakened | No such changes reported; checkpoint comparison preserved them |
| Typing escapes under pressure | None in final source; task did not force legitimate dynamic-data use |
| Testing tools indefinitely | Required EXP-01–03 gate complete; move toward a small simulation probe |
| Tests themselves wrong | Reviewed, not proven exhaustive; independent specification remains important |

## 10. Decisions and standing state

- Close EXP-03 as PASS within scope.
- Stop expanding the mandatory tooling gate; optional scoped-recovery testing remains separate.
- Preserve fixture checkpoint separately from any later implementation commit.
- Do not add experiment acceptance values, checkpoint hashes or success tokens to reusable AGENTS.md policy.
- Candidate minimal policy updates: explicit protection of acceptance artifacts; add standalone test-runner command; update historical verification wording now that timeout-wrapped checks have been exercised. These are proposals in this card, not claims of installation.
- Keep suppression policy experimental: absence of evasion in a simple task is not a comprehensive stress test.

## 11. Session reflection

What landed: independent reviewed acceptance artifacts, a fresh implementation session, typed implementation, bounded edits and an honestly reported red-to-green sequence.

What did not land initially: fixture builder introduced unnecessary dynamic dispatch and checked bounds against potentially mutated input. Review corrected the apparatus before the result was trusted.

Connection: acceptance criteria are an external constraint on implementation, while the fixture itself remains an artifact needing scrutiny. Correct behavior and correct evidence are related but separate achievements.

Gap: substantive simulation work and implementation under richer data constraints remain untested.

Suggested next probe: smallest runnable simulation that can surprise us about institutional dynamics, not another arbitrary extension of the tooling ladder.

## 12. Discovery log line

> EXP-03 PASS: A fresh implementation session reproduced the reviewed red state, implemented priority allocation and reported all eight cases passing. Checkpoint comparison showed only the authorised implementation changed. Fixture construction required review; no implementation-phase intervention was reported. This supports the bounded workflow, not general reliability.
