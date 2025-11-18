# Hooks

Brief explanation of the hook system. See CLAUDE.md for complete documentation.

## What Are Hooks?

Hooks are shell commands that execute automatically in response to events (like submitting a prompt).

## Available Hooks

### UserPromptSubmit

**Trigger**: Before Claude sees your prompt
**Purpose**: Auto-activate skills based on keywords/patterns
**Script**: `skill-reminder.sh`

**How it works**:
1. You type a prompt
2. Hook intercepts prompt before Claude sees it
3. Checks prompt against `skill-rules.json` triggers
4. If match found: Injects skill reminder into context
5. Claude sees reminder + your prompt
6. Claude activates appropriate skill

## Configured Hooks

**Location**: `.claude/settings.json`

```json
{
  "hooks": {
    "UserPromptSubmit": {
      "command": "bash .claude/hooks/skill-reminder.sh"
    }
  }
}
```

## skill-reminder.sh

Simple bash script that:
- Reads your prompt from stdin
- Checks for keywords from `skill-rules.json`
- Outputs skill reminder if match found

**Example**:
```
Input: "Create a new skill for Vue patterns"
Output: "🎯 SKILL SUGGESTION: Consider using skill-developer skill"
```

---

**For full details**: See `/path/to/project/CLAUDE.md` section "Skills Auto-Activation"
