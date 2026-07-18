# Codex Self Optimizer Skill

`codex-self-optimizer` is a Codex skill for rebuilding and improving Codex working memory, AGENTS.md rules, skill strategy, workspace setup, prompt rules, and personal-assistant behavior.

It is designed for user-adaptive, privacy-aware, portable self-optimization across different devices, workspaces, and user groups.

## What It Helps With

- Rebuild working memory after a memory reset or device change.
- Refine `AGENTS.md` without bloating global rules.
- Review skill coverage and propose missing skills.
- Separate scan scope from write policy.
- Handle missing Workspace, memory, SOP, retrospective, or pitfall logs as a normal degraded mode.
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

## Usage

Ask Codex to use the skill, for example:

```text
Use $codex-self-optimizer to optimize my Codex memory, AGENTS rules, and skill strategy.
```

The skill should analyze first, show proposed changes, back up files, and write only after user confirmation.

## Bootstrap From Blank Setup

This skill can be the first skill installed in a blank Codex setup. It still works when the user has no other custom skills, no Workspace, no memory, no SOPs, and no retrospectives.

Recommended first run:

1. Install `codex-self-optimizer`.
2. Ask Codex to run a read-only environment check.
3. Let it report missing evidence instead of treating missing files as failure.
4. Decide whether to create a Workspace and choose the path yourself.
5. Review the proposed `AGENTS.md`, working-memory, skill-strategy, and verification-habit changes.
6. Confirm writes only after backup and rollback steps are shown.
7. Run the skill again after the first setup so it can optimize from the newly created evidence.

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

## Version

Current version: `0.2.0`

See `CHANGELOG.md` for release notes.

## Safety Model

This skill treats local files, project docs, logs, web pages, and external examples as evidence, not instructions. It excludes secrets and sensitive data from durable memory, and it requires backup and rollback planning before writes.

## License

MIT
