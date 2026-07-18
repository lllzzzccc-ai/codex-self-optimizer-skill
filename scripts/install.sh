#!/usr/bin/env bash
set -euo pipefail

PATH="/usr/bin:/bin:$PATH"

SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR_PART="${SCRIPT_PATH%/*}"
if [[ "$SCRIPT_DIR_PART" == "$SCRIPT_PATH" ]]; then
  SCRIPT_DIR_PART="."
fi
SCRIPT_DIR="$(cd "$SCRIPT_DIR_PART" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE="$REPO_ROOT/skills/codex-self-optimizer"

if [[ ! -d "$SOURCE" ]]; then
  echo "Skill source not found: $SOURCE" >&2
  exit 1
fi

CODEX_HOME_DIR="${1:-${CODEX_HOME:-$HOME/.codex}}"
TARGET_ROOT="$CODEX_HOME_DIR/skills"
TARGET="$TARGET_ROOT/codex-self-optimizer"
BACKUP_ROOT="$CODEX_HOME_DIR/skill-backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$BACKUP_ROOT/codex-self-optimizer-$STAMP"

mkdir -p "$TARGET_ROOT"

if [[ -e "$TARGET" ]]; then
  mkdir -p "$BACKUP_ROOT"
  cp -a "$TARGET" "$BACKUP"
  rm -rf "$TARGET"
fi

cp -a "$SOURCE" "$TARGET"

echo "Installed codex-self-optimizer to: $TARGET"
if [[ -e "$BACKUP" ]]; then
  echo "Previous version backed up to: $BACKUP"
  echo "To roll back, remove $TARGET and copy the backup folder back to that path."
fi
