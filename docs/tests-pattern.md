# The protected-test pattern

This is the pattern behind the calibration task and the third experiment. Use it whenever you want to see whether an agent implements something *against* a fixed standard instead of adjusting the standard to fit.

## The three artifacts

| Artifact | Role | Who may change it |
|---|---|---|
| Specification (`SPEC.md`) | States the contract and acceptance cases in prose and a table | Nobody during implementation |
| Test runner | Executes the cases, prints named failures, prints a completion token only when everything passed, and exits non-zero otherwise | Nobody during implementation |
| Stub | A valid, typed implementation that does nothing useful | The implementation session, only this file |

## The sequence

1. **Build the fixture in a separate session.** Ask for the specification, the runner and a stub that returns an empty result. Do not let that session implement the behaviour.
2. **Review the fixture before trusting it.** Check the expected values by hand. Check that the comparisons really compare. Check that the stub fails for behavioural reasons, not because the runner cannot load.
3. **Confirm the red state.** The stub should parse cleanly and fail with named failures, a non-zero exit, and no completion token. A parse failure means the fixture is broken, not that the red state was reached.
4. **Freeze it.** Commit the fixture and record the commit identifier somewhere *outside* the frozen files. Writing the identifier into the frozen specification would modify it after the freeze.
5. **Implement in a fresh session**, restricted to the stub file. The agent should run the runner before editing, so the initial failure is recorded.
6. **Compare with the checkpoint.** Confirm that only the implementation file changed.

## Fixture review lessons

These came from reviewing the first draft of the fixture in the experiments:

- Prefer a direct call through a typed instance over dynamic invocation when the interface is fixed. Dynamic calls return untyped values and invite casts.
- Measure bounds against a **snapshot of the input**, not the argument the implementation received. An implementation that mutates its input should be reported as such, not crash the runner.
- Keep fixture-error counts separate from case-failure counts, and make the completion token depend on both being zero.
- Write explicit comparisons. A printed "pass" is not evidence that an assertion ran.
- Keep per-test details out of reusable policy. The shipped policy says to protect acceptance criteria; it does not name this fixture.

## Limits of what the scripts can check

- A script can show the end state. It cannot show *ordering*, such as whether the agent ran the runner before editing. Check the session transcript for that.
- Strict typing does not guarantee the absence of `Variant`. According to the Godot documentation, the global `min()` and `max()` return `Variant`, while `mini()` and `maxi()` work on integers. In one calibration run an implementation that used `min()` passed every check. Prefer the typed variants, and do not read a pass as proof that no untyped value was involved.

## What a pass does and does not show

It shows that, for the listed cases, the implementation matched the specification and the protected files were unchanged. It does not show exhaustive correctness, invalid-input handling, performance, or that the agent will behave the same way next time. Tests you did not write cannot protect you from behaviour you did not specify.

## Reusing the pattern

Replace the specification, runner and stub. Keep the roles. Add your own cases deliberately; the allocation rule in the calibration fixture is an exercise, not a design recommendation.
