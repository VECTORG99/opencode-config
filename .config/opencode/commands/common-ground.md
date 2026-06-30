---
description: Surface and validate hidden assumptions about the project before working
agent: build
---

# Common Ground

**Arguments:** $ARGUMENTS

Surface assumptions the agent holds about the project, classify them, and store a shared "common ground" file for later validation.

## Modes

| Flag | Mode |
|------|------|
| (none) | Interactive surface and adjust |
| `--list` | Read-only view of tracked assumptions |
| `--check` | Quick validation of current assumptions |

## Project ID

1. Try `git remote get-url origin`. If present, use the URL.
2. Otherwise, use the absolute working directory path.

Store ground files under `~/.config/opencode/common-ground/{project_id}/COMMON-GROUND.md`.

## Default Mode

1. Analyze config files, recent conversation, and existing ground file.
2. Classify assumptions:
   - **technical** — tech stack, framework versions, patterns
   - **process** — testing, CI, commit conventions, branching
   - **domain** — business rules, user expectations
3. Present assumptions grouped by category. Ask the user which to track.
4. Assign a tier to each:
   - **ESTABLISHED** — high confidence, backed by evidence
   - **WORKING** — medium confidence, in use but not confirmed
   - **OPEN** — needs validation
5. Let the user adjust tiers.
6. Write `COMMON-GROUND.md` and `ground.index.json`.

## --list Mode

Load the ground file and display assumptions grouped by tier. Read-only.

## --check Mode

1. Load the ground file.
2. Ask if assumptions are still valid.
3. If all valid: update `last_validated`.
4. If some need updates: enter tier adjustment.
5. If no file: start default mode.

## Output

```
## Common Ground Complete

**Project:** {project_name}
**Tracked Assumptions:** {count}

### Summary
- ESTABLISHED: {count}
- WORKING: {count}
- OPEN: {count}

**Ground file:** ~/.config/opencode/common-ground/{project_id}/COMMON-GROUND.md
```

## Constraints

### MUST DO

- Identify the project before any file operation.
- Use `question` for interactive selections.
- Write both human-readable and machine-readable files.
- Include timestamps.
- Preserve assumption type for audit trail.

### MUST NOT DO

- Assume context without surfacing assumptions.
- Proceed without user confirmation on tier changes.
- Overwrite the ground file without preserving history.
- Store secrets, tokens, or personal data in ground files.