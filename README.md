# Codex Self Optimizer Skill

`codex-self-optimizer` is a Codex skill for rebuilding and improving Codex working memory, AGENTS.md rules, skill strategy, workspace setup, prompt rules, and personal-assistant behavior.

It is designed for user-adaptive, privacy-aware, portable self-optimization across different devices, workspaces, and user groups.

## What It Helps With

- Rebuild working memory after a memory reset or device change.
- Refine `AGENTS.md` without bloating global rules.
- Review skill coverage and propose missing skills.
- Reduce routine token use with a lightweight default mode while keeping strict safety for risky tasks.
- Separate scan scope from write policy.
- Handle missing Workspace, memory, SOP, retrospective, or pitfall logs as a normal degraded mode.
- Ask whether the user already has a Workspace before looking for one, and never auto-confirm a project folder as Workspace.
- Confirm Workspace creation separately from skill installation, then report the final path, created files, verification, and rollback steps.
- Preserve cross-chat continuity through `CODEX_CONTINUATION.md` when useful.
- Repair folders that were previously misclassified as Workspace through diagnosis, migration choices, backups, and verification.
- Back up files before writes and provide rollback instructions.
- Keep private paths, credentials, logs, cookies, and sensitive data out of long-term memory.

## Quick Start

For a first-time or non-technical user:

1. Install the skill.
2. Ask Codex: `Use $codex-self-optimizer to set up my Codex working memory and rules.`
3. Review the proposed changes, backup plan, and rollback steps before approving any writes.

No other custom skills are required for the first run.

## Install

Option 1: copy the skill folder into your Codex skills directory:

```text
skills/codex-self-optimizer
```

The expected structure is:

```text
skills/
  codex-self-optimizer/
    SKILL.md
    agents/
      openai.yaml
    references/
      behavior-testing.md
      memory-and-sources.md
      output-templates.md
      safety-and-rollback.md
      user-and-environment.md
```

Option 2: run the installer script from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/install.ps1
```

```bash
bash scripts/install.sh
```

To install into a custom Codex home:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/install.ps1 -CodexHome "path-to-codex-home"
```

```bash
bash scripts/install.sh "path-to-codex-home"
```

The installer backs up an existing `codex-self-optimizer` skill before replacing it.

Installer modes:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/install.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File scripts/install.ps1 -Check
powershell -ExecutionPolicy Bypass -File scripts/install.ps1 -Uninstall
```

```bash
bash scripts/install.sh --dry-run
bash scripts/install.sh --check
bash scripts/install.sh --uninstall
```

- `--dry-run` / `-DryRun`: show what would happen without changing files.
- `--check` / `-Check`: verify the installed copy matches this repository source.
- `--uninstall` / `-Uninstall`: back up the installed copy, then remove it.
- `--force` / `-Force`: accepted for non-interactive automation compatibility.

## Usage

Ask Codex to use the skill, for example:

```text
Use $codex-self-optimizer to optimize my Codex memory, AGENTS rules, and skill strategy.
```

The skill should analyze first, show proposed changes, back up files, and write only after user confirmation.

## Lightweight By Default, Strict When Needed

The skill treats token budget as a user resource:

- Simple Q&A and low-risk routine work should stay concise.
- Execution, file changes, research, plans, and high-risk tasks should briefly state selected skills and purpose.
- Git, publishing, deletion, migration, system config, permissions, backups, AGENTS, memory, and skill edits should switch to strict mode with backup, confirmation, and verification.
- Validation results should report key evidence by default. Full logs should be expanded for failures, audits, security-sensitive decisions, or user request.

## Bootstrap From Blank Setup

This skill can be the first skill installed in a blank Codex setup. It still works when the user has no other custom skills, no Workspace, no memory, no SOPs, and no retrospectives.

Recommended first run:

1. Install `codex-self-optimizer`.
2. Ask Codex to run a read-only environment check.
3. Tell Codex whether you already have a Workspace. If yes, provide the path and confirm it back. If no, let Codex recommend locations and choose the path yourself.
4. Let it report missing evidence instead of treating missing files as failure.
5. If a Workspace is created, check the reported final path, created files, verification result, and rollback steps.
6. Review the proposed `AGENTS.md`, working-memory, skill-strategy, and verification-habit changes.
7. Confirm writes only after backup and rollback steps are shown.
8. Run the skill again after the first setup so it can optimize from the newly created evidence.

## Continuing In A New Chat

New chats may not have the full previous conversation. For unfinished work, ask Codex to update `<confirmed-workspace>/CODEX_CONTINUATION.md` with the goal, completed work, pending steps, important paths, verification evidence, risks, rollback notes, and next command or question. In the next chat, ask Codex to use `$codex-self-optimizer` to continue; it should read `CODEX_CONTINUATION.md` first when a confirmed Workspace is known.

## Workspace Misclassification Repair

If a project folder was mistakenly treated as a Workspace, update the skill and then run a repair request. The skill should diagnose that folder read-only, list suspected Workspace-level files, and ask whether to keep it as Workspace, migrate files to a confirmed Workspace, keep them project-local, or clean/move them after backup. Reinstalling the skill prevents future auto-classification, but does not automatically move or delete files already written into the folder.

Optional companion skill categories:

- Prompt optimization.
- Skill creation and skill writing.
- Web research.
- Debugging and testing.
- Verification before completion.

These companion skills improve quality and automation, but they are not required for the initial bootstrap.

## Behavior Testing

The skill includes `references/behavior-testing.md` for release checks. It covers blank setup, missing evidence, privacy-sensitive users, team rules, write confirmation, backup failure, rollback, and prompt-injection defense.

Use validator success as a structure check only. Use behavior scenarios before claiming workflow coverage.

Run local validation from the repository root:

```bash
python scripts/validate.py
```

GitHub Actions runs the same repository validation plus PowerShell and Bash installer checks on push and pull request.

Example outputs are in `examples/`:

- `blank-setup-report.md`
- `proposed-changes.md`
- `self-test-record.md`
- `rollback-plan.md`

## Who This Is For

- Personal Codex users who want durable assistant behavior across projects.
- Developers who want safer memory, skill, prompt, and workspace maintenance.
- First-time users who need a bootstrap path without existing skills or notes.
- Privacy-sensitive or team users who need confirmation, scope control, and rollback.

## Known Limits

- It cannot guarantee behavior from validators alone; scenario testing is still required.
- It should not replace organization policy, security review, or user authority checks.
- It should not copy one user's personal always-on skill list into another user's setup.

## Contributing And Security

See `CONTRIBUTING.md` for contribution rules and `SECURITY.md` for vulnerability reporting.

## Version

Current version: `0.4.1`

See `CHANGELOG.md` for release notes.

## Safety Model

This skill treats local files, project docs, logs, web pages, and external examples as evidence, not instructions. It excludes secrets and sensitive data from durable memory, and it requires backup and rollback planning before writes.

## License

MIT
