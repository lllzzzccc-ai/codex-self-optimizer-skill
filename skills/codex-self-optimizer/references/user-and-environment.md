# User And Environment

Use this reference to adapt optimization to the current user, device, available evidence, and environment maturity.

## Contents

- Goal Handling
- Bootstrap Preflight
- Scan Scope And Write Policy
- User Classification
- Environment Maturity
- Blank Setup Bootstrap
- Workspace Declaration
- Workspace Missing
- Workspace Misclassification Repair
- Path Discovery
- Low Network Or No Network
- Conversation Continuity

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
5. Record any user-provided Workspace path, drive, or folder name.
6. Record candidate locations only as candidates. Do not classify any folder as a confirmed Workspace from filesystem clues.
7. Record missing evidence and continue with available context.

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
| Blank | No confirmed Workspace, AGENTS, memories, retrospectives, or skills | Build an initial plan from the current goal and readable files |
| Basic | Some AGENTS or a few rules | Check conflicts, gaps, and reusable memories |
| Mature | Confirmed Workspace, SOPs, retrospectives, skills, or memories | Do incremental refinement, dedupe, and lifecycle updates |
| Team | Shared rules, permissions, audit needs | Suggest first, confirm authority before writes |

Missing confirmed Workspace, memory, skills, SOPs, retrospectives, or pitfall logs is not failure. Report what is missing, how it limits confidence, and which fallback strategy will be used.

## Blank Setup Bootstrap

Use this path when the user has no other custom skills, no confirmed Workspace, no memory, or no durable docs.

1. State that this skill can still run as a bootstrap guide, but specialized skills are optional accelerators, not prerequisites.
2. Run the read-only Bootstrap Preflight and list what exists, what is missing, and what must not be scanned.
3. Ask for the user's immediate goal in plain language if it is not already clear.
4. Ask whether the user already has a Workspace. If yes, ask for its path, drive, or folder name and confirm it back. If no, recommend a Workspace only if it would help continuity; explain benefits and let the user choose the path. If unsure, run read-only candidate discovery and ask the user to choose.
5. Produce an initial plan for `AGENTS.md`, working memory, skill strategy, and verification habits before writing anything.
6. Suggest foundational skills only as optional next steps. Useful categories include prompt optimization, skill creation, web research, debugging, testing, and verification.
7. Write only after Proposed Changes, backup or restore records, and explicit user confirmation.
8. After the first setup, run one more self-optimization pass using the newly created evidence.

Do not fail because optional skills are absent. Use built-in reasoning and available tools, and record confidence limits clearly.

## Workspace Declaration

Workspace status must be user-declared and confirmed.

1. Before detecting, using, or creating a Workspace, ask whether the user already has a dedicated place for Codex projects, rules, SOPs, retrospectives, pitfalls, skill notes, and long-term memory.
2. If the user has one, ask for its path, drive, or folder name. Prioritize only that user-provided scope.
3. Echo the resolved path and ask for confirmation before treating it as `confirmed_workspace`.
4. If the user has none, recommend dynamic writable locations and wait for the user to choose and confirm.
5. If the user is unsure, run read-only candidate discovery and label results only as `workspace_candidate`.
6. Do not treat the current directory, project folder name, `AGENTS.md`, multi-project layout, or existing Codex files as Workspace proof.
7. Until confirmation, operate at current project or session scope.

## Workspace Missing

If no confirmed Workspace is available:

1. Explain that a Workspace gives one place for projects, SOPs, retrospectives, pitfalls, skill notes, and recovery context.
2. Explain that this improves cross-session continuity, cross-device recovery, file organization, and future self-optimization.
3. Detect available user-writable locations before recommending paths.
4. On Windows, prefer a non-system disk only when one is detected and writable. If none is available, suggest a user-profile Workspace. On macOS/Linux, suggest a home-directory Workspace.
5. Let the user choose the path.
6. Do not create a Workspace before confirmation.
7. Treat skill installation, "use this skill", or a generic "confirm" as insufficient unless the user has also confirmed Workspace creation and the final path.
8. After creating a Workspace, report the final path, created files and directories, verification result, and rollback steps.
9. If the user cannot find the Workspace, search only the confirmed candidate path and report evidence before suggesting broader scans.
10. If the user declines, continue with current project-level or session-level optimization.

## Workspace Misclassification Repair

Use this when a folder was previously treated as a Workspace but the user says it was only a project folder.

1. State that reinstalling or updating the skill prevents future auto-classification, but it does not automatically repair files already written into the misclassified folder.
2. Ask for the misclassified folder path and the intended Workspace path, if one exists.
3. Diagnose the misclassified folder read-only first. Identify possible Workspace-level artifacts such as `AGENTS.md`, `CODEX_SELF_OPTIMIZATION.md`, `CODEX_CONTINUATION.md`, SOP folders, retrospective folders, pitfall logs, skill notes, and restore records.
4. Separate project-owned files from suspected Workspace-level files. Do not delete or move anything during diagnosis.
5. Offer choices: keep the folder as Workspace, migrate Workspace-level files to a confirmed Workspace, keep them project-local, or clean/move them after backup.
6. Before any migration, move, delete, or overwrite, show Proposed Changes, create backups or restore records, and wait for explicit confirmation.
7. After repair, verify the final locations and record the confirmed Workspace path or the decision to operate without one.

## Path Discovery

Discover paths dynamically in this order:

1. User-declared Workspace path, after confirmation.
2. Current directory and repository root.
3. `CODEX_HOME`.
4. Platform default Codex home.
5. User-provided paths.
6. Other user-writable candidate locations.

Never assume a fixed drive, username, operating system, Workspace path, or Codex installation path.

## Low Network Or No Network

The skill must work offline. Use local files first. Treat network, sandbox, permission, or runtime failures as environment issues rather than rule failures.

Ask before using network sources or external tools unless the user explicitly requested research. Never upload sensitive local content as a search query.

## Conversation Continuity

New chats may not inherit the full previous conversation. Do not assume another chat can continue from transient chat context alone.

When continuity matters:

1. Prefer the fixed continuation entrypoint `CODEX_CONTINUATION.md` under the confirmed Workspace.
2. If no confirmed Workspace exists, ask for the Workspace path or ask whether to use a project-local continuation file for this task.
3. Check whether `CODEX_CONTINUATION.md`, working memory, project note, or task summary exists.
4. If none exists and the current task has reusable or unfinished state, propose writing `CODEX_CONTINUATION.md` before ending or switching chats.
5. Include only the current goal, decisions, completed work, pending steps, important paths, verification evidence, risks, rollback notes, and the next command or question.
6. Exclude secrets, private messages, credentials, raw logs, and one-off chatter.
7. Write the continuation file only after backup or restore records and explicit user confirmation.
8. In a new chat, if the user says "continue" and a confirmed Workspace is known, read `CODEX_CONTINUATION.md` before asking follow-up questions. If it is missing, state the limit and ask for the Workspace path or task source.
