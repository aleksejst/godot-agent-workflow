# OpenCode and Godot: from installation to a first agent-driven project

This guide takes you from nothing installed to a Godot project that an agent can safely work in, with a way to check that the setup behaves as intended. It is written to be OS-agnostic and to age well, so it describes **goal states and checks** instead of install commands.

## 0. Status of this guide

| Item | Status |
|---|---|
| Workflow, commands and checks | Exercised on Linux with OpenCode 2.0.24 and Godot 4.6.3 |
| Windows | Notes included; **not tested** here |
| macOS | Not tested |
| Install steps | Deliberately abstract; follow the official documentation |

Record your own versions when you start. Behaviour in later versions may differ.

## 1. What you need

- A terminal, and `git`.
- Godot 4.x (this guide's conventions assume GDScript and Godot 4 syntax).
- OpenCode.
- An account or key for a model provider that OpenCode supports, or a free model it offers.
- A text editor. You will also run the Godot editor yourself for anything visual.

## 2. Install Godot (goal state)

Use the official [download page](https://godotengine.org/download). The method (archive, package manager, store build) is up to you.

Goal state: a terminal command that starts the engine, and prints a 4.x version when you ask for it.

```text
godot --version
```

Notes:

- If your install provides the executable under another name or path, either put it on `PATH`, create an alias or shell function named `godot`, or tell the check scripts where it is with the `GODOT` environment variable.
- Windows: builds are commonly distributed with a normal executable and a separate console variant. The console variant prints to the terminal, which the verification commands and check scripts rely on. Confirm against the build you downloaded.
- macOS: the engine binary is typically inside the application bundle, so an alias to that path is a common approach. Confirm on your install.
- Headless operation (no window) is a built-in command-line option. See the official [command line tutorial](https://docs.godotengine.org/en/stable/tutorials/editor/command_line_tutorial.html).

## 3. Install OpenCode (goal state)

Follow the official [OpenCode documentation](https://opencode.ai/docs/). Installation methods have changed between versions, which is why they are not reproduced here.

Goal state:

```text
opencode --version
```

prints a version, and `opencode` starts a terminal interface when run inside a folder.

Windows: the OpenCode documentation has a page on [running under WSL](https://opencode.ai/docs/windows-wsl/) and recommends it for the best experience. If you do that, remember that the agent runs the `godot` it finds **inside WSL**. Install a Linux build of Godot there for headless checks, and keep each project in a single filesystem to avoid line-ending and file-watching surprises. This combination is not tested here.

## 4. Connect a model provider

Inside OpenCode, use its provider and model commands (in the tested version these were `/connect` and `/models`; check yours). Keep keys out of your repositories: never commit provider keys, `.env` files or local config that contains secrets.

Usage meters may be coarse or delayed. A reading of zero after a small task does not prove the task cost nothing, and a zero does not tell you whether the selected model is a free one.

## 5. Create the Godot project

1. Use the Godot project manager to create a project. Choose the renderer for your needs.
2. Initialise Git yourself: `git init`. In the tested version, the project manager's Git option only wrote `.gitignore` and `.gitattributes`.
3. Check `.gitignore`: it should ignore `.godot/` and must **not** ignore `*.uid`. Script UID sidecar files should be committed with their scripts.
4. Make a **baseline commit** before any agent work. Plain `git diff` shows nothing for untracked files, so without a baseline you cannot review what the agent did. After agent work, `git add -A && git diff --staged` shows everything.

## 6. Install the AGENTS.md template

1. Copy [`AGENTS.md`](../AGENTS.md) from this repository into your project root.
2. Edit section 3 (conventions). Everything there is a choice, not a requirement of the engine. Delete or change lines that do not match how you work.
3. Fill in section 4 for your repository, using only facts that are true now.
4. Delete the "Template status" section at the top of the file. While it is present, an agent will keep telling you the file is unadapted.
5. Commit it.

OpenCode reads `AGENTS.md` as persistent project instructions. See the [rules documentation](https://opencode.ai/docs/rules/) for where it looks and how it combines global and project files.

Treat any file the agent generates for you, such as the output of `/init`, as a **draft**. In the first experiment, a generated file stated things that were false and claimed everything was verified after one command. Review it line by line before relying on it.

## 7. Optional: strict GDScript warnings

The template's section 3 assumes strict typing. To match it, in the Godot editor:

1. Open Project Settings and turn on **Advanced Settings**.
2. Go to Debug, then GDScript, then Warnings.
3. Make sure the master warnings switch is on.
4. Set Untyped Declaration, Unsafe Property Access, Unsafe Method Access and Unsafe Call Argument to **Error**. Set Unsafe Cast to **Warn** (or whatever you prefer).
5. Restart the editor. Changed settings may not apply to open scripts until you edit them or restart.
6. Run `git diff project.godot` to confirm the change was saved, then commit it as its own commit so it can be reverted cleanly.

Warnings that are set to Error appear in headless output; Warn-level ones may need an extra flag to appear. Read the official [warning system page](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/warning_system.html) before relying on this. The calibration reports list the warning settings found in `project.godot`, so you can see which profile a pass was obtained under.

## 8. Check the toolchain by hand

From the project root, run these once yourself, before involving an agent:

```text
godot --headless -e --quit
godot --headless --check-only -s res://path/to/some_script.gd
godot --headless --path . res://path/to/scene.tscn --quit-after 2
```

The `timeout 20` prefix used in `AGENTS.md` is a POSIX/GNU wrapper that stops a hung command. On Windows, the built-in `timeout` is a different command that only waits, so it will not do this. Use an equivalent or run without a wrapper while you are watching.

Read the output, not only the exit code. In the tested version, some failures printed `SCRIPT ERROR` or `Parse Error` lines and still exited 0. The template's rule is: a nonzero exit, a timeout, or any `SCRIPT ERROR`, `Parse Error` or `ERROR:` line means the check did not pass.

## 9. Calibrate

Run [calibration/TASK.md](../calibration/TASK.md). It uses a small implementation task with a protected specification and test runner, and ends with saved reports. Do this before trusting the setup with anything you care about, and again if you change the agent, model, engine version or instructions.

## 10. A working loop for real tasks

1. **Plan first.** Ask the agent for a plan and read it. In the tested version of the terminal interface, a key toggled between planning and building modes; check yours.
2. **Correct the plan** before any code is written.
3. **Build** a small task.
4. **Verify** with the commands above, and read the output.
5. **Review the diff** (`git add -A && git diff --staged`).
6. **Commit** only what you reviewed.

Two prompts worth keeping:

*Verification-only*, when you want the current state judged and not changed:

> Verify the project as it currently stands using the commands in AGENTS.md. This is a verification-only task: do not edit project source, scenes, settings, or manually alter generated/editor state. Run each applicable check against the unchanged project, even if an earlier check fails, unless continuing would be unsafe. Report each command, its exit code, relevant output, and pass/fail result in the required format. Diagnose failures if useful, but propose repairs rather than applying them. Distinguish observed facts from suspected causes.

*Implementation against fixed tests*: see the prompt in the calibration task.

Without the explicit boundary, an agent asked to "verify" may fix the problem first, which destroys the observation you wanted.

## 11. Your part

The template tells the agent not to launch the game window. Visual and interactive checks are yours: run the scene, then tell the agent what you saw. Headless checks establish that things parse, load and run; they do not establish that the result looks or feels right.

## 12. Known quirks seen while building this

- Pasting multi-line text into a terminal editor lost line breaks in one setup. Writing the file by redirect, or copying a delivered file, avoided it.
- Plain `git diff` ignores untracked files (see section 5).
- An occasional `get_line_wrap_count` out-of-bounds error appeared at the end of the editor/import check in some runs and was absent in later ones. The cause was not established. Do not whitelist it; record it.
- Saving a script in the Godot editor adds a final newline. That is normal text-file behaviour, not an extra blank line of code.
- Headless output contains terminal colour codes. The check scripts strip them from the saved reports; raw output you copy by hand will still contain them.

## 13. Keeping this current

Re-run the calibration after upgrades. When something in this guide is wrong for your version, fix it and record the correction in your own decision log; see [how-to-use-the-logs.md](how-to-use-the-logs.md).
