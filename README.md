# Agent-driven Godot development: a worked setup, a calibration task, and the record behind it

This repository packages a small, documented workflow for developing Godot 4 projects with a terminal coding agent (OpenCode), plus the experiments that shaped it. It contains:

- a reusable `AGENTS.md` template (the main output);
- a tool-agnostic setup guide from installation to a first agent-driven project;
- a calibration task you can run to check that your own setup behaves as intended, and to leave a saved diagnostic if it does not;
- the decision log, discovery log and experiment cards that explain why the template says what it says.

## Status and evidence (read this first)

This is a worked record from one operator, not a benchmark.

| Aspect | What was actually exercised |
|---|---|
| Operator | One person, with a human-and-AI review loop |
| Agent tool | OpenCode 2.0.24 |
| Engine | Godot 4.6.3 (stable) |
| Operating system | Linux (Manjaro, X11) |
| Windows | Documented, **not tested** |
| macOS | Not tested; the guide stays tool- and OS-agnostic |
| Experiments | Three: a pipeline check, a five-round fault ladder, and one implementation task against fixed tests |
| Calibration task | Run once end to end on Linux in a fresh sandbox project, and passed. That run was orchestrated by an agent and not by a human operator, so it shows the task and scripts work, not that the protocol is robust. Reports from that run are in [history/experiments/reference-runs/](history/experiments/reference-runs/). |

A "PASS" in a card or report means the stated checks passed in that run, on that setup. It does not show that the template makes agents reliable in general. The cards list what each run did not establish; the logs record corrections, including mistakes made while designing the experiments.

## Quick start

1. Read [docs/setup-opencode-godot.md](docs/setup-opencode-godot.md) and install both tools by following their official documentation. The guide describes the goal state and how to verify it, and deliberately avoids copying install commands that may go stale.
2. Create your Godot project, initialise Git, and make a baseline commit.
3. Copy [AGENTS.md](AGENTS.md) into your project root. Edit section 3 to your own conventions and fill in section 4 for your repository. Then delete the "Template status" section.
4. Run the calibration in [calibration/TASK.md](calibration/TASK.md). It takes about half an hour and ends with saved reports.
5. Start real work using the workflow in the guide.

## Repository map

```text
README.md                         this file
AGENTS.md                         reusable template (copy into your project)
LICENSE                           BSD Zero Clause License
docs/
  setup-opencode-godot.md         install, connect, first project, workflow
  tests-pattern.md                the protected spec / runner / stub pattern
  how-to-use-the-logs.md          how to read and maintain the history files
calibration/
  TASK.md                         step-by-step calibration task
  FAILURE-MODES.md                symptom -> possible cause -> what to try
  check.sh, check.ps1             write a diagnostic report (see platform notes)
  CHECKSUMS.sha256                integrity manifest for the protected fixture files
  fixture/                        spec, test runner and stub for the task
examples/
  AGENTS.scaffold.md              the file as it ran in the experiments
history/
  decision-log.md                 decisions, motivations, alternatives, limits
  discovery-log.md                surprises and corrected assumptions
  experiments/                    experiment cards and the EXP-03 setup plan
  experiments/reference-runs/     saved calibration-run and dry-run reports
```

## Reading paths

- **I want to use this.** Follow the quick start. You can ignore `history/` until you wonder why a rule exists.
- **I want to know why.** Start with [docs/how-to-use-the-logs.md](docs/how-to-use-the-logs.md), then the decision log.
- **I want to adapt it.** Read the four-layer structure of `AGENTS.md`: general policy, Godot-specific policy, chosen conventions, project context. The first two are meant to be reused as written. The third is a set of choices you should replace with your own.

## Platform notes

- The documents are written to be OS-agnostic. Installation steps are intentionally abstract.
- `calibration/check.sh` was developed on Linux and has been run in one full calibration and in a dry run under both the default and a strict warning profile, all on Linux with Godot 4.6.3 (see [history/experiments/reference-runs/](history/experiments/reference-runs/)). `calibration/check.ps1` mirrors it for Windows PowerShell and has **not** been run on Windows. Both have a manual fallback in the task file.
- Several commands in the template use the POSIX `timeout` wrapper. See the guide for what to do where it is unavailable.

## What this is not

- Not a claim that strict typing or any particular rule is best for everyone.
- Not a replacement for the official documentation of either tool.
- Not a general evaluation of any model or agent.

## Licence

Released under the [BSD Zero Clause License](LICENSE): use, copy, modify and distribute freely, with no attribution required.
