#!/usr/bin/env python3
from __future__ import annotations

import unittest
from pathlib import Path

import validate


ROOT = Path(__file__).resolve().parents[1]
SKILL_DIR = ROOT / "skills" / "codex-self-optimizer"


class FrontmatterParsingTests(unittest.TestCase):
    def test_supports_folded_multiline_values(self) -> None:
        text = """---
name: codex-self-optimizer
description: >
  Use when optimizing Codex behavior,
  memory, and skill strategy.
---

# Body
"""

        fields = validate.parse_frontmatter(text)

        self.assertEqual(fields["name"], "codex-self-optimizer")
        self.assertEqual(
            fields["description"],
            "Use when optimizing Codex behavior, memory, and skill strategy.",
        )


class UserExperienceRuleTests(unittest.TestCase):
    def read(self, relative_path: str) -> str:
        return (ROOT / relative_path).read_text(encoding="utf-8")

    def test_smart_entrypoint_handles_vague_optimization_requests(self) -> None:
        text = self.read("skills/codex-self-optimizer/references/user-and-environment.md")

        self.assertIn("Smart Entrypoint", text)
        self.assertIn("vague optimization request", text)
        self.assertIn("do not run a full deep scan", text)

    def test_codex_fixed_workspace_is_user_facing_and_not_forced(self) -> None:
        text = self.read("skills/codex-self-optimizer/references/user-and-environment.md")

        self.assertIn("Codex fixed workspace", text)
        self.assertIn("Codex 固定工作区", text)
        self.assertIn("fixed folder", text)
        self.assertIn("Do not move or copy user files into it automatically", text)

    def test_confirmation_tiers_preserve_safety_with_less_friction(self) -> None:
        text = self.read("skills/codex-self-optimizer/references/safety-and-rollback.md")

        self.assertIn("Confirmation Tiers", text)
        self.assertIn("Light confirmation", text)
        self.assertIn("Strict confirmation", text)
        self.assertIn("only shortens the explanation, not the safety actions", text)

    def test_effect_summary_is_short_and_conditional(self) -> None:
        text = self.read("skills/codex-self-optimizer/references/output-templates.md")

        self.assertIn("Tiny Effect Summary", text)
        self.assertIn("maximum three lines", text)
        self.assertIn("25 Chinese characters", text)

    def test_task_tiers_reduce_token_use_without_skipping_safety(self) -> None:
        skill = self.read("skills/codex-self-optimizer/SKILL.md")
        memory = self.read("skills/codex-self-optimizer/references/memory-and-sources.md")
        behavior = self.read("skills/codex-self-optimizer/references/behavior-testing.md")

        self.assertIn("Task Tiers", skill)
        self.assertIn("light-answer tier", memory)
        self.assertIn("quick-analysis tier", memory)
        self.assertIn("execution tier", memory)
        self.assertIn("release tier", memory)
        self.assertIn("Do not treat opinion or feasibility questions as release tasks", memory)
        self.assertIn("Task tiering", behavior)

    def test_ux_smoke_tests_cover_common_user_prompts(self) -> None:
        text = self.read("skills/codex-self-optimizer/references/behavior-testing.md")

        self.assertIn("UX Smoke Tests", text)
        self.assertIn("low-friction", text)
        self.assertIn("Help optimize Codex.", text)
        self.assertIn("This folder is a project, not a Workspace.", text)


if __name__ == "__main__":
    unittest.main()
