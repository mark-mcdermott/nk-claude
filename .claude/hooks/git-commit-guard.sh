#!/bin/bash
# .claude/hooks/git-commit-guard.sh
# Blocks commits with AI co-author attribution
#
# Exit codes:
#   0 = Allow (no issues)
#   1 = Non-blocking error
#   2 = BLOCKING (prevents tool execution)

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# Only check git commit commands
if echo "$COMMAND" | grep -q "git commit"; then
  # Check for Co-Authored-By patterns with AI tools
  if echo "$COMMAND" | grep -qiE "co-authored-by.*(claude|anthropic|cursor|copilot|gemini|openai|gpt|ai assistant)"; then
    cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "additionalContext": "BLOCKED: AI co-author attribution detected.\\n\\nRule: Never attribute LLM as co-author of git commits.\\nProject instructions override Claude Code defaults.\\n\\nFix: Remove the 'Co-Authored-By' line referencing AI tools."
  }
}
EOF
    exit 2
  fi
fi

exit 0
