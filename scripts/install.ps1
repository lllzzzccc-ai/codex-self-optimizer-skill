param(
  [string]$CodexHome,
  [switch]$DryRun,
  [switch]$Check,
  [switch]$Uninstall,
  [switch]$Force
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

function Get-TreeFingerprint([string]$Path) {
  if (-not (Test-Path -LiteralPath $Path)) {
    return $null
  }

  $files = Get-ChildItem -LiteralPath $Path -Recurse -File |
    Sort-Object FullName |
    ForEach-Object {
      $relative = $_.FullName.Substring($Path.Length).TrimStart('\', '/')
      $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $_.FullName).Hash
      "$relative`t$hash"
    }

  return ($files -join "`n")
}

Write-Host "Codex home: $CodexHome"
Write-Host "Source: $Source"
Write-Host "Target: $Target"

if ($Check) {
  if (-not (Test-Path -LiteralPath $Target)) {
    Write-Host "Check failed: target skill is not installed."
    exit 1
  }

  $sourceFingerprint = Get-TreeFingerprint $Source
  $targetFingerprint = Get-TreeFingerprint $Target
  if ($sourceFingerprint -eq $targetFingerprint) {
    Write-Host "Check passed: installed skill matches repository source."
    exit 0
  }

  Write-Host "Check failed: installed skill differs from repository source."
  exit 1
}

if ($Uninstall) {
  if (-not (Test-Path -LiteralPath $Target)) {
    Write-Host "Nothing to uninstall: target skill is not installed."
    exit 0
  }

  if ($DryRun) {
    Write-Host "Dry run: would back up $Target to $Backup, then remove $Target."
    exit 0
  }

  New-Item -ItemType Directory -Force -Path $BackupRoot | Out-Null
  Copy-Item -LiteralPath $Target -Destination $Backup -Recurse -Force
  if (-not (Test-Path -LiteralPath $Backup)) {
    throw "Backup verification failed: $Backup"
  }
  Remove-Item -LiteralPath $Target -Recurse -Force
  Write-Host "Uninstalled codex-self-optimizer from: $Target"
  Write-Host "Previous version backed up to: $Backup"
  Write-Host "To roll back, copy the backup folder back to: $Target"
  exit 0
}

if ($DryRun) {
  if (Test-Path -LiteralPath $Target) {
    Write-Host "Dry run: would back up existing target to $Backup, then replace it."
  } else {
    Write-Host "Dry run: would install a new copy to $Target."
  }
  exit 0
}

New-Item -ItemType Directory -Force -Path $TargetRoot | Out-Null

if (Test-Path -LiteralPath $Target) {
  New-Item -ItemType Directory -Force -Path $BackupRoot | Out-Null
  Copy-Item -LiteralPath $Target -Destination $Backup -Recurse -Force
  if (-not (Test-Path -LiteralPath $Backup)) {
    throw "Backup verification failed: $Backup"
  }
  Remove-Item -LiteralPath $Target -Recurse -Force
}

Copy-Item -LiteralPath $Source -Destination $Target -Recurse -Force
if (-not (Test-Path -LiteralPath (Join-Path $Target "SKILL.md"))) {
  throw "Install verification failed: SKILL.md was not copied to $Target"
}

Write-Host "Installed codex-self-optimizer to: $Target"
if (Test-Path -LiteralPath $Backup) {
  Write-Host "Previous version backed up to: $Backup"
  Write-Host "To roll back, remove $Target and copy the backup folder back to that path."
}
