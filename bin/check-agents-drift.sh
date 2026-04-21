#!/usr/bin/env bash
# Verify that agents/ and .claude/agents/ stay byte-identical.
#
# agents/            — read by the Claude Code plugin loader
#                       (/plugin install goodreason@softagram-plugins)
# .claude/agents/    — read by Claude Code when users copy the setup
#                       directly into their project (standalone path)
#
# Both paths must deliver the same agents. CI runs this on every PR;
# run it locally before committing agent-definition changes.

set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

if diff -r agents/ .claude/agents/ > /dev/null 2>&1; then
  echo "OK: agents/ and .claude/agents/ are in sync."
  exit 0
fi

echo "FAIL: agents/ and .claude/agents/ have drifted." >&2
echo >&2
diff -r agents/ .claude/agents/ >&2 || true
echo >&2
echo "To fix (pick the authoritative direction, then copy):" >&2
echo "  cp .claude/agents/*.md agents/          # propagate standalone to plugin" >&2
echo "  cp agents/*.md .claude/agents/          # propagate plugin to standalone" >&2
exit 1
