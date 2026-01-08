#!/bin/bash
# Hook: Prevent initialization of template repos
# This runs before Claude edits files
#
# Exit codes:
#   0 = allow the operation
#   2 = block the operation (message shown to Claude)

# Get the file being edited from stdin (JSON input)
INPUT=$(cat)

# Extract file path from the tool input
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // ""' 2>/dev/null)

# Get repo name from git
REPO_NAME=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null)

# If editing CLAUDE.md in a repo named "issueops"
if [[ "$FILE_PATH" == *"CLAUDE.md"* ]] && [[ "$REPO_NAME" == "issueops" ]]; then
  # Check if the edit removes template placeholders or the setup comment
  OLD_CONTENT=$(echo "$INPUT" | jq -r '.tool_input.old_string // ""' 2>/dev/null)
  
  # Block if trying to replace the placeholders with actual content
  if [[ "$OLD_CONTENT" == *"{{PROJECT_NAME}}"* ]] || [[ "$OLD_CONTENT" == *"{{PROJECT_DESCRIPTION}}"* ]]; then
    echo "BLOCKED: This is the IssueOps template repository." >&2
    echo "The {{PROJECT_NAME}} and {{PROJECT_DESCRIPTION}} placeholders must remain as template variables." >&2
    echo "They get replaced when someone creates a new project FROM this template." >&2
    exit 2
  fi
  
  # Block if trying to remove the first-run instructions
  if [[ "$OLD_CONTENT" == *"FIRST-RUN SETUP INSTRUCTIONS"* ]]; then
    echo "BLOCKED: Cannot remove the first-run setup instructions from the template." >&2
    exit 2
  fi
fi

# Allow the operation
exit 0
