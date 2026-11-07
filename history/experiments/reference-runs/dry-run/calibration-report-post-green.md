# Calibration report (post)

Generated: 2026-11-07 13:05:03Z

Result: **PASS**

## Environment

- OS: Linux 7.0.13-1-MANJARO x86_64
- Godot: 4.6.3.stable.arch_linux.35e80b3a8
- OpenCode: opencode v2.0.24
- Timeout wrapper: timeout 20
- Git HEAD: 717b80fe03f315186ad30d024fd1ab6a00f7492e

GDScript warning settings in project.godot (anything not listed uses engine defaults):

```text
none set (engine defaults apply)
```

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

## Raw output (first 60 lines per command, colour codes removed)

### C1 - Editor/import

Command: `godot --headless -e --quit`

Exit code: 0

```text
Godot Engine v4.6.3.stable.arch_linux.35e80b3a8 (2026-05-20 13:47:53 UTC) - https://godotengine.org

[   0% ] first_scan_filesystem | Started Project initialization (5 steps)
[   0% ] first_scan_filesystem | Scanning file structure...
[  16% ] first_scan_filesystem | Loading global class names...
[  33% ] first_scan_filesystem | Verifying GDExtensions...
[  50% ] first_scan_filesystem | Creating autoload scripts...
[  66% ] first_scan_filesystem | Initializing plugins...
[  83% ] first_scan_filesystem | Starting file scan...
[ DONE ] first_scan_filesystem

[   0% ] update_scripts_classes | Started Registering global classes... (2 steps)
[   0% ] update_scripts_classes | 
[  33% ] update_scripts_classes | 
[ DONE ] update_scripts_classes

[   0% ] loading_editor_layout | Started Loading editor (5 steps)
[   0% ] loading_editor_layout | Loading editor layout...
[  16% ] loading_editor_layout | Loading docks...
[ DONE ] loading_editor_layout
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
