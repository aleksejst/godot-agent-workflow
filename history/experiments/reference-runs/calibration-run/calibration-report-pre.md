# Calibration report (pre)

Generated: 2026-11-07 11:44:54Z

Result: **PASS**

## Environment

- OS: Linux 7.0.13-1-MANJARO x86_64
- Godot: 4.6.3.stable.arch_linux.35e80b3a8
- OpenCode: opencode v2.0.24
- Timeout wrapper: timeout 20
- Git HEAD: 857522f37521147da654cbe0bba18c2e150e0ace

## Results

Expected state for `pre`: RED (runner fails with named failures, everything else clean)

| ID | Check | Exit | Verdict | Note |
|---|---|---|---|---|
| C1 | Editor/import | 0 | OK |  |
| C2 | Implementation syntax | 0 | OK |  |
| C3 | Runner syntax | 0 | OK |  |
| C4 | Test runner | 1 | OK | expected: exit 1, named failures, no EXP03_PASS |

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
[   0% ] [90m[1mupdate_scripts_classes[22m | Started Registering global classes... (2 steps)[39m[0m
[   0% ] [90m[1mupdate_scripts_classes[22m | [39m[0m
[  33% ] [90m[1mupdate_scripts_classes[22m | [39m[0m
[92m[ DONE ][39m [1mupdate_scripts_classes[22m
[0m
[   0% ] [90m[1mreimport[22m | Started (Re)Importing Assets (1 steps)[39m[0m
[   0% ] [90m[1mreimport[22m | Preparing files to reimport...[39m[0m
[   0% ] [90m[1mreimport[22m | Executing pre-reimport operations...[39m[0m
[   0% ] [90m[1mreimport[22m | icon.svg[39m[0m
[  50% ] [90m[1mreimport[22m | Finalizing Asset Import...[39m[0m
[92m[ DONE ][39m [1mreimport[22m
[0m
[   0% ] [90m[1mreimport[22m | Started (Re)Importing Assets (1 steps)[39m[0m
[   0% ] [90m[1mreimport[22m | Executing post-reimport operations...[39m[0m
[92m[ DONE ][39m [1mreimport[22m
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

Exit code: 1

```text
Godot Engine v4.6.3.stable.arch_linux.35e80b3a8 (2026-05-20 13:47:53 UTC) - https://godotengine.org

case 'Empty': pass
EXP03_FAIL [Zero supply] expected 2 allocations, got 0
EXP03_FAIL [Exact supply] expected 2 allocations, got 0
EXP03_FAIL [Short supply] expected 2 allocations, got 0
EXP03_FAIL [First request exhausts supply] expected 2 allocations, got 0
EXP03_FAIL [Excess supply] expected 2 allocations, got 0
EXP03_FAIL [Zero-valued requests] expected 4 allocations, got 0
EXP03_FAIL [All zero] expected 2 allocations, got 0
EXP03 summary: 1 case(s) passed, 7 case(s) failed, 7 failing check(s), 0 fixture error(s)
```
