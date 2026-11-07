#!/usr/bin/env bash
# Calibration check for the OpenCode + Godot guide.
#
# Run from the ROOT of a Godot project that contains experiments/exp_03/
# (see calibration/TASK.md):
#   bash path/to/calibration/check.sh pre    # before the agent works: expects the RED state
#   bash path/to/calibration/check.sh post   # after the agent works: expects the GREEN state
#
# Writes calibration-report-<mode>.md in the current directory.
# Exit codes: 0 = calibration OK, 1 = not OK, 2 = usage error.
# Designed on Linux. macOS and Git Bash on Windows are untested.
# Override the Godot executable with:  GODOT=/path/to/godot bash check.sh pre

MODE="${1:-}"
case "$MODE" in pre|post) ;; *) echo "usage: bash check.sh pre|post" >&2; exit 2 ;; esac

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GODOT_BIN="${GODOT:-godot}"
DIR="experiments/exp_03"
IMPL_RES="res://experiments/exp_03/priority_allocator.gd"
RUNNER_RES="res://experiments/exp_03/test_priority_allocator.gd"
REPORT="calibration-report-${MODE}.md"
LIMIT=20
ESC="$(printf '\033')"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
: > "$TMP/table"; : > "$TMP/details"; : > "$TMP/diag"; : > "$TMP/integrity"; : > "$TMP/scope"
FAILS=0

TMO=()
if command -v timeout >/dev/null 2>&1 && timeout 1 true >/dev/null 2>&1; then
  TMO=(timeout "$LIMIT")
elif command -v gtimeout >/dev/null 2>&1; then
  TMO=(gtimeout "$LIMIT")
fi

diag() { printf -- '- %s\n' "$1" >> "$TMP/diag"; }

hash_file() {
  tr -d '\r' < "$1" | { sha256sum 2>/dev/null || shasum -a 256; } | cut -d' ' -f1
}

