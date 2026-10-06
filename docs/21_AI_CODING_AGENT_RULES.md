# 21 - AI Coding Agent Rules

Version 1.0 | The operative copy lives in the repository root: `AGENTS.md`. This document explains the workflow around it.

## 1. Workflow
1. Human picks a phase prompt from `prompts/`.
2. Agent reads `AGENTS.md`, the master guide, the relevant docs, and ADRs; proposes a plan.
3. Human approves the plan (or adjusts).
4. Agent implements in small commits, running lint/typecheck/tests as it goes.
5. Agent reports using the honest-reporting template.
6. Human (with a reviewer such as Claude) reviews for architecture integrity, contradictions and risky decisions before merging.

## 2. Review checklist (for the human or reviewer)
- Does it contradict an ADR or the master guide?
- Does any money move outside the ledger service?
- Are there client-trusted values?
- Are permissions checked server-side?
- Are migrations safe? Tests added? Docs and changelog updated?
- Any new dependency? Is it justified?
- Any hardcoded game values that should be config?
- Did it touch unrelated files?

## 3. Common agent failure patterns (watch for these)
- Claims "done" with failing or skipped tests.
- Creates parallel systems instead of using existing modules.
- Puts game logic in the client for convenience.
- Uses floats for money, or updates balances directly.
- Adds libraries silently.
- Rewrites unrelated files.
- Invents requirements instead of asking.
- Leaves TODOs and mocks in production paths.

## 4. Prompt hygiene
Each prompt states: goal, docs to read, in-scope, out-of-scope, acceptance criteria, required tests, reporting format. Use the files in `prompts/` as templates.

## 5. Version control strategy
- Branches: `main` (protected), `feat/<phase>-<topic>`, `fix/...`.
- PRs required, CI must pass, squash merge with conventional commit title.
- Tag releases `v0.x.y`. Keep `CHANGELOG.md` updated.
- Never force-push `main`. Never commit secrets.

## 6. When agents disagree with docs
Stop, state the conflict, propose an ADR change. The human decides.
