# Experiment Completion Card — EXP-01: Godot Hello World via OpenCode

**Date:** 2026-11-04
**Project:** Godot agent tooling pipeline (Stage A)
**Domain (Cynefin):** Complicated (tooling) — aim: known good path, not discovery
**Status:** PASS (pipeline works end to end). Items marked [CONFIRM] need your entry.

---

## 1. Setup

| Item | Value |
|---|---|
| OS / WM | Manjaro Linux, i3 (X11) |
| Godot | 4.6.3.stable (arch_linux build), `godot` on PATH |
| Agent | OpenCode v2.0.24 (pacman, Manjaro `extra`) |
| Provider / model | OpenCode Go (plan price omitted for publication), GLM-5.3-Flash |
| Clipboard helper | xclip (X11) |
| Project path | <project-path> |
| Renderer | Forward+ (default kept) |
| Git | `git init` run manually (Godot's "Git" metadata option only wrote `.gitignore` / `.gitattributes`) |

## 2. Hypothesis

None was written down beforehand. **Process gap** — for EXP-02 onward, write one sentence and one "what would surprise me" before running.

## 3. What was done

1. Created Godot project; confirmed `.gitignore` ignores `.godot/` and `/android/` and does NOT ignore `*.uid`.
2. `/init` generated `AGENTS.md`; replaced it with a hand-reviewed version (see section 6).
3. Agent worked in Plan mode first; plan was reviewed and corrected twice before Build.
4. Agent created `hello.tscn` (Label root, text "hello") and `hello.gd` (typed GDScript, prints in `_ready`).
5. Agent ran syntax check and headless scene run; reported with Done / Could not verify headings.

## 4. Results

| Check | Command | Result |
|---|---|---|
| Syntax check | `godot --headless --check-only -s res://hello.gd` | Exit 0; empty output apart from engine banner. `res://` path form works. |
| Headless scene run | `timeout 20 godot --headless --path . res://hello.tscn --quit-after 2` | Exited on its own within timeout (exit 0); log contains `hello from hello.gd`; no `SCRIPT ERROR` / `Parse Error`. |
| Success rule | Print line present AND no error lines (exit code not trusted) | Both halves passed. |
| Rendering | User ran scene in editor | [CONFIRM] Label displayed "hello": yes / no |
| Sidecar file | `hello.gd.uid` | Appeared after the USER ran the scene in the editor, not during the agent's run. Commit it. |
| Commit | `git add -A && git commit` | [CONFIRM] done: yes / no |

## 5. Verified vs not verified

- **Verified by command output:** syntax check passes; scene loads headless; script prints expected line; no script errors in log.
- **Not verified by the agent (by design):** that the Label renders visibly — only the user can confirm.
- **Agent's report quality:** named its own stubs, separated observation from inference, did not claim anything it hadn't run in this task.

## 6. Findings and surprises

1. **Generated AGENTS.md contained false claims.** It listed Jolt Physics and the D3D12 driver as "non-default settings — don't fix back"; both are the Godot 4.6 defaults for new projects (Jolt is 3D-only, irrelevant to a 2D game). It also stated "everything is now verified" after running one of four listed commands. Fix: section removed; rule added that "verified" is only for commands actually run.
2. **Clipboard to nano lost line breaks.** The clipboard itself was intact (`xclip -o -selection clipboard | wc -l` gave 14). Workaround: `{ xclip -o -selection clipboard; echo; } > AGENTS.md`.
3. **`git diff` shows nothing for untracked files.** A baseline commit is needed first; after agent work use `git add -A && git diff --staged`.
4. **Exit codes cannot be trusted alone.** Documented Godot 4 headless failure mode: some failures exit 0. Judge by log content plus expected output line.
5. **OpenCode v2 compatibility:** every v1-documented command used (`/connect`, `/models`, `/init`, Tab for Plan/Build, `/undo`, `/redo`) behaved as described.
6. **Correction of my earlier criticism:** I suggested the agent's report missed the `.uid` file. The file was created later by the user's own editor run, so the agent could not have reported it. No gap there.

## 7. Allowance and cost data

| Reading | Value |
|---|---|
| Console Go page, after experiment | (omitted for publication) |
| OpenCode context counter after `/init` | about (omitted for publication) tokens (earlier fresh session: (omitted for publication)) |
| Interpretation | Usage on this scale is below the displayed resolution (whole percent, or delayed). The countdowns suggest the windows are open. This is an inference, not confirmed. |
| Implication | Allowance is not a constraint at this scale. Rotation plan should be driven by quality; a shared-vs-separate meter test needs heavier sessions. |

Note: GLM-5.3-Flash is a paid Go model (listed with a (omitted for publication) monthly limit); the free Go model is Beam Free. Being at 0% does not mean you are on a free model.

## 8. Challenge ledger

| Challenge | Status |
|---|---|
| Agent may report success on unverified shortcuts | Partly addressed: honest on a trivial task. Reopen for EXP-03/04 and the first simulation probe. |
| Risk of testing tooling for its own sake | Open: cap series at five experiments; stop when EXP-01 to EXP-03 pass. |

## 9. Decisions and standing state

- `AGENTS.md` v1 in place: Godot 4.6, 2D only, typed GDScript, report Done / Could not verify, never launch game window, keep `*.uid`, never push or rewrite history, two commands listed (import validation verified; syntax check now verified).
- **To update:** mark the syntax-check command as verified in `AGENTS.md`; add the log-not-exit-code success rule and the headless scene-run command with `--quit-after`.
- Free-model list from console: Beam Free is the only usable free model (Iceman and all Contributor models disabled).
- Open question: do Go per-model allowances share one weighted meter? Untested.

## 10. Session reflection (AI, offered for the shared log)

- **What landed:** plan-first workflow; log-based success criterion; honest reporting format.
- **What did not land, and why:** a hypothesis was never written; the allowance meter produced no signal (resolution too coarse); my git-diff instruction was wrong until corrected.
- **Gaps:** no test yet of error detection (EXP-02), failing tests (EXP-03), or rollback (EXP-05); skill file not started.
- **Suggested next probe:** EXP-02 — plant a syntax error yourself and ask the agent to find and fix it using only the parse check. Hypothesis to write first: "the agent runs the check unprompted and fixes it without my pasting the error."

## 11. Discovery log line

> EXP-01 PASS: OpenCode v2 + GLM-5.3-Flash edited, syntax-checked and headless-ran a Godot 4.6.3 scene; surprises were a generated AGENTS.md with confidently wrong "non-default settings" and nano dropping pasted line breaks.
