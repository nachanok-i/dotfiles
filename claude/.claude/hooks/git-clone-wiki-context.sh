#!/bin/bash
# Injects knowledge-wiki context when a Claude session runs inside ~/Documents/git_clone/.
# UserPromptSubmit hook — stdout becomes context (registered in ~/.claude/settings.json as
# bash ~/.claude/hooks/git-clone-wiki-context.sh). Lives in dotfiles/claude and is stowed
# to ~/.claude/hooks/ — edit it here in the dotfiles repo.

GIT_CLONE_ROOT="$HOME/Documents/git_clone"
[[ "$PWD" == "$GIT_CLONE_ROOT"* ]] || exit 0

SERVICE="$(basename "$(git rev-parse --show-toplevel 2>/dev/null || echo "$PWD")")"
WIKI="${FOUNDER_WIKI:-$HOME/Documents/founder-wiki}"

# The capture op ships with founder-skill once promoted; until then, fall back gracefully.
if [ -e "$HOME/.claude/commands/wiki-capture.md" ]; then
  CAPTURE="proactively offer /wiki-capture to file it into the wiki"
else
  CAPTURE="proactively offer to note it for the wiki (capture op not installed yet; a /repo-ingest refresh also picks up code-level changes)"
fi

echo "[git_clone session: ${SERVICE:-unknown}] The team knowledge wiki is at $WIKI. For questions about documented services, the wiki-query skill answers from it with citations. When this session uncovers NEW technical knowledge — service behavior, env vars, DB schema, cross-service calls, patterns, decisions, bug root causes — $CAPTURE."
