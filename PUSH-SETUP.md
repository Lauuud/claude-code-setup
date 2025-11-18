# Push Claude Setup Instructions

## Purpose
Push **Claude setup improvements** to the reusable template repository that can be cloned for new projects.

## Target Repository
**Remote**: `claude-setup`
**URL**: https://github.com/Lauuud/claude-code-setup.git

## What Gets Pushed
Claude configuration files and documentation:
- `.claude/` directory (agents, commands, skills, hooks, templates)
- `CLAUDE.md` (complete workflow documentation)
- `README.md` (GitHub repository landing page)
- `PUSH-PROJECT.md` and `PUSH-SETUP.md` (these instruction files)

**Note**: While this pushes the entire git state, this repository is specifically for the **reusable Claude setup template**, not project-specific code.

## When to Use
- Improved agent prompts (analyzer, planner, reviewer)
- Added or refined slash commands
- Created new skills or updated skill-rules.json
- Enhanced hook functionality
- Updated documentation in CLAUDE.md
- Want these improvements available for future projects

## Commands to Execute

```bash
# Check current status
git status

# Add changes (if not already staged)
git add .claude/ CLAUDE.md README.md PUSH-*.md

# Commit changes (if not already committed)
git commit -m "Your commit message describing setup improvements"

# Push to claude-setup repository
git push claude-setup main
```

## Quick Reference for Claude

When you tell Claude to "Load PUSH-SETUP.md and execute", Claude should:

1. Run `git status` to check what's changed
2. If there are uncommitted changes to Claude setup files:
   - Ask you for a commit message OR
   - Create an appropriate commit message based on setup improvements
3. Run `git add .claude/ CLAUDE.md README.md PUSH-*.md` and `git commit -m "message"`
4. Run `git push claude-setup main`
5. Confirm the push was successful

## Notes
- This pushes to your **reusable template** repository
- Future projects can clone this repo to get your improved setup
- This does NOT update your current project's main repository
- If you also want to backup the project, use `PUSH-PROJECT.md`

## Typical Workflow

```bash
# Scenario: You improved the planner agent prompt

# 1. Test the improvement in current project
# 2. Commit the change
git add .claude/agents/planner.md
git commit -m "improve: refine planner agent research process"

# 3. Push to template repo (use this file)
git push claude-setup main

# 4. Optionally push to project repo too
git push origin main
```

## Using in New Projects

After pushing improvements here, start a new project with:

```bash
git clone https://github.com/Lauuud/claude-code-setup.git my-new-project
cd my-new-project
# Your improved setup is now available!
```
