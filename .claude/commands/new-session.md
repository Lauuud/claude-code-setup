---
name: new-session
description: Initialize new feature session with folder structure and templates
---

# New Session Command

## Purpose

Initialize folder structure for a new feature development session.

## Usage

```bash
/new-session {feature-name}
```

**Example**:
```bash
/new-session user-dashboard
```

## What This Command Does

1. **Creates session directory**: `dev/sessions/YYYY-MM-DD-{feature-name}/`
2. **Copies templates** from `.claude/docs/templates/`:
   - `requirement-template.md` → `requirement.md`
   - `current_state-template.md` → `current_state.md`
   - `plan-template.md` → `plan.md`
   - `best-practices-template.md` → `best-practices.md`
   - `tasks-template.md` → `tasks.md`
   - `review-report-template.md` → `review-report.md`
3. **Creates session-notes.md** with initial structure

## Your Task

When user runs `/new-session {feature-name}`:

### Step 1: Get Today's Date

```bash
date +%Y-%m-%d
```

### Step 2: Create Directory Structure

```bash
mkdir -p "dev/sessions/YYYY-MM-DD-{feature-name}"
```

### Step 3: Copy Templates

Copy all 6 templates from `.claude/docs/templates/` to session directory:

```bash
cp .claude/docs/templates/requirement-template.md dev/sessions/YYYY-MM-DD-{feature-name}/requirement.md
cp .claude/docs/templates/current_state-template.md dev/sessions/YYYY-MM-DD-{feature-name}/current_state.md
cp .claude/docs/templates/plan-template.md dev/sessions/YYYY-MM-DD-{feature-name}/plan.md
cp .claude/docs/templates/best-practices-template.md dev/sessions/YYYY-MM-DD-{feature-name}/best-practices.md
cp .claude/docs/templates/tasks-template.md dev/sessions/YYYY-MM-DD-{feature-name}/tasks.md
cp .claude/docs/templates/review-report-template.md dev/sessions/YYYY-MM-DD-{feature-name}/review-report.md
```

### Step 4: Create session-notes.md

Create `dev/sessions/YYYY-MM-DD-{feature-name}/session-notes.md`:

```markdown
# Session: {feature-name}

**Date**: YYYY-MM-DD
**Status**: In Progress

## Goal

[Brief description of what this feature aims to achieve]

## Progress

- [ ] Phase 1: Research (requirement gathering & state analysis)
- [ ] Phase 2: Planning (implementation strategy)
- [ ] Phase 3: Implementation (coding)
- [ ] Phase 4: Validation (quality review)

## Current Phase

**Phase 1** - Research

## Notes

### YYYY-MM-DD

[Session notes go here as work progresses]

## Next Steps

1. Run `/research "describe what you want to achieve"`
2. Review and approve `requirement.md`
3. Review `current_state.md` if created
4. Proceed to `/plan` once ready

## Open Questions

[Questions that arise during development]

## Decisions Made

[Important decisions with rationale]
```

### Step 5: Report Success

Output to user:

```
✅ Session initialized: dev/sessions/YYYY-MM-DD-{feature-name}/

📁 Templates copied:
   - requirement.md
   - current_state.md
   - plan.md
   - best-practices.md
   - tasks.md
   - review-report.md

📝 Created session-notes.md

Next steps:
1. /research "what you want to achieve"
2. Review and approve requirement.md
3. /plan when ready

Session directory: dev/sessions/YYYY-MM-DD-{feature-name}/
```

## Notes

- Templates are copied (not referenced) so they can be filled in by agents
- Session directory includes date for easy chronological organization
- All 6 files are created even if not all will be used (some might be skipped)
- Feature name should be kebab-case (user-dashboard, not User Dashboard)

## Example

```bash
# User runs:
/new-session user-dashboard

# Creates:
dev/sessions/2025-11-18-user-dashboard/
├── session-notes.md (created fresh)
├── requirement.md (copied from template)
├── current_state.md (copied from template)
├── plan.md (copied from template)
├── best-practices.md (copied from template)
├── tasks.md (copied from template)
└── review-report.md (copied from template)
```
