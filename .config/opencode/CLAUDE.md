# CLAUDE.md

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

## A-Dev and Context Persistence

- Use `@adev` when the work needs disciplined AI-assisted delivery: baseline, short iterations, validation, evidence, handoff.
- Read project `ADEV.md` first when it exists.
- Keep iterations small: plan → implement → validate → summarize.
- Use the narrowest validation that proves the change.
- Before compaction, handoff, or stopping work, summarize goal, current state, changed files, validation, blockers, and next step.
- Store durable lessons with supermemory when useful. Never store secrets, tokens, personal data, or sensitive raw logs.
- Forge worktree logging is enabled for loop history. Compaction keeps the custom prompt enabled.

## Professional AI Coding Workflows

### Specification-Driven Development (SDD)

Use SDD for new features, architecture changes, or any work with non-trivial scope.

Flow:
1. **Specify** — objective, scope, non-goals, acceptance criteria, risks.
2. **Clarify** — ask only blocking questions; otherwise pick the smallest safe default.
3. **Plan** — split into atomic tasks with validation for each.
4. **Implement** — one task at a time, smallest diff first.
5. **Validate** — tests, lint, type checks, security checks, or walkthrough as appropriate.
6. **Evidence** — changed files, validation results, blockers, next step.

Default level: **spec-anchored**. Specs guide the work, tests enforce the result, code remains maintainable by humans.

### Multi-Agent Orchestration

Use the simplest orchestration that works:

1. **Single agent** — default for small fixes.
2. **Supervisor** — one agent coordinates focused subagents; use for medium tasks.
3. **Orchestrator-workers** — plan/build/review split; use for larger features.
4. **Evaluator-optimizer** — one agent builds, another critiques; use for quality/security-sensitive work.
5. **Swarm** — only for broad research or ambiguous architecture; avoid for routine coding.

Subagents receive narrow tasks, exact files when known, expected output, and validation commands.

### Security-Driven Development

Treat AI-generated code as untrusted until checked.

Minimum gates by risk:
- Low risk: lint/typecheck or focused test.
- Medium risk: tests + review + secret check.
- High risk (auth, payments, data access, shell, crypto): tests + SAST + human approval.

Prefer deterministic tools first: Ruff, typecheckers, Semgrep, CodeQL, tests. LLM review is advisory, not a replacement for gates.

### Context Architecture

Use three tiers:

1. **Hot context** — this CLAUDE.md, project ADEV.md, active plan.
2. **Warm context** — project skills, subagents, session handoffs, supermemory/opencode-mem.
3. **Cold context** — MCPs: Context7 docs, GitHub, browser, databases, security tools.

Do not dump whole repos into context. Retrieve the smallest working set, then expand only when evidence says it is needed.

## Workspace and Safety Rules

- Operate inside the current project workspace. Do not read or change files outside it unless the user explicitly names a path.
- Never commit, push, force-push, or delete branches without explicit user confirmation. Suggest the command and wait for "yes".
- Never execute destructive shell commands (`rm -rf`, `git reset --hard`, `git branch -D`, `git push --force`) without explicit user confirmation and a one-line reason.
- Never print secrets, tokens, or credentials. Do not write them to files, logs, or commits.
- An explicit user instruction to break a safety rule only relaxes that specific action for that specific call. It does not rewrite the rules above. If the action is destructive or cross-boundary, still summarize what will happen and wait for confirmation.

## Available MCPs

- **context7** — current library docs
- **github** — repos, PRs, issues, code search (needs `GITHUB_TOKEN`)
- **playwright** — browser automation and E2E
- **gh_grep** — public GitHub code search, no auth
- **sequential-thinking** — extended reasoning for hard problems
- **semgrep** — SAST, disabled by default; enable per project
- **postgres** — read-only DB, disabled by default; enable per project

## Available Skills

- `@adev` — A-Dev methodology, SDD, baseline, evidence, handoff
- `@tdd` — red-green-refactor
- `@python-pro`, `@fastapi-expert`, `@rag-architect`, `@typescript-pro`
- `@security-auditor`, `@playwright-expert`, `@game-developer`
- `@caveman*`, `@cavecrew` — compressed communication and delegation

## Available Commands

- `/common-ground` — surface and track project assumptions before working
- Caveman slash commands for compressed interaction
