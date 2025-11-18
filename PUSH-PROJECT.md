# Push Project Instructions

## Purpose
Push the **entire project** (Nuxt application + Claude setup files) to the main project repository.

## Target Repository
**Remote**: `origin`
**URL**: https://github.com/Lauuud/Nuxt-claude-setup.git

## What Gets Pushed
- All `.claude/` configuration files
- `CLAUDE.md` and `README.md` documentation
- Your Nuxt application code
- `dev/sessions/` work artifacts
- Everything tracked by git in this project

## When to Use
- Backing up your project work
- Saving progress on your Nuxt application
- Sharing the complete project with collaborators
- After completing a feature or making significant changes to the project

## Commands to Execute

```bash
# Check current status
git status

# Add changes (if not already staged)
git add .

# Commit changes (if not already committed)
git commit -m "Your commit message here"

# Push to project repository
git push origin main
```

## Quick Reference for Claude

When you tell Claude to "Load PUSH-PROJECT.md and execute", Claude should:

1. Run `git status` to check what's changed
2. If there are uncommitted changes:
   - Ask you for a commit message OR
   - Create an appropriate commit message based on changes
3. Run `git add .` and `git commit -m "message"`
4. Run `git push origin main`
5. Confirm the push was successful

## Notes
- This pushes to your **project-specific** repository
- This does NOT update the reusable Claude setup template
- If you also want to update the template, use `PUSH-SETUP.md`
