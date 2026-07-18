param(
  [string]$CodexHome
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Resolve-Path (Join-Path $ScriptDir "..")
$Source = Join-Path $RepoRoot "skills\codex-self-optimizer"

if (-not (Test-Path -LiteralPath $Source)) {
  throw "Skill source not found: $Source"
}

if (-not $CodexHome) {
  if ($env:CODEX_HOME) {
    $CodexHome = $env:CODEX_HOME
  } else {
    $CodexHome = Join-Path $HOME ".codex"
  }
}

$TargetRoot = Join-Path $CodexHome "skills"
$Target = Join-Path $TargetRoot "codex-self-optimizer"
$BackupRoot = Join-Path $CodexHome "skill-backups"
$Stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$Backup = Join-Path $BackupRoot "codex-self-optimizer-$Stamp"

New-Item -ItemType Directory -Force -Path $TargetRoot | Out-Null

if (Test-Path -LiteralPath $Target) {
  New-Item -ItemType Directory -Force -Path $BackupRoot | Out-Null
  Copy-Item -LiteralPath $Target -Destination $Backup -Recurse -Force
  Remove-Item -LiteralPath $Target -Recurse -Force
}

Copy-Item -LiteralPath $Source -Destination $Target -Recurse -Force

Write-Host "Installed codex-self-optimizer to: $Target"
if (Test-Path -LiteralPath $Backup) {
  Write-Host "Previous version backed up to: $Backup"
  Write-Host "To roll back, remove $Target and copy the backup folder back to that path."
}
