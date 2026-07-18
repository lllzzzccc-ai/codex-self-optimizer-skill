# User And Environment

Use this reference to adapt optimization to the current user, device, available evidence, and environment maturity.

## Contents

- Goal Handling
- Bootstrap Preflight
- Scan Scope And Write Policy
- User Classification
- Environment Maturity
- Workspace Missing
- Path Discovery
- Low Network Or No Network

## Goal Handling

Start from the user's natural request. Do not force the user to choose a predefined target if the request is already actionable.

Ask one question at a time only when needed. Useful clarifications:

1. What outcome should this run produce?
2. What scope should be scanned?
3. Is this report-only, or may it write after confirmation?
4. Who owns the target files: personal, project, or team?
5. What does success look like?

For non-technical users, avoid abstract mode labels at first. Ask plain questions such as: "Do you want me to help set up one place for Codex projects and notes?"

## Bootstrap Preflight

Before deep scanning or asking scan-mode questions, run a read-only preflight:

1. Detect current directory, repository root, and parent `AGENTS.md` files.
2. Detect `CODEX_HOME` if set.
3. Detect platform default Codex home such as `%USERPROFILE%\.codex` or `~/.codex`.
4. Detect visible skills directories and whether `SKILL.md` files exist.
5. Detect obvious Workspace candidates, but do not create anything.
6. Record missing evidence and continue with available context.

Preflight must not read browser profiles, secrets, large generated files, or credential-bearing data.

## Scan Scope And Write Policy

Keep scan scope separate from write policy.

| Scan scope | Use when |
|---|---|
| Quick incremental scan | Recent changes, new skills, new logs, or current-session updates |
| Full deep scan | New device, memory reset, long gap, suspected drift, or user asks for complete optimization |
| User-specified scope | User names exact files, folders, skills, projects, or config targets |

Write policy:

- Default: analyze and report only.
- Write only after the user confirms Proposed Changes.
- If the user asks for "analysis only", do not write.
- If the user wants review before writes, show Proposed Changes before each write batch.

If the user delegates scope choice to Codex, choose the smallest scope that can answer the request and explain why.

## User Classification

Read available user memory and long-term preferences before classifying the user. If memory is missing, ask the minimum needed question instead of guessing.

Classify with multiple labels when appropriate:

| User group | Optimize for | Extra caution |
|---|---|---|
| Personal efficiency | Less repeated explaining, stable preferences, assistant behavior | Avoid storing one-off emotions or temporary context |
| Developer | Project rules, tests, verification, skills, retrospectives | Do not move source layout or override unconfirmed changes |
| Non-technical | Simple explanations and clear choices | Do not require path or config expertise |
| Team/enterprise | Admin policy, team rules, audit summary | Shared rules are read-only unless the user confirms they have authority |
| Privacy-sensitive | Local-first minimal scan | Skip secrets, account data, customer data, private messages |
| Multi-device/migration | Portable rules and device-local differences | Avoid absolute path lock-in |

Before strategy depends on this classification, show the inferred labels and evidence, then let the user confirm or correct them.

## Environment Maturity

| Maturity | Signals | Default strategy |
|---|---|---|
| Blank | No AGENTS, Workspace, memories, retrospectives, or skills | Build an initial plan from the current goal and readable files |
| Basic | Some AGENTS or a few rules | Check conflicts, gaps, and reusable memories |
| Mature | Workspace, SOPs, retrospectives, skills, or memories | Do incremental refinement, dedupe, and lifecycle updates |
| Team | Shared rules, permissions, audit needs | Suggest first, confirm authority before writes |

Missing Workspace, memory, skills, SOPs, retrospectives, or pitfall logs is not failure. Report what is missing, how it limits confidence, and which fallback strategy will be used.

## Workspace Missing

If no Workspace is found:

1. Explain that a Workspace gives one place for projects, SOPs, retrospectives, pitfalls, skill notes, and recovery context.
2. Explain that this improves cross-session continuity, cross-device recovery, file organization, and future self-optimization.
3. Detect available user-writable locations before recommending paths.
4. On Windows, prefer a non-system disk only when one is detected and writable. If none is available, suggest a user-profile Workspace. On macOS/Linux, suggest a home-directory Workspace.
5. Let the user choose the path.
6. Do not create a Workspace before confirmation.
7. If the user declines, continue with current project-level or session-level optimization.

## Path Discovery

Discover paths dynamically in this order:

1. Current workspace or repository root.
2. Current directory and parent `AGENTS.md` files.
3. `CODEX_HOME`.
4. Platform default Codex home.
5. User-provided paths.
6. Other user-writable Workspace candidates.

Never assume a fixed drive, username, operating system, Workspace path, or Codex installation path.

## Low Network Or No Network

The skill must work offline. Use local files first. Treat network, sandbox, permission, or runtime failures as environment issues rather than rule failures.

Ask before using network sources or external tools unless the user explicitly requested research. Never upload sensitive local content as a search query.
