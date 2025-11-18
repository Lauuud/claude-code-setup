---
name: plan
description: Phase 2 - Launch planner agent to create implementation plan
---

# Plan Command (Phase 2)

## Purpose

Launch the planner agent to create a strategic implementation plan with research.

## Usage

```bash
/plan
```

(No arguments - reads from current session's `requirement.md` and `current_state.md`)

## What This Command Does

1. Finds active session directory
2. Verifies `requirement.md` exists (mandatory)
3. Checks if `current_state.md` exists (optional for greenfield)
4. Launches **planner** agent with:
   - Path to requirement.md (what to build)
   - Path to current_state.md if exists (existing patterns)
   - Session directory path
5. Agent creates: `plan.md`, `best-practices.md`, `tasks.md`
6. Returns summary to user

## Your Task

When user runs `/plan`:

### Step 1: Find Active Session

Look for most recent session directory:

```bash
ls -t dev/sessions/ | head -1
```

If no session directory found:
```
❌ No session found. Run /new-session {feature-name} first.
```

### Step 2: Verify Prerequisites

Check that `requirement.md` exists (mandatory):

```bash
test -f dev/sessions/YYYY-MM-DD-{feature-name}/requirement.md
```

If not found:
```
❌ No requirement.md found. Run /research first.
```

Check if `current_state.md` exists (optional for greenfield):

```bash
test -f dev/sessions/YYYY-MM-DD-{feature-name}/current_state.md
```

If not found:
```
ℹ️  No current_state.md (greenfield feature - no existing patterns)
```

### Step 3: Launch Planner Agent

Use the Task tool to launch planner agent:

```
Agent: planner
Prompt:
"Create implementation plan for this feature.

Session directory: dev/sessions/YYYY-MM-DD-{feature-name}/

Your task:
1. Read requirement.md (WHAT to build - source of truth)
2. Read current_state.md if exists (WHAT patterns exist to reuse)
3. Determine if greenfield (0→1) or addition (1→N)
4. Launch sub-agents for research:
   - If 1→N: Codebase Pattern Analyzer (already partially done in current_state.md)
   - Always: Best Practice Researcher
5. Synthesize plan using:
   - Requirements from requirement.md
   - Existing patterns from current_state.md (if 1→N)
   - Best practices from research
6. Create 3 files:
   - plan.md (strategic phases referencing requirement.md)
   - best-practices.md (research + existing patterns)
   - tasks.md (granular breakdown)

Use templates from .claude/docs/templates/"
```

### Step 4: Report When Complete

After planner agent completes:

```
✅ Plan created with {N} phases, {M} tasks

📄 Files created:
   - plan.md (strategic phases + dependencies)
   - best-practices.md (research findings)
   - tasks.md (tactical checklist)

Summary:
- Phase 1: {phase 1 name} ({complexity})
- Phase 2: {phase 2 name} ({complexity})
- Phase 3: {phase 3 name} ({complexity})
- Phase 4: {phase 4 name} ({complexity})

Next steps:
1. Review plan.md (strategic approach)
2. Review best-practices.md (examples to follow)
3. Review tasks.md (detailed checklist)
4. When ready: /implement phase-1
```

## Example Flow

```bash
# User runs:
/plan

# You launch planner agent
# Agent reads current_state.md, researches, creates 3 files

# You report:
✅ Plan created with 4 phases, 22 tasks

📄 Files created:
   - plan.md (strategic phases + dependencies)
   - best-practices.md (research findings + examples)
   - tasks.md (22 tasks across 4 phases)

Summary:
- Phase 1: Backend - Activity Model & API (Medium, 2-3 hours)
- Phase 2: Frontend - Dashboard Page (Medium, 2-3 hours)
- Phase 3: Activity Tracking Integration (Low, 1-2 hours)
- Phase 4: Polish & Optimization (Low, 1-2 hours)

Risks identified:
- Activity table growth (mitigation: cleanup job)
- N+1 query problem (mitigation: pagination)

Next steps:
1. Review plan.md for strategic approach
2. Check best-practices.md for examples to follow
3. Review tasks.md for full task breakdown
4. Approve plan, then: /implement phase-1
```

## Notes

- Planner should launch sub-agents for research
- Best practice researcher always runs
- Codebase pattern analyzer only runs if similar code exists (1→N)
- plan.md has big picture, tasks.md has granular tasks
- User should review all 3 files before implementing
- Planning happens before any code is written
