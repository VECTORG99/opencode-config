# Third-Party Notices

This repository is a portable OpenCode configuration bundle. Some files are
copied or adapted from external projects. Their original licenses and upstream
repositories remain authoritative.

## External projects referenced

| Project | Upstream | Included / referenced |
|---|---|---|
| Ponytail | https://github.com/DietrichGebert/ponytail | Referenced as local OpenCode plugin path installed by `install.sh` |
| Caveman | https://github.com/JuliusBrussee/caveman | OpenCode plugin, commands, and skills copied into `.config/opencode/` |
| A-Dev | https://github.com/scanalesespinoza/adev | `@adev` skill and copied `ADEV.md`; source clone installed by `install.sh` |
| Defending Code Reference Harness | https://github.com/anthropics/defending-code-reference-harness | Security methodology inspiration; not vendored in this repo |
| OpenCode Skill Creator | OpenCode skill/plugin ecosystem | Skill files copied from local OpenCode skill installation |
| TDD skill | OpenCode skill ecosystem | Skill files copied from local OpenCode skill installation |
| python-pro, fastapi-expert, rag-architect, security-auditor, playwright-expert, typescript-pro, game-developer | https://github.com/Axel-DaMage/opencode-config (config bundle) / https://github.com/Jeffallan (original skill author) | Skills adapted from upstream under MIT |
| common-ground command | https://github.com/Axel-DaMage/opencode-config | Command adapted from upstream |
| tui.json | https://github.com/Axel-DaMage/opencode-config | TUI config adapted: sound/volume off by default |

## NPM / MCP packages configured

These packages are not vendored. OpenCode/Bun/npx fetch them on demand:

- `opencode-rules`
- `opencode-supermemory`
- `opencode-antigravity-auth`
- `opencode-agent-browser`
- `opencode-skill-creator`
- `opencode-nanobanana`
- `envsitter-guard`
- `cc-safety-net`
- `opencode-forge`
- `opencode-mem`
- `opencode-notify`
- `opencode-review-helper`
- `opencode-log-sanitizer`
- `oh-my-opencode-slim`
- `@playwright/mcp`
- `@modelcontextprotocol/server-postgres`
- `@modelcontextprotocol/server-sequential-thinking`
- GitHub MCP Docker image: `ghcr.io/github/github-mcp-server`
- Semgrep MCP Docker image: `semgrep/mcp-server`
- Remote MCP endpoint: `https://mcp.grep.app` (gh_grep)
- Remote MCP endpoint: `https://mcp.context7.com/mcp` (Context7)

## Public safety policy

- No API keys, OAuth files, auth databases, cache directories, logs, or tokens are included.
- Secrets must be provided by environment variables, e.g. `GITHUB_TOKEN`.
- Project-specific overrides in `examples/` are examples, not private project data.
