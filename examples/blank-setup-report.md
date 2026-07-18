# Blank Setup Report Example

## Optimization Report

- Goal: Set up an initial Codex operating baseline for a user with no existing memory or custom skills.
- User profile: Unknown; ask plain-language questions before assuming technical depth.
- Device/environment: Current directory and Codex home discovered by read-only preflight.
- Scan scope: Bootstrap preflight only.
- Write policy: Report-only until the user confirms proposed changes.
- Evidence found: Current request, current directory, platform default Codex home.
- Missing evidence: Workspace, AGENTS.md, working memory, SOPs, retrospectives, pitfall logs, custom skills.
- Capability gaps: No optional companion skills detected.
- Risks: Overfitting to one task; writing machine-specific paths into portable rules.
- Recommended changes: Propose a small AGENTS.md, a working-memory file, and a user-chosen Workspace path if useful.
- Requires confirmation: Workspace path, files to create, backup or restore records.
- No-action items: Do not create skills, automations, or broad rules without repeated evidence.
