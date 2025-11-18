---
name: validate
description: Phase 4 - Launch reviewer agent to validate implementation
---

# Validate Command (Phase 4)

## Purpose

Launch the reviewer agent to review implementation against plan and standards.

## Usage

```bash
/validate
```

(No arguments - validates current session's implementation)

## What This Command Does

1. Finds active session directory
2. Verifies `plan.md` and `tasks.md` exist
3. Launches **reviewer** agent with:
   - Path to plan.md (what was planned)
   - Path to tasks.md (what was completed)
   - Session directory path
4. Agent creates `review-report.md`
5. Returns summary to user

## Your Task

When user runs `/validate`:

### Step 1: Find Active Session

Look for most recent session directory:

```bash
ls -t dev/sessions/ | head -1
```

If no session directory:
```
❌ No session found. Run /new-session first.
```

### Step 2: Verify Prerequisites

Check that required files exist:

```bash
test -f dev/sessions/YYYY-MM-DD-{feature}/requirement.md
test -f dev/sessions/YYYY-MM-DD-{feature}/plan.md
test -f dev/sessions/YYYY-MM-DD-{feature}/tasks.md
```

If missing:
```
❌ Missing requirement.md, plan.md, or tasks.md. Run /research and /plan first.
```

### Step 3: Launch Reviewer Agent

Use the Task tool to launch reviewer agent:

```
Agent: reviewer
Prompt:
"Review implementation against original requirements, plan, and coding standards.

Session directory: dev/sessions/YYYY-MM-DD-{feature}/

Your task:
1. Read requirement.md (what user wanted)
2. Read plan.md (what was planned)
3. Read tasks.md (what was completed)
4. Read implemented code files (from tasks)
5. Check requirements adherence (User's Desire met?)
6. Check plan adherence (phases complete?)
7. Security review (auth, validation, XSS, errors)
8. Code quality review (error handling, edge cases, standards)
9. Performance review (indexes, N+1 queries, optimization)
10. Create review-report.md with:
    - Requirements Adherence (from requirement.md)
    - Critical Issues (fix now)
    - Warnings (fix before merge)
    - Suggestions (optional)
    - Plan adherence checklist
    - Verification commands

Use template from .claude/docs/templates/review-report-template.md

Be specific: include file:line references and clear fix instructions.
Validate that technical implementation matches Technical Mapping from requirement.md."
```

### Step 4: Report When Complete

After reviewer agent completes, summarize findings:

```
✅ Review complete
📄 See: dev/sessions/YYYY-MM-DD-{feature}/review-report.md

Summary:
🚨 {N} critical issue(s) (fix now)
⚠️  {M} warning(s) (fix before merge)
💡 {K} suggestion(s) (optional)

Critical issues:
{- Brief description of each critical issue}

Warnings:
{- Brief description of each warning}

Plan adherence:
✅ Phase 1: Complete
✅ Phase 2: Complete
⚠️ Phase 3: Partial (2 tasks incomplete)
⏳ Phase 4: Not started

Next steps:
{If critical issues:}
1. Fix critical issues immediately
2. Re-run /validate to verify fixes

{If only warnings:}
1. Review warnings in review-report.md
2. Fix before merging to main
3. Re-run /validate after fixes

{If no issues:}
✅ Implementation ready!
- All phases complete
- No critical issues or warnings
- {K} optional suggestions available
```

## Example Flow

```bash
# User runs:
/validate

# You launch reviewer agent
# Agent reads plan, tasks, code files
# Agent creates review-report.md

# You report:
✅ Review complete
📄 See: dev/sessions/2025-11-18-user-dashboard/review-report.md

Summary:
🚨 1 critical issue (fix now)
⚠️  2 warnings (fix before merge)
💡 3 suggestions (optional)

Critical issues:
- backend/routes/activity.py:25 - Missing @require_auth decorator

Warnings:
- backend/routes/activity.py:35 - No try/except around DB query
- components/ActivityFeed.vue:45 - Missing empty state handling

Suggestions:
- backend/models/activity.py:12 - Add index on user_id
- components/ActivityFeed.vue:20 - Add loading skeleton
- backend/routes/activity.py:40 - Consider caching frequently accessed data

Plan adherence:
✅ Phase 1: Backend complete
✅ Phase 2: Frontend complete
✅ Phase 3: Tracking complete
⚠️ Phase 4: Polish partial (missing empty state from plan)

Next steps:
1. Fix critical issue (add @require_auth)
2. Fix warnings before merge
3. Re-run /validate after fixes
4. Consider optional suggestions
```

## Notes

- Reviewer REPORTS issues, doesn't fix them
- User decides which issues to fix
- Can re-run /validate after fixes to verify
- Critical issues MUST be fixed (security, data loss, broken functionality)
- Warnings SHOULD be fixed (UX, maintainability)
- Suggestions are OPTIONAL (performance, style)
- Review includes specific file:line references
- Review includes verification commands to run
