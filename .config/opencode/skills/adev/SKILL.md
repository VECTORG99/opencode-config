---
name: adev
description: Augmented Development A-Dev methodology. Use when the user says adev, A-Dev, augmented development, baseline, 50/50 quality, evidence, handoff, decision log, or wants disciplined AI-assisted delivery across projects.
---

# A-Dev: Augmented Development

Use A-Dev as the operating method for AI-assisted delivery.

## Source of truth

- Local upstream clone: `$HOME/.local/share/adev/`
- Full rules for this skill: `ADEV.md` in this skill directory
- Starter kit: `$HOME/.local/share/adev/starter-kit/`

## Operating flow

1. Read project `ADEV.md` first when present.
2. Work in small iterations: plan → implementation → validation → evidence.
3. Keep scope atomic: do not mix feature, refactor, docs, infra, and release work unless explicitly requested.
4. Validate with the narrowest check that proves the change.
5. End work with evidence: changed files, validation, blockers, next step.

## Baseline rule

Every failure worth remembering becomes one durable asset: guardrail, checklist item, decision log entry, test, or reusable rule.

## Context persistence

Before compaction, handoff, or stopping work, summarize:

- goal
- current state
- changed files
- validation results
- known blockers
- next command or next decision

Store durable lessons with supermemory when useful. Do not store secrets, tokens, personal data, raw logs with sensitive values, or private client details.

## SDD integration

When the user asks for SDD, specs, architecture, limits, or professional AI coding flow, apply:

1. Specify
2. Clarify
3. Plan
4. Implement
5. Validate
6. Evidence

Default to spec-anchored development: the spec guides the work, tests enforce behavior, and code remains human-maintainable.

Use EARS-style acceptance criteria when requirements are ambiguous:

- When [event], the system shall [response].
- Given [state], when [event], then [outcome].

## Agentic workflow rule

Start with one agent. Add subagents only when the task needs a different skill or independent review. Swarms are last resort, not default.
