#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.local/share"

if [ ! -d "$HOME/.local/share/ponytail/.git" ]; then
  git clone https://github.com/DietrichGebert/ponytail.git "$HOME/.local/share/ponytail"
fi

if [ ! -d "$HOME/.local/share/adev/.git" ]; then
  git clone https://github.com/scanalesespinoza/adev.git "$HOME/.local/share/adev"
fi

mkdir -p "$HOME/.config/opencode"
cp -R "$root/.config/opencode/." "$HOME/.config/opencode/"
python3 - <<'PY'
from pathlib import Path
import os

p = Path.home() / ".config/opencode/opencode.json"
text = p.read_text()
p.write_text(text.replace("__HOME__", str(Path.home())))
PY

echo "OpenCode config installed. Restart OpenCode."
echo "If using GitHub MCP, set GITHUB_TOKEN in Fish: set -Ux GITHUB_TOKEN <token>"
