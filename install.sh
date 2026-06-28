#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.config/opencode"
cp -R "$root/.config/opencode/." "$HOME/.config/opencode/"

echo "OpenCode config installed. Restart OpenCode."
echo "If using GitHub MCP, set GITHUB_TOKEN in Fish: set -Ux GITHUB_TOKEN <token>"
