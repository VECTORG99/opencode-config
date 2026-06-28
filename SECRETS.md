# Secrets Setup

This repository contains no secrets. Configure secrets locally with environment
variables.

## Required for GitHub MCP

`GITHUB_TOKEN` enables GitHub MCP access to repositories, issues, PRs, and code
search.

Fish:

```fish
set -Ux GITHUB_TOKEN "your_github_token"
```

Or via GitHub CLI:

```fish
gh auth login
set -Ux GITHUB_TOKEN (gh auth token)
```

Verify without printing the token:

```fish
test -n "$GITHUB_TOKEN"; and echo set; or echo missing
gh auth status
```

## Optional: opencode-mem auto-capture

Auto-capture is disabled by default. To enable it, configure an external LLM API
key and edit `~/.config/opencode/opencode-mem.jsonc`.

Example with OpenAI:

```fish
set -Ux OPENAI_API_KEY "your_openai_key"
```

Then set:

```jsonc
"autoCaptureEnabled": true,
"memoryProvider": "openai-chat",
"memoryModel": "gpt-4o-mini",
"memoryApiUrl": "https://api.openai.com/v1",
"memoryApiKey": "env://OPENAI_API_KEY"
```

Alternatives:

- `ANTHROPIC_API_KEY` for Anthropic
- `GROQ_API_KEY` for Groq/OpenAI-compatible endpoints

## Optional: Postgres MCP

Use a read-only database user.

Example connection string:

```text
postgresql://readonly_user:REPLACE_ME@localhost:5432/database_name
```

Do not commit database URLs with real passwords.

## Optional: Semgrep Cloud

Local Semgrep Docker use does not need a token. Semgrep Cloud does:

```fish
set -Ux SEMGREP_APP_TOKEN "your_semgrep_token"
```
