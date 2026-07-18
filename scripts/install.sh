#!/usr/bin/env bash
set -euo pipefail

PATH="/usr/bin:/bin:$PATH"

usage() {
  cat <<'EOF'
Usage:
  bash scripts/install.sh [codex-home]
  bash scripts/install.sh --codex-home PATH [--dry-run|--check|--uninstall] [--force]

Options:
  --codex-home PATH  Install target Codex home. Defaults to CODEX_HOME or ~/.codex.
  --dry-run          Print planned actions without changing files.
  --check            Verify installed skill matches this repository source.
  --uninstall        Back up the installed skill, then remove it.
  --force            Accepted for non-interactive automation compatibility.
  -h, --help         Show this help.
EOF
}

SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR_PART="${SCRIPT_PATH%/*}"
if [[ "$SCRIPT_DIR_PART" == "$SCRIPT_PATH" ]]; then
  SCRIPT_DIR_PART="."
fi
SCRIPT_DIR="$(cd "$SCRIPT_DIR_PART" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE="$REPO_ROOT/skills/codex-self-optimizer"
CODEX_HOME_ARG=""
DRY_RUN=0
CHECK=0
UNINSTALL=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --codex-home)
      CODEX_HOME_ARG="${2:-}"
      if [[ -z "$CODEX_HOME_ARG" ]]; then
        echo "--codex-home requires a path" >&2
        exit 2
      fi
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --check)
      CHECK=1
      shift
      ;;
    --uninstall)
      UNINSTALL=1
      shift
      ;;
    --force)
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
    *)
      if [[ -n "$CODEX_HOME_ARG" ]]; then
        echo "Unexpected argument: $1" >&2
        usage >&2
        exit 2
      fi
      CODEX_HOME_ARG="$1"
      shift
      ;;
  esac
done

if [[ "$CHECK" -eq 1 && "$UNINSTALL" -eq 1 ]]; then
  echo "--check and --uninstall cannot be used together" >&2
  exit 2
fi

if [[ ! -d "$SOURCE" ]]; then
  echo "Skill source not found: $SOURCE" >&2
  exit 1
fi

CODEX_HOME_DIR="${CODEX_HOME_ARG:-${CODEX_HOME:-$HOME/.codex}}"
TARGET_ROOT="$CODEX_HOME_DIR/skills"
TARGET="$TARGET_ROOT/codex-self-optimizer"
BACKUP_ROOT="$CODEX_HOME_DIR/skill-backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$BACKUP_ROOT/codex-self-optimizer-$STAMP"

fingerprint_tree() {
  local path="$1"
  if [[ ! -d "$path" ]]; then
    return 1
  fi
  (cd "$path" && find . -type f -print0 | sort -z | xargs -0 sha256sum)
}

echo "Codex home: $CODEX_HOME_DIR"
echo "Source: $SOURCE"
echo "Target: $TARGET"

if [[ "$CHECK" -eq 1 ]]; then
  if [[ ! -d "$TARGET" ]]; then
    echo "Check failed: target skill is not installed."
    exit 1
  fi

  source_fingerprint="$(fingerprint_tree "$SOURCE")"
  target_fingerprint="$(fingerprint_tree "$TARGET")"
  if [[ "$source_fingerprint" == "$target_fingerprint" ]]; then
    echo "Check passed: installed skill matches repository source."
    exit 0
  fi

  echo "Check failed: installed skill differs from repository source."
  exit 1
fi

if [[ "$UNINSTALL" -eq 1 ]]; then
  if [[ ! -e "$TARGET" ]]; then
    echo "Nothing to uninstall: target skill is not installed."
    exit 0
  fi

  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "Dry run: would back up $TARGET to $BACKUP, then remove $TARGET."
    exit 0
  fi

  mkdir -p "$BACKUP_ROOT"
  cp -a "$TARGET" "$BACKUP"
  if [[ ! -d "$BACKUP" ]]; then
    echo "Backup verification failed: $BACKUP" >&2
    exit 1
  fi
  rm -rf "$TARGET"
  echo "Uninstalled codex-self-optimizer from: $TARGET"
  echo "Previous version backed up to: $BACKUP"
  echo "To roll back, copy the backup folder back to: $TARGET"
  exit 0
fi

if [[ "$DRY_RUN" -eq 1 ]]; then
  if [[ -e "$TARGET" ]]; then
    echo "Dry run: would back up existing target to $BACKUP, then replace it."
  else
    echo "Dry run: would install a new copy to $TARGET."
  fi
  exit 0
fi

mkdir -p "$TARGET_ROOT"
if [[ -e "$TARGET" ]]; then
  mkdir -p "$BACKUP_ROOT"
  cp -a "$TARGET" "$BACKUP"
  if [[ ! -d "$BACKUP" ]]; then
    echo "Backup verification failed: $BACKUP" >&2
    exit 1
  fi
  rm -rf "$TARGET"
fi

cp -a "$SOURCE" "$TARGET"
if [[ ! -f "$TARGET/SKILL.md" ]]; then
  echo "Install verification failed: SKILL.md was not copied to $TARGET" >&2
  exit 1
fi

echo "Installed codex-self-optimizer to: $TARGET"
if [[ -e "$BACKUP" ]]; then
  echo "Previous version backed up to: $BACKUP"
  echo "To roll back, remove $TARGET and copy the backup folder back to that path."
fi
