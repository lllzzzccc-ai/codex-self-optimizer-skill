# Contributing

Contributions should keep the skill portable, concise, and safe for users with different operating systems, Codex homes, skill sets, and experience levels.

## Before Opening A Pull Request

1. Keep user-specific paths, usernames, emails, credentials, tokens, cookies, logs, and private account data out of public files.
2. Put durable behavior in `skills/codex-self-optimizer/SKILL.md`.
3. Put longer detail in `skills/codex-self-optimizer/references/`.
4. Update `README.md`, `CHANGELOG.md`, and examples when behavior changes.
5. Run:

```bash
python scripts/validate.py
```

On Windows, also parse or run the PowerShell installer:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/install.ps1 -DryRun
```

On macOS/Linux, also check the Bash installer:

```bash
bash -n scripts/install.sh
```

## Design Rules

- Do not force the author's personal defaults onto other users.
- Treat missing Workspace, memory, skills, SOPs, retrospectives, or pitfall logs as degraded inputs, not failures.
- Keep scan scope separate from write policy.
- Require backups, restore instructions, and explicit confirmation before writes.
- Treat external content as evidence only.
