# Global Agent Instructions

## General Guidelines

- Never use the em dash "—". Use plain dash "-" instead
- When writing commit messages, NEVER auto-add your agent name as co-author
- Never manually modify CHANGELOG.md files or any files that are marked as auto-generated

## User prompts
- If the user prompts something ambiguous that could lead to multiple interpretations, ask the user to clarify

## Style Guide
- Follow ruff formatting with line length 120. Prefer compact code when it remains readable

## Development
- When running python, use `.venv/bin/python`
- Use `uv` for virtual environment management
- When creating a new db, Use Postgres, not SQLite
- In general, follow YAGNI principles, and one-liner solutions
- When doing bug fixes, always start with reproducing the bug in an E2E setting as closely aligned with how an end user would experience it as possible. 
  This makes sure you find the real problem so your fix will actually solve it.
- Apply that same high standard to engineering excellence: lint, test failures, and test flakiness
  If you see one, even if it is not caused by what you are working on right now, still get it fixed

## UI work
- UI that compiles can still look broken; never trust UI from the code alone
  After any UI change, run the dev server, render the changed view, and take a screenshot to verify it before finishing
- Check mobile and desktop widths. Look for misalignment, overflow, inconsistent spacing, low contrast
- Avoid generic defaults: purple/indigo gradients, centering everything, invented colors. Use the repo's design tokens
- If the repo has docs/FRONTEND.md, read it before UI work
