#!/usr/bin/env python3
from __future__ import annotations

import unittest

import validate


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


if __name__ == "__main__":
    unittest.main()
