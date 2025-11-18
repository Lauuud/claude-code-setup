---
name: implement
description: Phase 3 - Execute specific phase of approved plan
---

# Implement Command (Phase 3)

## Purpose

Execute a specific phase of the approved plan with real-time task tracking.

## Usage

```bash
/implement [phase-X]
```

**Examples**:
```bash
/implement phase-1
/implement phase-2
/implement phase-1 --no-commit  # Skip auto-commit
```

## What This Command Does

1. Finds active session directory
2. Loads context: `plan.md`, `best-practices.md`, `tasks.md`
3. Identifies tasks for specified phase
4. For each task:
   - Updates tasks.md: ⏳ → 🔄 → ✅
   - Implements following best practices
   - Logs decisions in Decision Log
5. After phase: Updates session-notes.md, suggests next phase
6. (Optional) Auto-commits phase completion

## Your Task

When user runs `/implement [phase-X]`:

### Step 1: Find Active Session

Look for most recent session directory:

```bash
ls -t dev/sessions/ | head -1
```

If no session directory:
```
❌ No session found. Run /new-session first.
```

### Step 2: Load Context Files

Read from session directory:
- `requirement.md` - Original requirements and acceptance criteria
- `plan.md` - Understand phase objectives and validation gates
- `best-practices.md` - Patterns and examples to follow
- `tasks.md` - Task list for this phase

If any critical file missing:
```
❌ Missing required files. Run /research and /plan first.
```

### Step 3: Identify Phase Tasks

Parse `tasks.md` to find tasks for specified phase:

```markdown
## Phase 1: Backend - Activity Model & API

- [ ] ⏳ Create Activity model (backend/models/activity.py)
  Acceptance: Model has id, user_id (FK), action, resource, timestamp fields

- [ ] ⏳ Add migration for activity table
  Acceptance: Migration creates activity table with indexes
```

Count tasks: `{N} tasks in Phase {X}`

### Step 4: Execute Tasks Sequentially

For each task in the phase:

#### 4a. Mark Task In Progress

Update `tasks.md`:
```markdown
- [x] 🔄 Create Activity model (backend/models/activity.py)
```

#### 4b. Implement Task

Follow patterns and requirements:
- Check acceptance criteria from `requirement.md`
- Use project patterns from `best-practices.md` (if documented)
- Follow external best practices
- Meet task acceptance criteria from `tasks.md`

Create/modify files as needed.

#### 4c. Mark Task Complete

Update `tasks.md`:
```markdown
- [x] ✅ Create Activity model (backend/models/activity.py)
```

#### 4d. Log Decisions (if applicable)

Add to Decision Log in `tasks.md`:

```markdown
## Decision Log

[2025-11-18 14:30] Used SQLModel instead of Pydantic BaseModel for Activity
Reason: Needed database table generation, not just validation
Alternatives considered: Pydantic with separate table definition
Impact: Simpler code, table auto-generated from model
```

### Step 5: Validate Phase Completion

After all tasks complete, check validation gates from `plan.md`:

```markdown
**Validation Gates**:
- [ ] Migration runs successfully
- [ ] Endpoint returns 200 with empty array
- [ ] Pagination works (test with ?offset=10&limit=5)
```

For each gate:
- Run verification command
- Report result
- Note any failures

### Step 6: Update Session Notes

Update `dev/sessions/YYYY-MM-DD-{feature}/session-notes.md`:

```markdown
## Progress

- [x] Phase 1: Understanding ✅
- [x] Phase 2: Planning ✅
- [x] Phase 3: Implementation - Phase 1 ✅
- [ ] Phase 3: Implementation - Phase 2
- [ ] Phase 4: Validation

### 2025-11-18 - Phase 1 Complete

Implemented backend activity model and API:
- Created Activity SQLModel
- Added migration with indexes
- Created GET /api/users/me/activity endpoint
- Implemented pagination (offset/limit)
- Added activity logging middleware

Validation:
✅ Migration runs successfully
✅ Endpoint tested with curl (returns 200)
✅ Pagination works

Decision: Used UTC for timestamps (API serves multiple timezones)

Next: /implement phase-2
```

### Step 7: Auto-Commit (Optional)

If `--no-commit` flag NOT present and git repo exists:

```bash
git add .
git commit -m "feat({feature}): complete Phase {N} - {phase name}

Phase {N}: {phase name}
- {task 1 summary}
- {task 2 summary}
- {task N summary}

Tasks: {completed}/{total} completed
See dev/sessions/YYYY-MM-DD-{feature}/tasks.md"
```

### Step 8: Report Success

Output to user:

```
✅ Phase {N} complete! {completed}/{total} tasks

Validation:
{validation results from gates}

Files created/modified:
- {file 1}
- {file 2}
- {file N}

Decisions logged:
- {decision 1}
- {decision 2}

Committed: {commit hash} (or "Skipped: --no-commit flag")

Next steps:
- Verify implementation manually if needed
- When ready: /implement phase-{N+1}
- Or validate now: /validate
```

## Example Flow

```bash
# User runs:
/implement phase-1

# You load context
# You identify 5 tasks in Phase 1

✅ Phase 1 complete! 5/5 tasks

Tasks completed:
✅ Create Activity model (backend/models/activity.py)
✅ Add migration (backend/migrations/003_activity.py)
✅ Create endpoint (backend/routes/activity.py)
✅ Add pagination (backend/routes/activity.py:25-40)
✅ Add middleware (backend/middleware/activity_logger.py)

Validation gates:
✅ Migration runs: alembic upgrade head (success)
✅ Endpoint works: curl /api/users/me/activity (200 OK)
✅ Pagination: tested ?offset=10&limit=5 (correct slice)

Decisions logged:
- Used UTC for Activity.timestamp (API multi-timezone)
- Index on user_id for fast queries

Committed: abc123f

Next steps:
1. Manual test: Login and check activity endpoint
2. When ready: /implement phase-2
```

## Notes

- Only ONE task should be 🔄 at a time
- Mark ✅ immediately after completing each task
- Log significant decisions (not trivial ones)
- Validation gates help ensure phase is truly complete
- Auto-commit is per-phase (not per-task)
- Can override with `--no-commit` for manual control
- Update session-notes.md before finishing
