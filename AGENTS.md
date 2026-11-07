# AGENTS.md

## Template status (delete this section once you have adapted the file)

This file is an unadapted template. Until the user confirms it has been adapted:

- At the start of the first session, tell the user that section 3 contains the template authors' defaults and section 4 contains placeholders, and that both must be reviewed and completed for their own project.
- Do not treat anything in section 3 or section 4 as established fact about this project. Do not guess values for `<placeholders>`: ask, or say what is unknown.
- Sections 1 and 2 apply as written.

These sections move from general rules to project-specific application. Later sections may specialise earlier rules but do not silently override prohibitions or expand authority. If instructions conflict, identify the conflict and ask before taking the affected action.

## 1. General Policy

### Scope and ownership
- Verification-only requests do not authorise repairs. Inspect and run checks against the current working tree; report failures and propose repairs without applying them.
- Preserve pre-existing changes. Do not revert, restore or overwrite them without explicit permission. Prefer targeted edits over restoring entire files when proposing repairs.
- Never push, and never rewrite Git history.

### Evidence and verification
- Establish acceptance criteria from the task and relevant tests or documentation. Do not treat the current implementation's output as the specification.
- During implementation, do not change acceptance criteria or test expectations merely to make the implementation pass. If a test or specification appears defective or conflicts with the task, explain the issue and obtain approval before changing it.
- Judge each check separately against its acceptance criteria. Tool completion alone does not establish correct behaviour.
- If acceptance criteria are missing or ambiguous, state what the checks establish and what remains unverified. Ask for clarification when needed; do not invent an expected result.
- During verification-only tasks, run all applicable checks against the unchanged project, even if an earlier check fails, unless continuing would be unsafe.
- Keep separate diagnostics separate. One error disappearing does not make a check pass if another remains.
- Distinguish observed facts from suspected causes and untested remedies. Do not present an error as harmless or a known tool/engine bug without supporting evidence.
- After a repair, rerun applicable checks before claiming it resolved the failure. Keep initial and post-repair results distinct.

### Reporting
- End every task with two headings: Done and Could not verify.
- For checks run this session, report the command, exit code, relevant output and pass/fail result. A verified failure is still a failure.
- Make summaries agree with the per-check results.
- Report shortcuts, stubs and hardcoded values introduced. Identify proposed repairs that were not applied or tested.
- Claim verification only for checks actually run in this session. State visual or other untested behaviour under Could not verify.

## 2. Godot-Specific Policy

- Do not manually edit or clear `.godot/` without explicit permission; normal writes made by prescribed Godot commands are allowed.
- Commit `*.uid` files with the associated scripts and move them together.
- Run Godot verification commands sequentially, not concurrently against the same project.
- Distinguish editor/import checks, script syntax checks, scene execution and visual inspection. Passing one does not establish success in the others.
- Read full command output as well as exit status. Under the normal verification commands, a nonzero exit, timeout, or any `SCRIPT ERROR`, `Parse Error` or `ERROR:` line means the check does not pass. Exit code 0 alone never establishes success.
- For scene runs, compare observed behaviour with the task's acceptance criteria, including expected output where specified. Clean execution with incorrect or missing required output is a failure.
- Editor/import and syntax checks do not need to print the scene's expected output.
- Headless checks do not establish visual correctness. A short smoke run establishes only what was exercised during that run.

## 3. Chosen Godot Conventions

These are deliberate defaults of the authors of this template, not universal engine requirements. Adopt, change or delete each line to match your own choices before relying on it.

- Develop in 2D using GDScript.
- Use Godot 4 syntax (`@export`, `@onready`, `await`, `signal.connect()`), never Godot 3 syntax.
- Use fully typed GDScript. Declare every variable, parameter and return type.
- Use typed node references, such as typed `@onready` variables or appropriate `as` casts.
- Indent with tabs. Never mix tabs and spaces.
- Target warning policy: Untyped Declaration, Unsafe Property Access, Unsafe Method Access and Unsafe Call Argument at Error; Unsafe Cast at Warn. Do not change warning levels merely to make code pass.
- [EXPERIMENTAL] Do not suppress diagnostics with `@warning_ignore` or `@warning_ignore_start`, or use `Variant` merely to bypass typing checks. If an exception seems justified, explain why and ask first.
- Do not launch the game window. Headless runs are permitted. If visual verification is needed, ask me to run it and describe what I see.
- Do not change `project.godot`, including warning levels, unless explicitly asked.

## 4. Project Context and Procedures

<!-- Replace every <placeholder> and delete lines that do not apply. State what is true of THIS repository, not what you hope is true. -->

### Current context
- Project: <name and one-line purpose>.
- Engine: Godot <version>, available as `<command or full path>`.
- Warning configuration: <what `project.godot` actually sets, or "not yet configured">. Inspect `project.godot` before making claims about its current configuration.
- Acceptance criteria and specifications live in: <paths, or "none yet; ask">.
- Test entry points: <paths, or "none yet">.
- Out of scope for the agent: <files, directories or areas>.

### Verification commands
Run from the repository root. Replace placeholder paths with relevant scripts, scenes and test runners; use task-appropriate tests or longer observation periods when acceptance criteria require them. `timeout 20` is a GNU/POSIX wrapper: use an equivalent on shells without it (on Windows, the built-in `timeout` is a different command that only waits).

- Editor/import check: `timeout 20 godot --headless -e --quit`
- Individual script syntax check: `timeout 20 godot --headless --check-only -s res://path/script.gd`
- Short scene smoke check: `timeout 20 godot --headless --path . res://path/scene.tscn --quit-after 2`
- Standalone headless test runner: `timeout 20 godot --headless --path . --script res://path/test_runner.gd`

Use the runner's documented exit status, failure diagnostics and completion signal together. Missing expected completion evidence does not establish success, even if the process exits 0.

These command forms were exercised in the experiments this template comes from (see `history/`). Their results on your project are not established until you run them.
