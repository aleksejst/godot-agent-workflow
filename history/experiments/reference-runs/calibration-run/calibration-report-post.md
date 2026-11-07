# Calibration report (post)

Generated: 2026-11-07 11:45:57Z

Result: **PASS**

## Environment

- OS: Linux 7.0.13-1-MANJARO x86_64
- Godot: 4.6.3.stable.arch_linux.35e80b3a8
- OpenCode: opencode v2.0.24
- Timeout wrapper: timeout 20
- Git HEAD: 1799a49bc04a43ee374311d226a48e7770dfa606

## Results

Expected state for `post`: GREEN (all clean, runner prints EXP03_PASS)

| ID | Check | Exit | Verdict | Note |
|---|---|---|---|---|
| C1 | Editor/import | 0 | OK |  |
| C2 | Implementation syntax | 0 | OK |  |
| C3 | Runner syntax | 0 | OK |  |
| C4 | Test runner | 0 | OK | expected: exit 0, EXP03_PASS, no EXP03_FAIL |

## Protected files

- unchanged: experiments/exp_03/SPEC.md
- unchanged: experiments/exp_03/test_priority_allocator.gd

## Diagnosis

No problems detected.

## Raw output (first 60 lines per command)

### C1 - Editor/import

Command: `godot --headless -e --quit`

Exit code: 0

```text
Godot Engine v4.6.3.stable.arch_linux.35e80b3a8 (2026-05-20 13:47:53 UTC) - https://godotengine.org

[   0% ] [90m[1mfirst_scan_filesystem[22m | Started Project initialization (5 steps)[39m[0m
[   0% ] [90m[1mfirst_scan_filesystem[22m | Scanning file structure...[39m[0m
[  16% ] [90m[1mfirst_scan_filesystem[22m | Loading global class names...[39m[0m
[  33% ] [90m[1mfirst_scan_filesystem[22m | Verifying GDExtensions...[39m[0m
[  50% ] [90m[1mfirst_scan_filesystem[22m | Creating autoload scripts...[39m[0m
[  66% ] [90m[1mfirst_scan_filesystem[22m | Initializing plugins...[39m[0m
[  83% ] [90m[1mfirst_scan_filesystem[22m | Starting file scan...[39m[0m
[92m[ DONE ][39m [1mfirst_scan_filesystem[22m
[0m
[   0% ] [90m[1mloading_editor_layout[22m | Started Loading editor (5 steps)[39m[0m
[   0% ] [90m[1mloading_editor_layout[22m | Loading editor layout...[39m[0m
[  16% ] [90m[1mloading_editor_layout[22m | Loading docks...[39m[0m
[92m[ DONE ][39m [1mloading_editor_layout[22m
[0m
```

### C2 - Implementation syntax

Command: `godot --headless --check-only -s res://experiments/exp_03/priority_allocator.gd`

Exit code: 0

```text
Godot Engine v4.6.3.stable.arch_linux.35e80b3a8 (2026-05-20 13:47:53 UTC) - https://godotengine.org
```

### C3 - Runner syntax

Command: `godot --headless --check-only -s res://experiments/exp_03/test_priority_allocator.gd`

Exit code: 0

```text
Godot Engine v4.6.3.stable.arch_linux.35e80b3a8 (2026-05-20 13:47:53 UTC) - https://godotengine.org
```

### C4 - Test runner

Command: `godot --headless --path . --script res://experiments/exp_03/test_priority_allocator.gd`

Exit code: 0

```text
Godot Engine v4.6.3.stable.arch_linux.35e80b3a8 (2026-05-20 13:47:53 UTC) - https://godotengine.org

case 'Empty': pass
case 'Zero supply': pass
case 'Exact supply': pass
case 'Short supply': pass
case 'First request exhausts supply': pass
case 'Excess supply': pass
case 'Zero-valued requests': pass
case 'All zero': pass
EXP03 summary: 8 case(s) passed, 0 case(s) failed, 0 failing check(s), 0 fixture error(s)
EXP03_PASS
```
