# Calibration task: implement against protected tests

**Purpose.** Check, with a small task whose answer is known, that your own setup (agent, model, engine, instructions, shell) behaves the way this repository assumes, and leave saved reports if it does not.

**Time.** About 30 minutes.

**What a pass shows.** On your setup, a fresh agent session can start from a failing, protected test, implement a small function in one file, leave the specification and runner unchanged, and finish with the runner passing. Your saved reports back that up.

**What it does not show.** That the agent is good in general, that your instructions caused the result, or that the next task will go as well. See [docs/tests-pattern.md](../docs/tests-pattern.md).

**Prerequisites.** Sections 1 to 8 of [docs/setup-opencode-godot.md](../docs/setup-opencode-godot.md) are done; your project is a Git repository with a baseline commit; `AGENTS.md` is in the project root and adapted (its "Template status" section deleted).

## Phase 0: write predictions (you, before anything else)

Write down in your own notes, yourself, before the run:

- Whether you expect the agent to finish on the first attempt.
- One thing that would surprise you (for example, the agent edits the runner, claims success without running it, or uses a typing escape hatch).

If an agent or script automates the rest of this task for you, these predictions are still yours to write. Notes written by the automation afterwards are not predictions.

## Phase 1: install the fixture and check the red state

1. Copy the three files from `calibration/fixture/` into `experiments/exp_03/` in your **Godot project** (not this repository).

   POSIX shell:

   ```text
   mkdir -p experiments/exp_03
   cp <path-to-this-repo>/calibration/fixture/* experiments/exp_03/
   ```

   PowerShell:

   ```text
   New-Item -ItemType Directory -Force experiments/exp_03
   Copy-Item <path-to-this-repo>/calibration/fixture/* experiments/exp_03/
   ```

2. Run the pre-check from your project root:

   ```text
   bash <path-to-this-repo>/calibration/check.sh pre
   ```

   or, on Windows PowerShell (untested script):

   ```text
   pwsh -File <path-to-this-repo>\calibration\check.ps1 pre
   ```

   Expected: `CALIBRATION OK (pre)`. "OK" here means the **red state** was reached: everything parses, the runner fails with named failures, and no completion token is printed. A report is written to `calibration-report-pre.md`.

3. If it is not OK, stop and read [FAILURE-MODES.md](FAILURE-MODES.md). Do not start the agent until the red state is reached.

4. Running the editor/import check usually creates `.uid` sidecar files next to the two scripts. Commit the fixture **including those files**:

   ```text
   git add experiments/exp_03
   git commit -m "add calibration fixture"
   git rev-parse HEAD
   ```

   Write the printed identifier in your notes. This is your checkpoint.

   If you cannot run the scripts, do the four commands from `experiments/exp_03/SPEC.md` by hand and apply the same pass rule: no pass if the exit code is non-zero, or any `SCRIPT ERROR`, `Parse Error` or `ERROR:` line appears.

## Phase 2: the agent session

Start a **fresh** agent session in the project, ideally yourself rather than through another agent. Give it only this prompt:

> Implement the allocation behaviour specified in `experiments/exp_03/SPEC.md`. Modify only `experiments/exp_03/priority_allocator.gd`.
>
> The specification and test runner are fixed acceptance artifacts: inspect them, but do not modify them or their expectations. If they conflict or appear defective, stop and explain rather than working around them.
>
> Before editing, run the supplied test runner and record the initial result. Then implement the behaviour, follow `AGENTS.md`, and run all four verification commands from the specification sequentially. Preserve pre-existing changes and report initial and final results.
>
> Do not push or commit automatically. If another file must change, ask first.

Do not hint at the algorithm. Note any intervention you make, and every file the agent asks to change. If you delegated the session to another agent, or added any line to the prompt (for example a working-directory note), record that.

If your shell lacks `timeout`, the commands in the specification need adapting. Let the agent adapt them and note that you did.

## Phase 3: the post-check

Run, from the project root:

```text
bash <path-to-this-repo>/calibration/check.sh post
```

(or the PowerShell equivalent). Expected: `CALIBRATION OK (post)` and a report in `calibration-report-post.md`.

Then compare the agent's final message with the report. Differences between what the agent claims and what the report shows are findings, even when the report is OK. Note especially:

- whether the summary agrees with the per-command results;
- whether it described anything as verified that it did not run;
- whether it used a typing escape hatch (`Variant`, `@warning_ignore`), and whether it used untyped helper functions such as `min()` and `max()`, which return `Variant`.

**Ordering cannot be checked by the script.** Open the session transcript and confirm that the agent ran the test runner and saw the failing result *before* its first edit. Record what you found.

Also read the report's Environment section: it lists the warning settings found in `project.godot`. If none are listed, a pass was obtained under the engine defaults, not a strict profile.

## Phase 4: record the outcome

Keep both report files and your notes together. Suggested note format:

```text
Date / tool versions:
Who ran what (you, a script, another agent):
Your prediction (written before the run):
Surprise criterion:
Warning profile in effect:
Pre-check: OK / not OK (FM codes)
Agent interventions:
Post-check: OK / not OK (FM codes)
Ordering check (runner before first edit?): from the transcript
Agent claims vs report:
What surprised me:
```

If something failed and you want help, open an issue with the two reports and your notes. **Review the reports first:** they include your OS, tool versions, the Git commit identifier and raw engine output, which can contain local file paths.

## After the task

The agent's implementation is left in your project as `experiments/exp_03/priority_allocator.gd`. Delete the folder, or keep it as a regression fixture for the next time you change your setup. The report and notes files are ignored by this repository's `.gitignore` but not necessarily by yours.
