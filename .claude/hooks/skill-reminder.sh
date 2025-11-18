#!/bin/bash

# Skill Reminder Hook
# Intercepts user prompts and suggests relevant skills based on keywords

# Read user prompt from stdin
USER_PROMPT=$(cat)

# Path to skill-rules.json
SKILL_RULES=".claude/skills/skill-rules.json"

# Check if skill-rules.json exists
if [ ! -f "$SKILL_RULES" ]; then
    # No skill rules, pass through prompt unchanged
    echo "$USER_PROMPT"
    exit 0
fi

# Extract keywords from skill-rules.json and check if any match the prompt
# This is a simple grep-based implementation
# For more complex pattern matching, upgrade to TypeScript hook

MATCHED_SKILLS=""

# Check for skill-developer keywords
if echo "$USER_PROMPT" | grep -qiE "(create skill|add skill|new skill|skill system|skill-rules\.json|skill activation|manage skills)"; then
    MATCHED_SKILLS="${MATCHED_SKILLS}skill-developer "
fi

# If skills matched, inject reminder
if [ -n "$MATCHED_SKILLS" ]; then
    echo "🎯 SKILL SUGGESTION: Consider using these skills: $MATCHED_SKILLS"
    echo ""
    echo "---"
    echo ""
fi

# Output original prompt
echo "$USER_PROMPT"
