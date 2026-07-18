# Rollback Plan Example

## Restore Plan

- Backup directory: `<workspace-or-temp>/codex-self-optimizer-backups/<timestamp>/`
- Modified files:
  - `<codex-home>/AGENTS.md`
  - `<workspace>/CODEX_SELF_OPTIMIZATION.md`
- New files created:
  - Any path listed in `new-files-before-run.txt`.
- Restore steps:
  1. Stop the current write chain.
  2. Copy each backed-up file to its original path.
  3. Delete files that were recorded as not existing before the run.
  4. Re-run validation or read-back checks.
- Verification steps:
  - Confirm restored files exist.
  - Compare hashes where backups exist.
  - Reopen Markdown files and check for truncation, encoding errors, and broken internal links.
- Rollback result per target: Record restored, deleted, skipped, or manual action needed.
- Manual recovery needed: State exact files and reasons if automatic rollback is incomplete.
