# Changelog

## 0.4.0 - 2026-07-20

- Removed automatic Workspace confirmation from filesystem clues. A Workspace must now be explicitly declared and confirmed by the user.
- Added first-run Workspace questioning: ask whether the user already has a Workspace before recommending or creating one.
- Added misclassified Workspace repair guidance for folders that were previously treated as Workspace by mistake.
- Added fixed continuation entrypoint guidance using `CODEX_CONTINUATION.md` for future-chat continuation.

## 0.3.2 - 2026-07-20

- Clarified that installing or invoking the skill is not confirmation to create a Workspace.
- Added Workspace creation result reporting: final path, created items, verification, and rollback steps.
- Added cross-chat continuation handoff guidance so new chats continue from durable evidence instead of assumed chat history.

## 0.3.1 - 2026-07-19

- Added token-efficiency guidance: default lightweight operation, strict mode for high-risk tasks, concise skill announcements, and summarized verification evidence.
- Added guidance to preserve durable lessons when cleaning up canceled task artifacts.
- Updated README to explain the lightweight/strict operating model.

## 0.3.0 - 2026-07-18

- Added GitHub Actions validation for repository structure and installers.
- Added `--dry-run`, `--check`, and `--uninstall` installer modes.
- Added public examples for reports, proposed changes, self-tests, and rollback plans.
- Added `SECURITY.md` and `CONTRIBUTING.md`.

## 0.2.0 - 2026-07-18

- Added blank-setup behavior testing guidance.
- Added optional install scripts for PowerShell and POSIX shells.
- Improved README onboarding for non-technical and first-time users.
- Clarified that companion skills are optional accelerators, not prerequisites.
- Added release/version tracking.

## 0.1.0 - 2026-07-18

- Initial public-ready `codex-self-optimizer` skill.
- Added privacy-aware bootstrap workflow, backup/rollback rules, missing-evidence fallback, and output templates.
