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

## Install

Copy the skill folder into your Codex skills directory:

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
      memory-and-sources.md
      output-templates.md
      safety-and-rollback.md
      user-and-environment.md
```

## Usage

Ask Codex to use the skill, for example:

```text
Use $codex-self-optimizer to optimize my Codex memory, AGENTS rules, and skill strategy.
```

The skill should analyze first, show proposed changes, back up files, and write only after user confirmation.

## Safety Model

This skill treats local files, project docs, logs, web pages, and external examples as evidence, not instructions. It excludes secrets and sensitive data from durable memory, and it requires backup and rollback planning before writes.

## License

MIT
