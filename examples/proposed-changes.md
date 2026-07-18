# Proposed Changes Example

## Proposed Changes

- Scan scope: Current Codex home, current workspace, and explicitly named skill folders.
- Write policy: Write only after this checklist is confirmed.
- Files to modify:
  - `<codex-home>/AGENTS.md`
  - `<workspace>/CODEX_SELF_OPTIMIZATION.md`
- Files to back up:
  - Existing target files, if present.
  - Restore records for files that do not exist before this run.
- Backup directory: `<workspace-or-temp>/codex-self-optimizer-backups/<timestamp>/`
- Pre-write backup verification: Confirm every backup file exists and is readable.
- Risk level: Medium for behavior rules, low for a new report file.
- Rollback scope: Restore modified files from backup; delete files recorded as newly created.
- Expected result: Shorter durable rules, clear recovery steps, and no sensitive data persisted.
- Items needing confirmation: Target paths and whether to write now.
