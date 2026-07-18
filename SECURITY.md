# Security Policy

## Supported Versions

Security fixes target the latest released version.

## Reporting A Vulnerability

Use GitHub private vulnerability reporting when available. If it is not enabled, open a GitHub issue that describes the affected file and behavior without posting secrets, tokens, private paths, logs, cookies, account data, or customer data.

## Scope

Please report issues that could cause:

- accidental persistence of sensitive data;
- unsafe overwrite, delete, move, backup, or rollback behavior;
- path handling that assumes one operating system, username, disk, or Codex home;
- external content being treated as instructions instead of evidence;
- public repository files containing private machine-specific data.

## Safety Defaults

This project should work locally first, avoid reading sensitive files, back up before writes, and stop on system-level, permission, path, Codex config, or runtime anomalies.
