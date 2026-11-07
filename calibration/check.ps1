<#
.SYNOPSIS
  Calibration check for the OpenCode + Godot guide (PowerShell version).

.DESCRIPTION
  DISCLAIMER: This script has NOT been tested in a real Windows environment.
  It mirrors calibration/check.sh (which has been run on Linux only). If it
  misbehaves, treat that as a bug in the script, not as a finding about your
  setup, and run the commands from calibration/TASK.md by hand instead.

  Run from the ROOT of a Godot project that contains experiments/exp_03/:
    pwsh -File path\to\calibration\check.ps1 pre     # before the agent works: expects RED
    pwsh -File path\to\calibration\check.ps1 post    # after the agent works: expects GREEN
  (Windows PowerShell 5.1: replace pwsh with powershell.)

  Writes calibration-report-<mode>.md in the current directory.
  Exit codes: 0 = calibration OK, 1 = not OK.

  Set $env:GODOT to the full path of the Godot executable if `godot` is not on PATH.
  On Windows, use the console build of Godot if you have one, so that output can be captured.
#>
param(
  [Parameter(Mandatory = $true, Position = 0)]
  [ValidateSet('pre', 'post')]
  [string]$Mode
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$GodotName = if ($env:GODOT) { $env:GODOT } else { 'godot' }
$Dir = 'experiments/exp_03'
$ImplRes = 'res://experiments/exp_03/priority_allocator.gd'
$RunnerRes = 'res://experiments/exp_03/test_priority_allocator.gd'
$Report = "calibration-report-$Mode.md"
$LimitSeconds = 20

$script:Fails = 0
$script:Diag = New-Object System.Collections.Generic.List[string]
$script:Integrity = New-Object System.Collections.Generic.List[string]
$script:Table = New-Object System.Collections.Generic.List[string]
$script:Details = New-Object System.Collections.Generic.List[string]

function Add-Diag([string]$Text) { $script:Diag.Add("- $Text") }

function Get-NormalizedHash([string]$Path) {
  $text = [System.IO.File]::ReadAllText($Path) -replace "`r`n", "`n"
  $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
  $sha = [System.Security.Cryptography.SHA256]::Create()
  return (($sha.ComputeHash($bytes) | ForEach-Object { $_.ToString('x2') }) -join '')
}

function Invoke-Limited([string]$Exe, [string[]]$Arguments, [int]$Seconds) {
  $outFile = [System.IO.Path]::GetTempFileName()
  $errFile = [System.IO.Path]::GetTempFileName()
  $code = 0
  try {
    $p = Start-Process -FilePath $Exe -ArgumentList $Arguments -NoNewWindow -PassThru `
      -RedirectStandardOutput $outFile -RedirectStandardError $errFile
    if (-not $p.WaitForExit($Seconds * 1000)) {
      try { $p.Kill() } catch { }
      $code = 124
    } else {
      $p.WaitForExit()
      $code = $p.ExitCode
    }
    $o = Get-Content -Raw -ErrorAction SilentlyContinue $outFile
    $e = Get-Content -Raw -ErrorAction SilentlyContinue $errFile
    # Remove terminal colour codes so reports are readable and matching is reliable.
    $text = [regex]::Replace("$o$e", '\x1b\[[0-9;]*m', '')
  } catch {
    $code = 127
    $text = "Could not start '$Exe': $($_.Exception.Message)"
  } finally {
    Remove-Item -ErrorAction SilentlyContinue $outFile, $errFile
  }
  return [pscustomobject]@{ Code = $code; Text = $text }
}

function Get-ErrLines([string]$Text) {
  return (($Text -split "`r?`n") | Where-Object { $_ -match 'SCRIPT ERROR|Parse Error|ERROR:' }) -join "`n"
}

function Add-Classification([string]$Id, [int]$Code, [string]$Err) {
  if ($Code -eq 124) { Add-Diag "FM-02: $Id timed out after ${LimitSeconds}s." }
  if ($Code -eq 127) { Add-Diag "FM-01: $Id could not start the Godot executable." }
  if ($Err) {
    if ($Err -match 'static type|inferred|Variant|Unsafe|Untyped') { Add-Diag "FM-04: $Id reported a strict-typing diagnostic." }
    if ($Err -match 'Parse Error') { Add-Diag "FM-03: $Id reported a parse error." }
    if ($Err -match 'get_line_wrap_count') { Add-Diag "FM-09: $Id reported the TextEdit get_line_wrap_count diagnostic." }
    if ($Err -notmatch 'Parse Error|get_line_wrap_count|static type|inferred|Variant|Unsafe|Untyped') {
      Add-Diag "FM-13: $Id reported an engine or script error not matched by a more specific mode."
    }
  } elseif ($Code -ne 0 -and $Code -ne 124 -and $Code -ne 127) {
    Add-Diag "FM-14: $Id exited with code $Code without a recognised error line."
  }
}

function Add-Record([string]$Id, [string]$Title, $Result, [string]$Verdict, [string]$Note, [string]$CmdStr) {
  $script:Table.Add("| $Id | $Title | $($Result.Code) | $Verdict | $Note |")
  if ($Verdict -ne 'OK') { $script:Fails++ }
  $lines = (($Result.Text -split "`r?`n") | Select-Object -First 60) -join "`n"
  $script:Details.Add("`n### $Id - $Title`n`nCommand: ``$CmdStr```n`nExit code: $($Result.Code)`n`n``````text`n$lines`n```````n")
}

function Write-Report([string]$GodotVersion, [string]$OpenCodeVersion) {
  $result = if ($script:Fails -gt 0) { 'FAIL' } else { 'PASS' }
  $expected = if ($Mode -eq 'pre') { 'RED (runner fails with named failures, everything else clean)' } else { 'GREEN (all clean, runner prints EXP03_PASS)' }
  $os = [System.Environment]::OSVersion.VersionString
  $warnProfile = 'not found (no project.godot in the current directory)'
  if (Test-Path 'project.godot') {
    $found = Select-String -Path 'project.godot' -Pattern 'gdscript/warnings/' | ForEach-Object { $_.Line }
    $warnProfile = if ($found) { $found -join "`n" } else { 'none set (engine defaults apply)' }
  }
  $out = New-Object System.Collections.Generic.List[string]
  $out.Add("# Calibration report ($Mode)")
  $out.Add('')
  $out.Add("Generated: $((Get-Date).ToUniversalTime().ToString('yyyy-MM-dd HH:mm:ss'))Z")
  $out.Add('')
  $out.Add("Result: **$result**")
  $out.Add('')
  $out.Add('Note: produced by the untested PowerShell script.')
  $out.Add('')
  $out.Add('## Environment')
  $out.Add('')
  $out.Add("- OS: $os")
  $out.Add("- Godot: $GodotVersion")
  $out.Add("- OpenCode: $OpenCodeVersion")
  $out.Add('')
  $out.Add('GDScript warning settings in project.godot (anything not listed uses engine defaults):')
  $out.Add('')
  $out.Add('```text')
  $out.Add($warnProfile)
  $out.Add('```')
  $out.Add('')
  $out.Add('## Results')
  $out.Add('')
  $out.Add("Expected state for ``$Mode``: $expected")
  $out.Add('')
  $out.Add('| ID | Check | Exit | Verdict | Note |')
  $out.Add('|---|---|---|---|---|')
  $script:Table | ForEach-Object { $out.Add($_) }
  $out.Add('')
  $out.Add('## Protected files')
  $out.Add('')
  $script:Integrity | ForEach-Object { $out.Add($_) }
  $out.Add('')
  $out.Add('## Diagnosis')
  $out.Add('')
  if ($script:Diag.Count -gt 0) {
    $script:Diag | ForEach-Object { $out.Add($_) }
    $out.Add('')
    $out.Add('See calibration/FAILURE-MODES.md for each FM code. Codes are possible causes, not confirmed ones.')
  } else {
    $out.Add('No problems detected.')
  }
  $out.Add('')
  $out.Add('## Raw output (first 60 lines per command, colour codes removed)')
  $script:Details | ForEach-Object { $out.Add($_) }
  Set-Content -Path $Report -Value $out -Encoding UTF8
}

# ---- environment ---------------------------------------------------------
$godotCmd = Get-Command $GodotName -ErrorAction SilentlyContinue
$GodotExe = $null
if ($godotCmd) { $GodotExe = $godotCmd.Source }
$opencodeCmd = Get-Command opencode -ErrorAction SilentlyContinue
$OpenCodeVersion = 'not found on PATH (not required by this script)'
if ($opencodeCmd) {
  try { $OpenCodeVersion = (& opencode --version 2>&1 | Select-Object -First 1) } catch { $OpenCodeVersion = 'present but --version failed' }
}

if (-not $GodotExe) {
  Add-Diag "FM-01: Godot executable '$GodotName' not found. Put it on PATH or set `$env:GODOT to its full path."
  $script:Fails++
  Write-Report 'NOT FOUND' $OpenCodeVersion
  Write-Host "CALIBRATION NOT OK: Godot not found. See $Report"
  exit 1
}
$GodotVersion = (Invoke-Limited $GodotExe @('--version') 10).Text.Trim()

# ---- protected files ------------------------------------------------------
$manifest = Join-Path $ScriptDir 'CHECKSUMS.sha256'
if (-not (Test-Path $manifest)) {
  Add-Diag "FM-12: checksum manifest not found at $manifest."
  $script:Fails++
} else {
  foreach ($line in (Get-Content $manifest)) {
    if (-not $line.Trim()) { continue }
    $parts = $line -split '\s+', 2
    $expected = $parts[0]; $name = $parts[1]
    $f = "$Dir/$name"
    if (-not (Test-Path $f)) {
      $script:Integrity.Add("- MISSING: $f")
      Add-Diag "FM-12: protected file $f is missing; copy the fixture first."
      $script:Fails++
    } elseif ((Get-NormalizedHash $f) -eq $expected) {
      $script:Integrity.Add("- unchanged: $f")
    } else {
      $script:Integrity.Add("- MODIFIED: $f")
      Add-Diag "FM-06: protected file $f differs from the shipped fixture."
      $script:Fails++
    }
  }
}
if (-not (Test-Path "$Dir/priority_allocator.gd")) {
  Add-Diag "FM-12: $Dir/priority_allocator.gd is missing."
  $script:Fails++
}

# ---- checks ----------------------------------------------------------------
function Test-Simple([string]$Id, [string]$Title, [string[]]$GodotArgs, [string]$CmdStr) {
  $r = Invoke-Limited $GodotExe $GodotArgs $LimitSeconds
  $err = Get-ErrLines $r.Text
  $verdict = 'OK'; $note = ''
  if ($r.Code -ne 0 -or $err) { $verdict = 'FAIL'; $note = 'see diagnosis'; Add-Classification $Id $r.Code $err }
  Add-Record $Id $Title $r $verdict $note $CmdStr
}

Test-Simple 'C1' 'Editor/import' @('--headless', '-e', '--quit') 'godot --headless -e --quit'
Test-Simple 'C2' 'Implementation syntax' @('--headless', '--check-only', '-s', $ImplRes) "godot --headless --check-only -s $ImplRes"
Test-Simple 'C3' 'Runner syntax' @('--headless', '--check-only', '-s', $RunnerRes) "godot --headless --check-only -s $RunnerRes"

$r4 = Invoke-Limited $GodotExe @('--headless', '--path', '.', '--script', $RunnerRes) $LimitSeconds
$err4 = Get-ErrLines $r4.Text
$hasPass = [bool](($r4.Text -split "`r?`n") | Where-Object { $_.Trim() -eq 'EXP03_PASS' })
$hasFail = $r4.Text -match 'EXP03_FAIL'
$verdict = 'OK'
if ($Mode -eq 'pre') {
  $note = 'expected: exit 1, named failures, no EXP03_PASS'
  if ($err4 -or $r4.Code -eq 124 -or $r4.Code -eq 127) {
    $verdict = 'FAIL'; Add-Classification 'C4' $r4.Code $err4
  } elseif ($hasPass -or $r4.Code -eq 0) {
    $verdict = 'FAIL'; Add-Diag 'FM-05: the runner passed before any implementation work; the stub was replaced or the runner was changed.'
  } elseif (-not $hasFail) {
    $verdict = 'FAIL'; Add-Diag "FM-15: the runner exited $($r4.Code) but printed no EXP03_FAIL lines, so the red state is not explained."
  }
} else {
  $note = 'expected: exit 0, EXP03_PASS, no EXP03_FAIL'
  if ($err4 -or $r4.Code -eq 124 -or $r4.Code -eq 127) {
    $verdict = 'FAIL'; Add-Classification 'C4' $r4.Code $err4
  } elseif ($hasFail) {
    $verdict = 'FAIL'; Add-Diag 'FM-08: the runner reported failing cases; the implementation does not meet the specification.'
    (($r4.Text -split "`r?`n") | Where-Object { $_ -match 'EXP03_FAIL' } | Select-Object -First 10) | ForEach-Object { Add-Diag "  $_" }
  } elseif ($r4.Code -ne 0 -or -not $hasPass) {
    $verdict = 'FAIL'; Add-Diag "FM-07: exit code $($r4.Code) and EXP03_PASS present=$hasPass; success requires exit 0 and the token together."
  }
}
Add-Record 'C4' 'Test runner' $r4 $verdict $note "godot --headless --path . --script $RunnerRes"

Write-Report $GodotVersion $OpenCodeVersion
if ($script:Fails -eq 0) {
  Write-Host "CALIBRATION OK ($Mode). Report: $Report"
  exit 0
} else {
  Write-Host "CALIBRATION NOT OK ($Mode). Report: $Report"
  exit 1
}
