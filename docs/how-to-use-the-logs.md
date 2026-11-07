# How to use the logs

The `history/` folder records how the template was built. You do not need it to use the template. You need it if you want to know why a rule exists, what was tried first, or how confident to be.

## The documents and their jobs

| Document | Answers |
|---|---|
| `AGENTS.md` (root) | What should the agent do now? |
| `history/experiments/` cards | What was run, what was observed, and what did it fail to show? |
| `history/decision-log.md` | What was decided, why, what was rejected, and when to revisit? |
| `history/discovery-log.md` | What surprised us or overturned an assumption? |
| `examples/AGENTS.scaffold.md` | What did the instructions look like when the experiments ran? |

A discovery may motivate a decision without being one. A decision may change `AGENTS.md`. Cards hold evidence; they should not carry policy.

## Identifiers and statuses

- Decisions are `D-nnn`; discoveries are `DISC-nnn`; experiments are `EXP-nn`; the fault-ladder rounds are `R01` to `R05` within `EXP-02`.
- Decision statuses: Adopted, Proposed, Experimental, Deferred, Superseded, Unresolved. Qualifiers after the status say what is and is not established, for example that a generated file was delivered but not confirmed installed.
- Superseded entries are kept on purpose. They explain why something was *not* done.

## Reading order

1. The EXP-01 card, for the pipeline and the first surprises.
2. The EXP-02 summary card, for the fault ladder.
3. The EXP-03 card and setup plan, for the implementation test.
4. The decision log index, then any entry that interests you.
5. The discovery log's "unresolved tensions" section.
6. `history/experiments/reference-runs/` for what saved output from the calibration task and the check scripts looks like.

## Cautions

- Most log entries were reconstructed from conversation and transcripts after the fact, not written live. Each says so.
- Evidence is user-supplied transcripts and reports. The cards say where output was truncated or where nothing was independently re-run.
- Predictions are marked as written beforehand or reconstructed. Do not treat a reconstructed prediction as a pre-registered one.
- One operator, one agent and model combination, one engine version. See the README's status table.
- Some entries name fixtures and file names from the original working repository, such as `hello.gd` or `experiments/exp_03/`. The calibration fixture keeps those names so that the shipped files match what was tested.
- The logs were written before the calibration task and its scripts existed, so they do not describe them.

## Keeping your own logs

Each log has a template at its end. Practical habits that worked:

- Write the hypothesis, and what would surprise you, *before* a run.
- Append; do not rewrite. When a decision changes, mark the old one Superseded and link the new one.
- Separate "generated" from "installed" from "verified".
- Log corrections to your own advice, not only the agent's mistakes.
- Do not run an experiment unless its result could change a decision.
