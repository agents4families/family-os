#!/usr/bin/env bash
# Wires the canonical folders (skills/, agents/) into each tool's expected location.
# Run from the Family-OS folder:  bash scripts/link-tools.sh
# Default is symlinks. Use --copy if your folder is in a synced drive that doesn't preserve symlinks.
# Re-run with --copy after you edit skills or agents (copies don't update themselves).

set -euo pipefail
MODE="link"
[[ "${1:-}" == "--copy" ]] && MODE="copy"

link_or_copy () {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  rm -rf "$dest"
  if [[ "$MODE" == "link" ]]; then
    ln -s "$(cd "$(dirname "$src")" && pwd)/$(basename "$src")" "$dest"
  else
    cp -R "$src" "$dest"
  fi
  echo "  $dest  ($MODE)"
}

echo "Claude Code / Claude desktop:"
link_or_copy skills .claude/skills
link_or_copy agents .claude/agents

echo "Other agent tools that read an .agents/ convention:"
link_or_copy skills .agents/skills

echo
echo "Instruction files already in place:"
for f in AGENTS.md CLAUDE.md GEMINI.md; do [[ -f "$f" ]] && echo "  $f"; done

echo
echo "Done. Cursor, Codex, and Copilot read AGENTS.md directly."
echo "Gemini CLI: set its context file name to AGENTS.md, or keep GEMINI.md."
