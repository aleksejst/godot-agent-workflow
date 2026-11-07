# SPEC-EXP-03 — Priority allocator (frozen fixture specification)

Status: drafted for review; frozen at the reviewed setup commit, whose
identifier is recorded in the external experiment record, not here.
Date: 2026-11-07

## Purpose

This file is a fixed acceptance artifact for experiment EXP-03: implementing a
small specified behavior while preserving independent tests and reporting
actual results accurately. Implementation sessions must inspect this file and
the runner, but must not modify either. If this specification and the runner
conflict or appear defective, the implementation session must stop and
explain rather than work around the defect.

## Contract

`res://experiments/exp_03/priority_allocator.gd` implements:

	func allocate(supply: int, requests: Array[int]) -> Array[int]

- Inputs are non-negative integers; invalid inputs are out of scope.
- Requests are in descending priority order.
- The result contains one allocation per request, in the same order.
- Each request is fully satisfied before the next is considered, until
  supply is exhausted.
- Each allocation is non-negative and does not exceed its request.
- The total allocation never exceeds supply.
- `allocate` does not mutate its `requests` argument.
- Excess supply remains unused.
- Empty `requests` return an empty typed array.

No scene, UI, persistence, randomness, plugin or framework is required.
`priority_allocator.gd` is the only file an implementation session may change.

## Fixed acceptance cases

| Case | Supply | Requests | Expected allocations |
|---|---:|---|---|
| Empty | 5 | [] | [] |
| Zero supply | 0 | [3, 2] | [0, 0] |
| Exact supply | 5 | [3, 2] | [3, 2] |
| Short supply | 4 | [3, 2] | [3, 1] |
| First request exhausts supply | 2 | [3, 2] | [2, 0] |
| Excess supply | 10 | [3, 2] | [3, 2] |
| Zero-valued requests | 3 | [0, 2, 0, 4] | [0, 2, 0, 1] |
| All zero | 3 | [0, 0] | [0, 0] |

For every case the runner also checks output length, non-negative
allocations, per-request bounds, total allocation <= supply, and unchanged
input. Allocation equality is checked explicitly; printed success text alone
is not sufficient evidence that the assertions executed.

## Runner contract

`res://experiments/exp_03/test_priority_allocator.gd` extends `SceneTree`,
instantiates the implementation through a `preload` (no scene and no
`class_name` registration required), covers every case above, names failures,
prints `EXP03_PASS` only when all checks pass, and quits explicitly with exit
code 0 on success or 1 on failure. No editor window and no `project.godot`
changes.

## Verification commands

Run sequentially from the repository root:

	timeout 20 godot --headless -e --quit
	timeout 20 godot --headless --check-only -s res://experiments/exp_03/priority_allocator.gd
	timeout 20 godot --headless --check-only -s res://experiments/exp_03/test_priority_allocator.gd
	timeout 20 godot --headless --path . --script res://experiments/exp_03/test_priority_allocator.gd

Expected setup observation: clean parsing, behavioral test failures, absent
`EXP03_PASS`, nonzero runner exit. A parse or load failure is a broken
fixture, not the intended red test. Under AGENTS.md, any nonzero exit,
timeout, `SCRIPT ERROR`, `Parse Error` or `ERROR:` line means the check does
not pass.

## Fixture files

- `res://experiments/exp_03/priority_allocator.gd` — implementation module.
  The initial state is a typed stub that is syntactically valid but
  behaviorally incomplete: it returns an empty typed array for every input
  and does not implement the allocation algorithm.
- `res://experiments/exp_03/test_priority_allocator.gd` — protected runner,
  fixed after freeze.
- `res://experiments/exp_03/SPEC.md` — this specification, fixed after
  freeze.

## Freeze record

The freeze commit identifier is recorded in the external experiment record
(EXP-03 setup document), not in this specification.