run_godot() {
  OUT="$("${TMO[@]}" "$GODOT_BIN" "$@" 2>&1)"
  CODE=$?
  # Remove terminal colour codes so reports are readable and matching is reliable.
  OUT="$(printf '%s\n' "$OUT" | sed "s/${ESC}\[[0-9;]*m//g")"
  ERR="$(printf '%s\n' "$OUT" | grep -E 'SCRIPT ERROR|Parse Error|ERROR:')"
}

classify() {
  [ "$CODE" = 124 ] && diag "FM-02: $1 timed out after ${LIMIT}s."
  [ "$CODE" = 127 ] && diag "FM-01: $1 could not start the Godot executable."
  if [ -n "$ERR" ]; then
    if printf '%s\n' "$ERR" | grep -Eqi 'static type|inferred|Variant|Unsafe|Untyped'; then
      diag "FM-04: $1 reported a strict-typing diagnostic."
    fi
    if printf '%s\n' "$ERR" | grep -q 'Parse Error'; then diag "FM-03: $1 reported a parse error."; fi
    if printf '%s\n' "$ERR" | grep -q 'get_line_wrap_count'; then diag "FM-09: $1 reported the TextEdit get_line_wrap_count diagnostic."; fi
    if ! printf '%s\n' "$ERR" | grep -Eq 'Parse Error|get_line_wrap_count|static type|inferred|Variant|Unsafe|Untyped'; then
      diag "FM-13: $1 reported an engine or script error not matched by a more specific mode."
    fi
  elif [ "$CODE" != 0 ] && [ "$CODE" != 124 ] && [ "$CODE" != 127 ]; then
    diag "FM-14: $1 exited with code $CODE without a recognised error line."
  fi
}

record() { # id title verdict note
  printf '| %s | %s | %s | %s | %s |\n' "$1" "$2" "$CODE" "$3" "$4" >> "$TMP/table"
  [ "$3" = "OK" ] || FAILS=$((FAILS + 1))
  {
    printf '\n### %s - %s\n\n' "$1" "$2"
    printf 'Command: `%s`\n\n' "$CMDSTR"
    printf 'Exit code: %s\n\n```text\n' "$CODE"
    printf '%s\n' "$OUT" | head -n 60
    printf '```\n'
  } >> "$TMP/details"
}

# ---- environment -------------------------------------------------------
if ! command -v "$GODOT_BIN" >/dev/null 2>&1; then
  GODOT_VERSION="NOT FOUND"
else
  GODOT_VERSION="$("${TMO[@]}" "$GODOT_BIN" --version 2>&1 | head -n 1)"
fi
if command -v opencode >/dev/null 2>&1; then
  OPENCODE_VERSION="$(opencode --version 2>&1 | head -n 1)"
else
  OPENCODE_VERSION="not found on PATH (not required by this script)"
fi
OS_INFO="$(uname -srm 2>/dev/null || echo unknown)"
PROFILE="not found (no project.godot in the current directory)"
if [ -f project.godot ]; then
  PROFILE="$(grep -E 'gdscript/warnings/' project.godot)"
  [ -n "$PROFILE" ] || PROFILE="none set (engine defaults apply)"
fi

write_report() {
  RESULT="PASS"; [ "$FAILS" -gt 0 ] && RESULT="FAIL"
  {
    printf '# Calibration report (%s)\n\n' "$MODE"
    printf 'Generated: %s\n\nResult: **%s**\n\n' "$(date -u '+%Y-%m-%d %H:%M:%SZ')" "$RESULT"
    printf '## Environment\n\n- OS: %s\n- Godot: %s\n- OpenCode: %s\n' "$OS_INFO" "$GODOT_VERSION" "$OPENCODE_VERSION"
    printf -- '- Timeout wrapper: %s\n' "${TMO[*]:-none available (hangs will not be stopped)}"
    if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      printf -- '- Git HEAD: %s\n' "$(git rev-parse HEAD 2>/dev/null || echo 'no commits yet')"
    fi
    printf '\nGDScript warning settings in project.godot (anything not listed uses engine defaults):\n\n```text\n%s\n```\n' "$PROFILE"
    printf '\n## Results\n\nExpected state for `%s`: %s\n\n' "$MODE" "$([ "$MODE" = pre ] && echo 'RED (runner fails with named failures, everything else clean)' || echo 'GREEN (all clean, runner prints EXP03_PASS)')"
    printf '| ID | Check | Exit | Verdict | Note |\n|---|---|---|---|---|\n'
    cat "$TMP/table"
    printf '\n## Protected files\n\n'
    cat "$TMP/integrity"
    printf '\n## Diagnosis\n\n'
    if [ -s "$TMP/diag" ]; then cat "$TMP/diag"; printf '\nSee calibration/FAILURE-MODES.md for each FM code. Codes are possible causes, not confirmed ones.\n'; else printf 'No problems detected.\n'; fi
    if [ -s "$TMP/scope" ]; then printf '\n## Files changed outside the expected scope (informational)\n\n```text\n'; cat "$TMP/scope"; printf '```\n'; fi
    printf '\n## Raw output (first 60 lines per command, colour codes removed)\n'
    cat "$TMP/details"
  } > "$REPORT"
}

if [ "$GODOT_VERSION" = "NOT FOUND" ]; then
  diag "FM-01: Godot executable '$GODOT_BIN' not found. Put it on PATH or set GODOT=/path/to/godot."
  FAILS=$((FAILS + 1))
  write_report
  echo "CALIBRATION NOT OK: Godot not found. See $REPORT"
  exit 1
fi

# ---- protected files ---------------------------------------------------
MANIFEST="$SCRIPT_DIR/CHECKSUMS.sha256"
if [ ! -f "$MANIFEST" ]; then
  diag "FM-12: checksum manifest not found at $MANIFEST."
  FAILS=$((FAILS + 1))
else
  while read -r expected name; do
    [ -z "$name" ] && continue
    f="$DIR/$name"
    if [ ! -f "$f" ]; then
      printf -- '- MISSING: %s\n' "$f" >> "$TMP/integrity"
      diag "FM-12: protected file $f is missing; copy the fixture first."
      FAILS=$((FAILS + 1))
    elif [ "$(hash_file "$f")" = "$expected" ]; then
      printf -- '- unchanged: %s\n' "$f" >> "$TMP/integrity"
    else
      printf -- '- MODIFIED: %s\n' "$f" >> "$TMP/integrity"
      diag "FM-06: protected file $f differs from the shipped fixture."
      FAILS=$((FAILS + 1))
    fi
  done < "$MANIFEST"
fi
if [ ! -f "$DIR/priority_allocator.gd" ]; then
  diag "FM-12: $DIR/priority_allocator.gd is missing."
  FAILS=$((FAILS + 1))
fi

# ---- checks ------------------------------------------------------------
CMDSTR="godot --headless -e --quit"
run_godot --headless -e --quit
V=OK; N=""
if [ "$CODE" != 0 ] || [ -n "$ERR" ]; then V=FAIL; N="see diagnosis"; classify "C1"; fi
record C1 "Editor/import" "$V" "$N"

CMDSTR="godot --headless --check-only -s $IMPL_RES"
run_godot --headless --check-only -s "$IMPL_RES"
V=OK; N=""
if [ "$CODE" != 0 ] || [ -n "$ERR" ]; then V=FAIL; N="see diagnosis"; classify "C2"; fi
record C2 "Implementation syntax" "$V" "$N"

CMDSTR="godot --headless --check-only -s $RUNNER_RES"
run_godot --headless --check-only -s "$RUNNER_RES"
V=OK; N=""
if [ "$CODE" != 0 ] || [ -n "$ERR" ]; then V=FAIL; N="see diagnosis"; classify "C3"; fi
record C3 "Runner syntax" "$V" "$N"

CMDSTR="godot --headless --path . --script $RUNNER_RES"
run_godot --headless --path . --script "$RUNNER_RES"
HAS_PASS=0; printf '%s\n' "$OUT" | grep -qx 'EXP03_PASS' && HAS_PASS=1
HAS_FAIL=0; printf '%s\n' "$OUT" | grep -q 'EXP03_FAIL' && HAS_FAIL=1
V=OK; N=""
if [ "$MODE" = pre ]; then
  N="expected: exit 1, named failures, no EXP03_PASS"
  if [ -n "$ERR" ] || [ "$CODE" = 124 ] || [ "$CODE" = 127 ]; then
    V=FAIL; classify "C4"
  elif [ "$HAS_PASS" = 1 ] || [ "$CODE" = 0 ]; then
    V=FAIL; diag "FM-05: the runner passed before any implementation work; the stub was replaced or the runner was changed."
  elif [ "$HAS_FAIL" = 0 ]; then
    V=FAIL; diag "FM-15: the runner exited $CODE but printed no EXP03_FAIL lines, so the red state is not explained."
  fi
else
  N="expected: exit 0, EXP03_PASS, no EXP03_FAIL"
  if [ -n "$ERR" ] || [ "$CODE" = 124 ] || [ "$CODE" = 127 ]; then
    V=FAIL; classify "C4"
  elif [ "$HAS_FAIL" = 1 ]; then
    V=FAIL; diag "FM-08: the runner reported failing cases; the implementation does not meet the specification."
    printf '%s\n' "$OUT" | grep 'EXP03_FAIL' | head -n 10 | while read -r line; do diag "  $line"; done
  elif [ "$CODE" != 0 ] || [ "$HAS_PASS" = 0 ]; then
    V=FAIL; diag "FM-07: exit code $CODE and EXP03_PASS present=$HAS_PASS; success requires exit 0 and the token together."
  fi
fi
record C4 "Test runner" "$V" "$N"

# ---- scope (informational) ---------------------------------------------
if [ "$MODE" = post ] && command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git status --porcelain 2>/dev/null | grep -Ev ' experiments/exp_03/(priority_allocator\.gd(\.uid)?|test_priority_allocator\.gd\.uid)$|calibration-report-|calibration-notes|calibration/|\.godot/' > "$TMP/scope"
  if [ -s "$TMP/scope" ]; then diag "FM-10 (warning only): files outside the implementation changed since the last commit; check they were intended."; fi
fi

write_report
if [ "$FAILS" -eq 0 ]; then
  echo "CALIBRATION OK ($MODE). Report: $REPORT"
  exit 0
else
  echo "CALIBRATION NOT OK ($MODE). Report: $REPORT"
  exit 1
fi
