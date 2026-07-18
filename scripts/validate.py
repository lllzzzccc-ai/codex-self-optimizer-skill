#!/usr/bin/env python3
from __future__ import annotations

import re
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SKILL_DIR = ROOT / "skills" / "codex-self-optimizer"
SKILL_MD = SKILL_DIR / "SKILL.md"
VERSION = (ROOT / "VERSION").read_text(encoding="utf-8").strip()

EXCLUDED_DIRS = {".git", "skill-backups", "__pycache__"}
EXCLUDED_SUFFIXES = {".png", ".jpg", ".jpeg", ".gif", ".ico", ".pdf", ".zip"}
SENSITIVE_PATTERNS = [
    re.compile(r"\b[A-Z]:\\Users\\[^\\\s]+", re.IGNORECASE),
    re.compile(r"\b[A-Z]:\\Workspace\b", re.IGNORECASE),
    re.compile(r"\b\d{6,}\+[^@\s]+@users\.noreply\.github\.com\b", re.IGNORECASE),
    re.compile(r"(?i)(api[_-]?key|secret|token|password)\s*[:=]\s*['\"]?[A-Za-z0-9_\-]{12,}"),
    re.compile(r"ghp_[A-Za-z0-9_]{20,}"),
]


def fail(message: str) -> None:
    print(f"FAIL: {message}", file=sys.stderr)
    raise SystemExit(1)


def read_text(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8")
    except UnicodeDecodeError as exc:
        fail(f"{path.relative_to(ROOT)} is not valid UTF-8: {exc}")


def parse_frontmatter(text: str) -> dict[str, str]:
    match = re.match(r"^---\n(.*?)\n---\n", text, flags=re.DOTALL)
    if not match:
        fail("SKILL.md missing YAML frontmatter")

    raw = match.group(1)
    if len(raw) > 1024:
        fail("SKILL.md frontmatter exceeds 1024 characters")

    values: dict[str, str] = {}
    for line in raw.splitlines():
        if ":" not in line:
            continue
        key, value = line.split(":", 1)
        values[key.strip()] = value.strip().strip('"').strip("'")
    return values


def validate_skill() -> None:
    if not SKILL_MD.exists():
        fail("skills/codex-self-optimizer/SKILL.md missing")

    text = read_text(SKILL_MD)
    fields = parse_frontmatter(text)
    name = fields.get("name", "")
    description = fields.get("description", "")

    if name != "codex-self-optimizer":
        fail("SKILL.md name must be codex-self-optimizer")
    if not re.fullmatch(r"[A-Za-z0-9-]+", name):
        fail("SKILL.md name must contain only letters, numbers, and hyphens")
    if not description.startswith("Use when"):
        fail("SKILL.md description must start with 'Use when'")
    if len(description) > 500:
        fail("SKILL.md description should stay under 500 characters")

    for ref in sorted(set(re.findall(r"`(references/[^`]+\.md)`", text))):
        if not (SKILL_DIR / ref).exists():
            fail(f"referenced file missing: {ref}")

    required_refs = [
        "references/behavior-testing.md",
        "references/memory-and-sources.md",
        "references/output-templates.md",
        "references/safety-and-rollback.md",
        "references/user-and-environment.md",
    ]
    for ref in required_refs:
        if not (SKILL_DIR / ref).exists():
            fail(f"required reference missing: {ref}")


def validate_docs() -> None:
    readme = read_text(ROOT / "README.md")
    changelog = read_text(ROOT / "CHANGELOG.md")

    if f"Current version: `{VERSION}`" not in readme:
        fail("README current version does not match VERSION")
    if f"## {VERSION} -" not in changelog:
        fail("CHANGELOG missing current VERSION section")

    for path in [
        ROOT / "LICENSE",
        ROOT / "SECURITY.md",
        ROOT / "CONTRIBUTING.md",
        ROOT / "scripts" / "install.ps1",
        ROOT / "scripts" / "install.sh",
        ROOT / ".github" / "workflows" / "validate.yml",
        ROOT / "examples" / "blank-setup-report.md",
        ROOT / "examples" / "proposed-changes.md",
        ROOT / "examples" / "self-test-record.md",
        ROOT / "examples" / "rollback-plan.md",
    ]:
        if not path.exists():
            fail(f"required file missing: {path.relative_to(ROOT)}")


def iter_public_text_files() -> list[Path]:
    files: list[Path] = []
    for path in ROOT.rglob("*"):
        if not path.is_file():
            continue
        if any(part in EXCLUDED_DIRS for part in path.relative_to(ROOT).parts):
            continue
        if path.suffix.lower() in EXCLUDED_SUFFIXES:
            continue
        files.append(path)
    return files


def validate_sensitive_scan() -> None:
    for path in iter_public_text_files():
        text = read_text(path)
        for pattern in SENSITIVE_PATTERNS:
            if pattern.search(text):
                fail(f"potential sensitive or machine-specific content in {path.relative_to(ROOT)}")


def main() -> None:
    validate_skill()
    validate_docs()
    validate_sensitive_scan()
    print("VALIDATION_OK")


if __name__ == "__main__":
    main()
