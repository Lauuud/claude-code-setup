# Claude Code Setup - Personal Development

## Quick Start

```bash
# Initialize new feature session
/new-session {feature-name}

# Phase 1: Research (two-step process)
/research "what you want to achieve"

# Phase 2: Create implementation plan
/plan

# Phase 3: Implement phase by phase
/implement phase-1
/implement phase-2

# Phase 4: Validate implementation
/validate
```

---

## Architecture Overview

### Directory Structure

```
project/
├── CLAUDE.md (this file)          # Complete guide - read this first
└── .claude/                        # Self-contained AI configuration
    ├── settings.json              # Permissions + hook config
    ├── agents/                    # 3 core agents
    │   ├── README.md             # Brief agent index
    │   ├── analyzer.md           # Phase 1 Step 2: Codebase analysis
    │   ├── planner.md            # Phase 2: Planning with sub-agents
    │   └── reviewer.md           # Phase 4: Quality validation
    ├── commands/                  # 5 workflow commands
    │   ├── README.md             # Brief command list
    │   ├── new-session.md        # Initialize session structure
    │   ├── research.md           # Phase 1: Two-step research process
    │   ├── plan.md               # Phase 2: Launch planner
    │   ├── implement.md          # Phase 3: Execute with context
    │   └── validate.md           # Phase 4: Launch reviewer
    ├── skills/                    # Auto-activated capabilities
    │   ├── skill-rules.json      # Activation triggers
    │   └── skill-developer/      # Meta-skill for skill creation
    ├── hooks/                     # Automation hooks
    │   ├── README.md             # Hook system explanation
    │   └── skill-reminder.sh     # Bash skill activator
    └── docs/
        └── templates/             # Session templates
            ├── requirement-template.md
            ├── current_state-template.md
            ├── plan-template.md
            ├── best-practices-template.md
            ├── tasks-template.md
            └── review-report-template.md
```

### Work Artifacts (Outside .claude/)

```
dev/sessions/YYYY-MM-DD-{task}/
├── session-notes.md              # Overall session tracking
├── requirement.md                # Phase 1 Step 1 output (requirements)
├── current_state.md              # Phase 1 Step 2 output (codebase analysis)
├── plan.md                       # Phase 2 output (strategic phases)
├── best-practices.md             # Phase 2 output (research findings)
├── tasks.md                      # Phase 2 output (tactical checklist)
└── review-report.md              # Phase 4 output (from reviewer)
```

**Key Principle**: `.claude/` contains reusable configuration, `dev/sessions/` contains work artifacts.

---

## Command Philosophy

This system implements a 4-phase development workflow that prevents jumping straight to implementation before understanding the problem:

### Phase 1: RESEARCH → `/research`
**Goal**: Gather requirements, then analyze current state

**Anti-pattern**: Immediately suggesting solutions or vague requirements
**Correct pattern**: Two-step process - clarify requirements first, then analyze codebase

### Phase 2: PLAN → `/plan`
**Goal**: Create strategic implementation plan with research

**Anti-pattern**: Vague "we'll figure it out" approach
**Correct pattern**: Phases, validation gates, risks identified, best practices incorporated

### Phase 3: IMPLEMENT → `/implement`
**Goal**: Execute approved plan phase by phase

**Anti-pattern**: Implementing everything at once
**Correct pattern**: Phase-by-phase with validation gates, real-time progress tracking

### Phase 4: VALIDATE → `/validate`
**Goal**: Verify implementation meets plan and standards

**Anti-pattern**: Shipping without review
**Correct pattern**: Critical/warning/suggestion levels, specific line references, verification commands

---

## Commands Detailed

### `/new-session {feature-name}`

**Purpose**: Initialize folder structure for new feature

**What it does**:
1. Creates `dev/sessions/YYYY-MM-DD-{feature-name}/`
2. Copies all templates from `.claude/docs/templates/`
3. Opens session-notes.md for initial context

**Example**:
```bash
/new-session user-dashboard

# Output:
# ✅ Session initialized: dev/sessions/2025-11-18-user-dashboard/
# 📁 Templates copied: current_state, plan, best-practices, tasks, review-report
# 📝 Next: /understand "what you want to achieve"
```

**When to use**: Start of every new feature or task

---

### `/research {goal}` - Phase 1

**Purpose**: Two-step process - gather requirements, then analyze current state

**What it does**:

#### Step 1: Requirement Gathering (always runs)
1. Engages user in conversational dialogue to clarify:
   - What they want (user's language)
   - Success criteria (user's perspective)
   - Technical terminology (validated against docs/MCP)
2. Creates `requirement.md` in session directory
3. Asks user to approve requirements

#### Step 2: Codebase Analysis (conditional)
1. Reads approved `requirement.md`
2. Determines if greenfield (0→1) or addition (1→N)
3. If greenfield: Skip analysis (no code to find)
4. If addition: Launch analyzer agent to find patterns
5. Creates `current_state.md` if relevant patterns found

**Agent Used**: `analyzer.md` - Codebase analysis (Step 2 only)

**Example**:
```bash
/research "Add user dashboard with activity feed"

# Step 1: Requirement Gathering
You: "I'd like to understand a few details:

1. What should the dashboard show (metrics, recent activity, both)?
2. Who can access it (all users, admins only)?
3. Real-time updates or refresh on page load?"

User: "Recent activity for logged-in users. Page refresh is fine."

# Creates requirement.md with:
# - User's Desire: Dashboard showing recent activity
# - Technical Mapping: Dashboard = Vue component, Activity = API endpoint
# Gets approval ✅

# Step 2: Codebase Analysis (automatic)
# Analyzer agent launches:
# - Reads requirement.md
# - Searches for existing dashboard patterns
# - Documents findings in current_state.md

# Output:
# ✅ Research phase complete!
# 📄 Files created:
#    - requirement.md (approved requirements)
#    - current_state.md (codebase analysis)
#
# Ready for: /plan
```

**requirement.md output sections**:
1. **User's Desire** - What user wants in their language
2. **Technical Mapping** - Validated technical approach
3. **Clarifications Made** - Q&A log
4. **Validation Sources** - How terminology was validated

**current_state.md output sections**:
1. **Based on Requirements** - Link to requirement.md
2. **What Exists Already** - Mapped to requirements
3. **Similar Patterns** - Reusable code (if 1→N)
4. **Integration Points** - Where new code connects

---

### `/plan` - Phase 2

**Purpose**: Create strategic implementation plan with research

**Agent Used**: `planner.md` - Planning coordinator with sub-agents

**What it does**:
1. Reads `requirement.md` (what to build) and `current_state.md` if exists (existing patterns)
2. Determines if greenfield (0→1) or addition (1→N)
3. Launches sub-agents for research:
   - **IF 1→N**: Codebase Pattern Analyzer (finds similar patterns)
   - **ALWAYS**: Best Practice Researcher (finds docs, examples)
4. Synthesizes comprehensive plan with phases
5. Creates 3 files: `plan.md`, `best-practices.md`, `tasks.md`

**Example**:
```bash
/plan

# Planner agent workflow:
# 1. Reads current_state.md → Greenfield dashboard
# 2. Skips codebase analyzer (no patterns to reuse)
# 3. Launches best practice researcher:
#    - Searches Vue dashboard examples
#    - Searches activity feed patterns
#    - Finds FastAPI pagination best practices
# 4. Synthesizes plan with 4 phases
# 5. Breaks into 18 granular tasks

# Output:
# ✅ Plan created with 4 phases, 18 tasks
# 📄 Files created:
#    - plan.md (strategic phases + dependencies)
#    - best-practices.md (examples from research)
#    - tasks.md (tactical checklist)
#
# Review plan and approve before implementing
```

**Planner sub-agents**:

**Codebase Pattern Analyzer** (1→N only):
- Searches for similar patterns in existing code
- Identifies reusable components/functions
- Documents current architecture patterns
- OUTPUT: Integrated into `best-practices.md` as "Project Patterns" section

**Best Practice Researcher** (always runs):
- Queries MCP servers if available (Nuxt docs, etc.)
- Searches web for current best practices
- Finds similar implementations
- Compiles examples with links
- OUTPUT: `best-practices.md`

**Main Planner** (synthesizer):
- Reads `current_state.md` + research outputs
- Creates logical phases with dependencies
- Defines validation gates for each phase
- Identifies risks and mitigation strategies
- Breaks phases into granular tasks
- OUTPUT: `plan.md` + `tasks.md`

**plan.md structure**:
1. **Goal** - What we're building
2. **Current State Summary** - Starting point
3. **Phases** - Strategic steps with:
   - Objectives
   - Dependencies
   - Validation gates
   - Estimated complexity
4. **Risks** - What could go wrong + mitigation
5. **Rollback Strategy** - How to undo if needed

**tasks.md structure**:
```markdown
## Phase 1: Backend API
- [ ] ⏳ Create Activity model (SQLModel)
- [ ] ⏳ Add migration for activity table
- [ ] ⏳ Create /api/users/me/activity endpoint
- [ ] ⏳ Add pagination support
- [ ] ⏳ Test endpoint manually

## Phase 2: Dashboard Page
...

## Decision Log
[Empty - populated during implementation]
```

**Decision gate**: Review plan.md and tasks.md before implementing

---

### `/implement [phase-X]` - Phase 3

**Purpose**: Execute specific phase of approved plan

**No Agent** - Uses main Claude context with file references

**What it does**:
1. Loads context files: `plan.md`, `best-practices.md`, `tasks.md`
2. Identifies tasks for specified phase
3. For each task:
   - Updates tasks.md: ⏳ pending → 🔄 in_progress
   - Implements following best-practices.md patterns
   - Updates tasks.md: 🔄 → ✅ completed
   - Adds notes/decisions to tasks.md Decision Log
4. After phase: Updates session-notes.md, suggests next phase

**Example**:
```bash
/implement phase-1

# Loads context:
# - plan.md → Phase 1 is "Backend API (activity endpoint)"
# - best-practices.md → FastAPI patterns, SQLModel examples
# - tasks.md → 5 tasks in Phase 1

# Executes:
# Task 1: Create Activity model
# ├─ Updates tasks.md (⏳ → 🔄)
# ├─ Creates backend/models/activity.py following SQLModel pattern
# ├─ Updates tasks.md (🔄 → ✅)
# └─ Decision Log: "Used SQLModel Field with foreign_key for user relationship"

# [Tasks 2-5 similar]

# Output:
# ✅ Phase 1 complete! 5/5 tasks
#
# Validation steps:
# - Test endpoint: curl http://localhost:8000/api/users/me/activity
# - Check pagination with ?page=2
#
# Next: /implement phase-2
```

**Real-time task tracking**:
- ⏳ Pending (not started)
- 🔄 In Progress (currently working)
- ✅ Completed (finished)
- ❌ Blocked (cannot proceed)

**Decision Log** (in tasks.md):
```markdown
## Decision Log
- [2025-11-18 14:30] Used SQLModel instead of Pydantic BaseModel for Activity
  Reason: Needed database table generation, not just validation

- [2025-11-18 15:00] Activity.timestamp uses UTC, not local time
  Reason: API might be called from different timezones
```

**Git Strategy** (configurable):
- Default: Auto-commit after phase completion
- Override: `/implement phase-1 --no-commit`

**Commit message format**:
```
feat(dashboard): complete Phase 1 - backend API

Phase 1: Backend - Activity Model
- Created Activity SQLModel with user_id FK
- Added migration for activity table
- Created /api/users/me/activity endpoint with pagination

Tasks: 5/5 completed
See dev/sessions/2025-11-18-user-dashboard/tasks.md
```

---

### `/validate` - Phase 4

**Purpose**: Review implementation against plan and standards

**Agent Used**: `reviewer.md` - Quality validation agent

**What it does**:
1. Reads `plan.md` to understand what was planned
2. Reads implemented code files
3. Compares implementation to plan
4. Checks for issues:
   - Security vulnerabilities (OWASP Top 10)
   - Error handling gaps
   - Code standards violations
   - Plan adherence
5. Creates `review-report.md` with severity levels

**Example**:
```bash
/validate

# Reviewer agent:
# 1. Reads plan.md → Expected 4 phases
# 2. Reads tasks.md → Phases 1-3 complete, Phase 4 pending
# 3. Reviews code:
#    - backend/routes/activity.py
#    - frontend/pages/dashboard.vue
#    - frontend/components/ActivityFeed.vue
# 4. Finds issues:
#    - Critical: No authentication on endpoint
#    - Warning: Missing error handling
#    - Suggestion: Could add loading skeleton

# Output:
# ✅ Review complete
# 📄 See: dev/sessions/2025-11-18-user-dashboard/review-report.md
#
# Summary:
# 🚨 1 critical issue (fix now)
# ⚠️  1 warning (fix before merge)
# 💡 1 suggestion (optional)
```

**review-report.md structure**:
```markdown
## Critical Issues (Fix Now)
- [ ] `backend/routes/activity.py:15` - Missing @require_auth decorator
  Why critical: Endpoint exposes user data without authentication
  Fix: Add @require_auth before endpoint definition

## Warnings (Fix Before Merge)
- [ ] `components/ActivityFeed.vue:45` - No error state for empty activity
  Impact: User sees blank screen instead of helpful message
  Fix: Add v-if for empty state

## Suggestions (Optional)
- [ ] `components/ActivityFeed.vue:20` - Consider loading skeleton
  Why: Improves perceived performance during data fetch

## Plan Adherence
✅ Phase 1: Backend API (complete)
✅ Phase 2: Dashboard Page (complete)
✅ Phase 3: Activity Feed (complete)
⏳ Phase 4: Polish (pending)

## Verification Commands
```bash
# Run tests
pytest backend/tests/test_activity.py

# Build frontend
cd frontend && npm run build

# Manual test
curl -H "Authorization: Bearer <token>" \\
     http://localhost:8000/api/users/me/activity
```
```

**Severity Levels**:
- **Critical**: Must fix before proceeding (security, data loss, broken functionality)
- **Warning**: Should fix before merge (edge cases, poor UX, maintainability)
- **Suggestion**: Nice to have (performance, style, best practices)

**No automatic fixes**: Reviewer reports only, doesn't change code

---

## Agent System

### What are Agents?

Agents are **autonomous AI workers** that run complex multi-step tasks independently and return comprehensive reports. They prevent context pollution in your main conversation.

**When to use agents**:
- Task requires multiple rounds of searching/reading
- Task is well-defined with clear output
- Task would clutter main conversation
- Task benefits from focused context

**When NOT to use agents**:
- Simple one-step tasks
- Highly interactive tasks (back-and-forth needed)
- Poorly defined tasks
- You want to learn the process yourself

### The 3 Core Agents

#### analyzer.md - Understanding Agent

**Purpose**: Analyze current state without suggesting changes

**Model**: Sonnet (balance of speed and capability)

**Forbidden Actions**:
- Making suggestions
- Recommending improvements
- Judging code quality
- "You should" statements

**Required Actions**:
- Read relevant code
- Trace dependencies
- Document integration points
- Identify what's unclear

**Output**: `current_state.md` with facts only

**Typical Usage**:
```bash
/understand "Add password reset flow"

# Agent will:
# - Find existing auth code
# - Trace how passwords are currently handled
# - Identify email sending mechanism
# - Document WITHOUT suggesting the reset implementation
```

---

#### planner.md - Planning Coordinator

**Purpose**: Create comprehensive implementation plan with sub-agent research

**Model**: Sonnet (needs reasoning capability)

**Sub-Agents Launched**:
1. **Codebase Pattern Analyzer** (if 1→N only)
   - Searches for reusable patterns
   - Identifies similar implementations
   - Documents project architecture conventions

2. **Best Practice Researcher** (always)
   - Queries MCP servers if available
   - Searches documentation
   - Finds examples and tutorials
   - Compiles research with sources

**Main Task**:
- Synthesize research into strategic plan
- Break into logical phases
- Define validation gates
- Identify risks
- Create granular task breakdown

**Outputs**:
- `plan.md` (strategic)
- `best-practices.md` (research)
- `tasks.md` (tactical)

**Typical Usage**:
```bash
/plan

# Agent will:
# - Read current_state.md
# - Launch sub-agents for research
# - Create 3-file planning suite
# - Present plan for your approval
```

---

#### reviewer.md - Quality Validator

**Purpose**: Review implementation against plan and standards

**Model**: Sonnet (needs careful analysis)

**What it Checks**:
1. **Plan Adherence** - Does implementation match plan?
2. **Security** - OWASP Top 10 vulnerabilities
3. **Error Handling** - Are edge cases covered?
4. **Code Standards** - Matches project patterns?
5. **Testing** - Are validation steps defined?

**Severity Classification**:
- Critical: Fix now (security, data loss)
- Warning: Fix before merge (UX, maintainability)
- Suggestion: Optional (performance, style)

**Output**: `review-report.md` with actionable items

**Typical Usage**:
```bash
/validate

# Agent will:
# - Read plan.md and implemented code
# - Check for issues across categories
# - Create review report with line numbers
# - Suggest verification commands
```

---

## Skills Auto-Activation

### How It Works

**Problem**: Claude forgets to use available skills, leading to suboptimal solutions.

**Solution**: `UserPromptSubmit` hook intercepts your prompts BEFORE Claude sees them, checks for skill triggers, and reminds Claude to use appropriate skills.

**Flow**:
```
You type: "Create a Vue component for user profile"
    ↓
skill-reminder.sh hook activates
    ↓
Detects keyword: "component", "vue"
    ↓
Matches against skill-rules.json
    ↓
Injects reminder into context:
"🎯 SKILL SUGGESTION: Consider using vue-patterns skill"
    ↓
Claude sees reminder + your prompt
    ↓
Claude uses vue-patterns skill before responding
```

### skill-rules.json

Defines when skills auto-activate:

```json
{
  "version": "1.0",
  "skills": {
    "skill-developer": {
      "type": "domain",
      "enforcement": "suggest",
      "priority": "high",
      "description": "Meta-skill for creating and managing skills",
      "promptTriggers": {
        "keywords": [
          "create skill",
          "add skill",
          "skill system",
          "skill-rules.json"
        ]
      }
    }
  }
}
```

**Trigger Types**:
- **promptTriggers.keywords**: Simple keyword matching (case-insensitive)
- **promptTriggers.intentPatterns**: Regex patterns for intent detection
- **fileTriggers.pathPatterns**: Activate when editing matching files
- **fileTriggers.contentPatterns**: Activate when file contains patterns

**Enforcement Levels**:
- `suggest`: Reminds Claude to consider skill (gentle)
- `warn`: Warns if skill not used (moderate)
- `block`: Prevents response without skill (strict)

### Adding Your Own Skills

**When to create a skill**:
1. You've solved the same problem 3+ times
2. You have patterns worth documenting
3. You want auto-activation for specific contexts

**How to create**:
1. Create folder: `.claude/skills/your-skill-name/`
2. Create `SKILL.md` (<500 lines)
3. Add resources: `.claude/skills/your-skill-name/resources/*.md` (<500 lines each)
4. Add trigger to `skill-rules.json`

**Example** - Vue patterns skill (create when ready):
```
.claude/skills/vue-patterns/
├── SKILL.md (quick reference)
└── resources/
    ├── composition-api.md (ref, computed, watch)
    ├── pinia-state.md (state management)
    └── common-pitfalls.md (mistakes to avoid)
```

**skill-rules.json entry**:
```json
{
  "vue-patterns": {
    "type": "domain",
    "enforcement": "suggest",
    "priority": "high",
    "description": "Vue 3 Composition API patterns",
    "promptTriggers": {
      "keywords": ["component", "vue", "reactive", "ref", "computed"]
    },
    "fileTriggers": {
      "pathPatterns": ["**/*.vue", "src/**/*.ts"]
    }
  }
}
```

**Growth Path**:
- Week 1-2: Use skill-developer only (learn skill system)
- Week 3-4: Create vue-patterns after documenting 5+ patterns
- Week 5+: Create fastapi-patterns for backend conventions

---

## Complete Workflow Example

### Example: Add User Dashboard Feature

**Context**: Full-stack app with Vue frontend, FastAPI backend, existing auth

---

#### Session 1: Understand & Plan (Day 1)

```bash
/new-session user-dashboard

# Output:
# ✅ Created: dev/sessions/2025-11-18-user-dashboard/
# 📝 Next: /understand "what you want to achieve"
```

```bash
/understand "Add dashboard page showing user's recent activity (logins, actions)"

# Analyzer agent launches:
# - Reads backend/models/user.py → User model exists
# - Reads frontend/src/views/ → No dashboard.vue yet
# - Finds auth in frontend/src/stores/auth.ts
# - Traces route protection → router.beforeEach
# - Searches for activity tracking → None found

# Creates current_state.md:
## Goal
Add dashboard page displaying user's recent activity

## What Exists
- User model (backend/models/user.py:15)
- Auth store with currentUser (frontend/src/stores/auth.ts:8)
- Route protection (frontend/src/router/index.ts:25)
- No activity tracking system

## Dependencies
- Need Activity model (doesn't exist)
- Dashboard depends on activity data

## Integration Points
- Frontend: Add route to src/router/index.ts
- Frontend: Create views/Dashboard.vue
- Backend: Create models/activity.py
- Backend: Create routes/activity.py

## What's Unclear
- What actions should be tracked? (login only, or CRUD operations too?)
- Retention period for activity data?

## Ready to Plan
NO - Need clarification on tracked actions

# Output:
# ⚠️ Analysis complete with open questions
# 📄 See: current_state.md
```

You clarify: "Track logins and major CRUD operations, keep 90 days"

```bash
/plan

# Planner coordinator:
# 1. Reads current_state.md → Greenfield (no activity system)
# 2. Determines 0→1 (skip codebase analyzer)
# 3. Launches Best Practice Researcher:
#    - Searches "FastAPI activity logging patterns"
#    - Searches "Vue dashboard examples"
#    - Finds SQLModel relationship examples
#    - Finds Vue Composition API async data patterns

# 4. Synthesizes plan:

# plan.md created:
## Phase 1: Backend - Activity Model & API (2 hours)
- Create Activity model
- Add migration
- Create endpoint with pagination
- Add activity logging middleware

## Phase 2: Frontend - Dashboard Page (2 hours)
- Create Dashboard.vue
- Add route with auth guard
- Fetch and display activity

## Phase 3: Activity Tracking (1 hour)
- Hook into auth login
- Hook into CRUD operations
- Test tracking works

## Phase 4: Polish (1 hour)
- Pagination UI
- Loading states
- Empty state
- Data retention cleanup job

# best-practices.md created with examples
# tasks.md created with 22 tasks across 4 phases

# Output:
# ✅ Plan created: 4 phases, 22 tasks
# 📄 Files: plan.md, best-practices.md, tasks.md
#
# Review and approve? (Y/n)
```

You review and approve.

---

#### Session 2: Implement Backend (Day 2)

```bash
# Continuing next day

/implement phase-1

# Loads context:
# - plan.md → Phase 1 objectives
# - best-practices.md → SQLModel examples
# - tasks.md → 6 tasks in Phase 1

# Task 1: Create Activity model
# Updates tasks.md: ⏳ → 🔄

# Creates backend/models/activity.py:
from sqlmodel import SQLModel, Field, Relationship
from datetime import datetime
from typing import Optional

class Activity(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    user_id: int = Field(foreign_key="user.id")
    action: str  # "login", "created_post", "deleted_comment"
    resource: Optional[str] = None  # e.g., "post:123"
    timestamp: datetime = Field(default_factory=datetime.utcnow)

    user: Optional["User"] = Relationship(back_populates="activities")

# Updates tasks.md: 🔄 → ✅
# Decision Log: "Used UTC for timestamp (API might serve multiple timezones)"

# [Tasks 2-6 similar: migration, endpoint, pagination, middleware]

# After all tasks:
# Updates session-notes.md with progress
# Auto-commits (if enabled):
# "feat(dashboard): complete Phase 1 - backend activity system"

# Output:
# ✅ Phase 1 complete! 6/6 tasks
#
# Validation:
# - Test endpoint: curl http://localhost:8000/api/users/me/activity
# - Check activity logged: psql -c "SELECT * FROM activity"
#
# Next: /implement phase-2
```

---

#### Session 3: Implement Frontend (Day 3)

```bash
/implement phase-2

# [Similar execution for frontend tasks]
# Creates Dashboard.vue, adds route, fetches data

# Output:
# ✅ Phase 2 complete! 5/5 tasks
# Next: /implement phase-3
```

```bash
/implement phase-3

# [Hooks activity tracking into login and CRUD operations]

# Output:
# ✅ Phase 3 complete! 7/7 tasks
# Next: /implement phase-4 (polish)
```

```bash
/implement phase-4

# [Adds pagination UI, loading states, empty state, cleanup job]

# Output:
# ✅ Phase 4 complete! 4/4 tasks
# ✅ All phases complete!
# Next: /validate to review implementation
```

---

#### Session 4: Validate (Day 3)

```bash
/validate

# Reviewer agent:
# 1. Reads plan.md → 4 phases expected
# 2. Reads tasks.md → All 22 tasks ✅
# 3. Reviews code files
# 4. Finds issues:

# Creates review-report.md:

## Critical Issues (Fix Now)
[None found]

## Warnings (Fix Before Merge)
- [ ] `backend/routes/activity.py:28` - No try/except around DB query
  Impact: 500 error instead of graceful error message
  Fix: Wrap query in try/except, return 500 with error detail

- [ ] `frontend/views/Dashboard.vue:45` - Empty state missing
  Impact: Blank page if user has no activity yet
  Fix: Add v-if="activities.length === 0" with helpful message

## Suggestions (Optional)
- [ ] `backend/models/activity.py:12` - Consider adding index on user_id
  Why: Faster queries for user activity (will be frequently queried)

- [ ] `frontend/components/ActivityFeed.vue:20` - Loading skeleton
  Why: Better perceived performance

## Plan Adherence
✅ Phase 1: Backend complete
✅ Phase 2: Frontend complete
✅ Phase 3: Tracking complete
⚠️ Phase 4: Polish partial (missing empty state from plan)

## Verification Commands
```bash
# Run backend tests
pytest backend/tests/test_activity.py

# Run frontend dev server
cd frontend && npm run dev

# Manual test
curl -H "Authorization: Bearer $TOKEN" \\
     http://localhost:8000/api/users/me/activity
```

# Output:
# ✅ Review complete
# 📄 See: review-report.md
#
# 🚨 0 critical
# ⚠️  2 warnings
# 💡 2 suggestions
```

You fix the 2 warnings, then commit:
```bash
git add .
git commit -m "feat(dashboard): add user activity dashboard

Complete implementation with activity tracking, pagination, and polish.

Phases:
- Phase 1: Backend activity model and API ✅
- Phase 2: Frontend dashboard page ✅
- Phase 3: Activity tracking hooks ✅
- Phase 4: Polish (pagination, loading, empty states) ✅

Review: 0 critical, 0 warnings, 2 suggestions (deferred)
See: dev/sessions/2025-11-18-user-dashboard/"
```

**Session Complete!**

---

## Templates Guide

### Templates Location

All templates in: `.claude/docs/templates/`

**Purpose**: Provide consistent structure for session artifacts

### The 5 Templates

#### 1. current_state-template.md

**When**: Created by `/understand` command (analyzer agent fills it)

**Sections**:
```markdown
## Goal
[What you're trying to achieve - one sentence]

## What Exists Already
[Current implementation with file:line references]
- Feature X: [path/to/file.py:45-67]
- Pattern Y: [how it currently works]

## Dependencies Identified
[What this feature depends on]
- Dependency 1: [why it matters]
- Dependency 2: [file:line reference]

## Integration Points
[Where new code will connect to existing code]
- Frontend: [specific files]
- Backend: [specific files]
- Database: [tables affected]

## What's Unclear
[Questions that need answering before planning]
- Question 1?
- Question 2?

## Ready to Plan
[YES/NO - decision gate]
[If NO: what's blocking?]
```

**Use**: Foundation for planning, prevents guesswork

---

#### 2. plan-template.md

**When**: Created by `/plan` command (planner agent fills it)

**Sections**:
```markdown
## Goal
[What we're building - from current_state.md]

## Current State Summary
[Starting point - brief summary]

## Strategic Phases

### Phase 1: [Name] ([estimated time])
**Objective**: [What this phase achieves]

**Tasks**: [High-level, detailed in tasks.md]
- Task category 1
- Task category 2

**Dependencies**: [What must be done before this]

**Validation Gates**: [How we know it's done]
- [ ] Validation 1
- [ ] Validation 2

**Estimated Complexity**: [Low/Medium/High]

### Phase 2: [Name]
[Same structure]

## Risks & Mitigation

### Risk 1: [What could go wrong]
**Likelihood**: [Low/Medium/High]
**Impact**: [Low/Medium/High]
**Mitigation**: [How to prevent/handle]

## Rollback Strategy
[How to undo changes if needed]

## Success Criteria
[How we know the entire feature is complete]
- [ ] Criterion 1
- [ ] Criterion 2
```

**Use**: Strategic roadmap, decision gates, risk management

---

#### 3. best-practices-template.md

**When**: Created by `/plan` command (best practice researcher fills it)

**Sections**:
```markdown
## Research Summary
[Brief overview of research conducted]

## Project Patterns (1→N projects only)
[Patterns found in existing codebase]

### Pattern 1: [Name]
**Location**: [file:line]
**Use Case**: [When to use this pattern]
**Example**:
```language
[code example from your project]
```

## External Best Practices

### Best Practice 1: [Name]
**Source**: [URL or documentation reference]
**Relevance**: [Why this applies to our feature]
**Example**:
```language
[code example]
```
**Adaptation Notes**: [How to adapt to our project]

## Recommended Approach
[Synthesis: what patterns to use for this specific feature]

## References
- [Link 1](url) - Description
- [Link 2](url) - Description
```

**Use**: Reference during implementation, ensures current best practices

---

#### 4. tasks-template.md

**When**: Created by `/plan` command (planner agent fills it)

**Sections**:
```markdown
## Phase 1: [Name]
- [ ] ⏳ Task 1 description
  Acceptance: [How to verify this task is complete]

- [ ] ⏳ Task 2 description
  Acceptance: [Verification criteria]

## Phase 2: [Name]
- [ ] ⏳ Task 3 description
...

## Decision Log
[Populated during implementation]

[YYYY-MM-DD HH:MM] Decision description
Reason: [Why this choice was made]
Alternatives considered: [What else was considered]
Impact: [How this affects the project]
```

**Task Status Symbols**:
- ⏳ Pending (not started)
- 🔄 In Progress (currently working)
- ✅ Completed (finished)
- ❌ Blocked (cannot proceed)
- 🔀 Skipped (decided not to do)

**Use**: Real-time progress tracking, decision documentation

---

#### 5. review-report-template.md

**When**: Created by `/validate` command (reviewer agent fills it)

**Sections**:
```markdown
## Critical Issues (Fix Now)
[Issues that must be fixed before proceeding]

- [ ] `file:line` - Issue description
  Why critical: [Security/data loss/broken functionality]
  Fix: [Specific action to take]

## Warnings (Fix Before Merge)
[Issues that should be fixed but don't block]

- [ ] `file:line` - Issue description
  Impact: [What happens if not fixed]
  Fix: [Specific action to take]

## Suggestions (Optional)
[Nice-to-have improvements]

- [ ] `file:line` - Improvement idea
  Why: [Benefit if implemented]

## Plan Adherence
[Checklist of plan phases]

✅ Phase 1: [Name] (complete)
⚠️ Phase 2: [Name] (partial - [what's missing])
⏳ Phase 3: [Name] (pending)

## Security Review
[Specific security checks]

- [ ] Authentication/Authorization ✅ / ⚠️ / ❌
- [ ] Input Validation ✅ / ⚠️ / ❌
- [ ] SQL Injection Prevention ✅ / ⚠️ / ❌
- [ ] XSS Prevention ✅ / ⚠️ / ❌

## Verification Commands
[Commands to verify implementation]

```bash
# Run tests
[test command]

# Build project
[build command]

# Manual verification
[manual test steps]
```

## Overall Assessment
[Summary: ready to ship? what's left?]
```

**Use**: Quality gate before considering feature complete

---

## Growth Path

### Week 1-2: Foundation

**Goal**: Get comfortable with 4-phase workflow

**Focus**:
- Use `/new-session` → `/understand` → `/plan` → `/implement` → `/validate`
- Complete 2-3 small features using the workflow
- Learn what each phase provides
- Don't worry about perfect structure yet

**Success Metric**: Complete one full feature using all 4 phases

**What you'll learn**:
- When understanding phase catches problems early
- How planning prevents mid-implementation pivots
- Value of real-time task tracking
- What validation catches that you missed

---

### Week 3-4: Skills Development

**Goal**: Document your patterns, start auto-activation

**Focus**:
- Notice patterns you're repeating
- Document in notes (don't create skills yet)
- After solving problem 3+ times → consider skill
- Create your first skill (e.g., vue-patterns)

**Success Metric**: Create 1 skill that auto-activates correctly

**What you'll learn**:
- What makes a good skill (focused, reusable)
- How to structure skill resources
- Effective trigger patterns
- When to use skills vs one-off solutions

---

### Week 5-8: Optimization

**Goal**: Refine based on real usage

**Focus**:
- Review session notes - where's friction?
- Refine agent prompts if misunderstandings occurred
- Add more skills as patterns emerge
- Tune skill-rules.json triggers

**Success Metric**: Features complete 2x faster than Week 1

**What you'll learn**:
- Which phases take longest (where to optimize)
- What agent prompts need clarification
- Which skills get used most
- Where manual intervention still needed

---

### Month 2+: Advanced Patterns

**Goal**: Grow system to match complexity

**Consider Adding**:
- Specialized agents (refactor-planner if doing refactors)
- Project-specific commands (e.g., `/test-api` for FastAPI)
- More sophisticated hooks (TypeScript for complex triggers)
- Cross-project skills (patterns that apply everywhere)

**What you'll learn**:
- When specialized agents justify their complexity
- Custom command patterns for your workflow
- Advanced hook techniques
- Skill composition (skills that reference other skills)

---

## Design Decisions & Trade-offs

### Decision 1: Why 4 Phases (Not 3)?

**Reddit has**: `/dev-docs` (combines understand + plan)

**We have**: `/understand` + `/plan` (separate)

**Trade-off**:
- ✅ Explicit understanding phase prevents jumping to solutions
- ✅ Matches your "first principles thinking" philosophy
- ✅ Can skip planning if just exploring codebase
- ❌ One more command to remember
- ❌ Extra step in workflow

**Why this choice**: Your goal is learning, not speed. Separating understand/plan teaches better thinking patterns.

---

### Decision 2: Why 3 Agents (Not 10)?

**Reddit has**: 10 specialized agents

**We have**: 3 core agents (analyzer, planner, reviewer)

**Trade-off**:
- ✅ Simpler mental model
- ✅ Less to maintain
- ✅ Covers 80% of needs
- ❌ Might need to add specialized agents later
- ❌ Less automated than Reddit

**Why this choice**: Start simple, add complexity when you feel pain. Reddit's 10 agents solve specific production problems you might not have.

**When to add more**:
- `refactor-planner`: After manual refactoring 3+ times
- `frontend-error-fixer`: If stuck on same error types repeatedly
- `documentation-architect`: When project grows, need comprehensive docs

---

### Decision 3: Why Bash Hooks (Not TypeScript)?

**Reddit has**: TypeScript hooks with sophisticated pattern matching

**We have**: Bash script with simple grep

**Trade-off**:
- ✅ No build step (bash runs directly)
- ✅ Easy to understand and modify
- ✅ Sufficient for keyword matching
- ❌ Less powerful (no complex regex)
- ❌ Can't use npm packages

**Why this choice**: Bash is irreducible for basic keyword matching. TypeScript adds complexity that's not yet justified.

**When to upgrade**: When you need:
- Complex regex patterns
- File content analysis
- JSON parsing
- NPM package features

---

### Decision 4: Why current_state.md (Not understanding.md)?

**Alternative**: `understanding.md` (more abstract)

**We chose**: `current_state.md` (more concrete)

**Trade-off**:
- ✅ Clearer what the file contains (current state analysis)
- ✅ More descriptive for future reference
- ✅ Matches "where we are now" mental model
- ❌ Slightly longer filename

**Why this choice**: Descriptive names reduce cognitive load. "Current state" is clearer than "understanding."

---

### Decision 5: Why Templates in .claude/docs/?

**Alternative**: Templates in `dev/templates/` (with session notes)

**We chose**: `.claude/docs/templates/` (with AI config)

**Trade-off**:
- ✅ Self-contained .claude/ directory (copy to new project)
- ✅ Clear separation: AI config vs work artifacts
- ✅ Templates are configuration (what structure to create)
- ❌ Templates separated from sessions that use them

**Why this choice**: `.claude/` is portable AI configuration. Templates define structure, so they belong with config.

---

### Decision 6: Why Per-Phase Git Commits?

**Alternatives**:
- Per-task commits (too granular)
- Manual only (full control)
- End-of-feature only (too coarse)

**We chose**: Per-phase (with manual override)

**Trade-off**:
- ✅ Phases are atomic, testable units
- ✅ Can revert to last working phase
- ✅ Not too granular (vs per-task)
- ✅ Can override with `--no-commit` flag
- ❌ Still need to manually commit sub-phase work sometimes

**Why this choice**: Phases align with validation gates. If Phase 1 passes validation, it's commit-worthy.

---

## FAQ

### Q: When should I use agents vs work directly?

**Use agents when**:
- Task is well-defined with clear output
- Task requires multiple search/read rounds
- Task would clutter main conversation
- You want focused context on specific goal

**Work directly when**:
- Task is exploratory (you're figuring out the problem)
- Task needs back-and-forth
- Task is simple (one file edit)
- You want to learn the process step-by-step

**Example**:
- ✅ Agent: "Analyze codebase for authentication patterns"
- ❌ Agent: "Help me figure out what feature to build"

---

### Q: Do I have to follow the 4 phases strictly?

**No.** The workflow is a guide, not a prison.

**Flexibility**:
- Skip `/understand` if you already know current state
- Skip `/plan` for trivial changes (typo fix)
- Run `/validate` mid-implementation if uncertain
- Re-run `/plan` if requirements change

**But**: Following phases helps catch issues early. Skipping is an advanced move.

---

### Q: What if I disagree with the agent's output?

**You're in control.** Agents make suggestions, you decide.

**Options**:
- Modify agent output (edit plan.md, tasks.md)
- Re-run command with clarifications
- Ignore agent output and do it your way
- Refine agent prompts (`.claude/agents/*.md`) for next time

**Agents are assistants, not commanders.**

---

### Q: How do I handle multi-day features?

**Session structure supports this**:
1. End of day: Update `session-notes.md` with progress
2. Next day: Read `session-notes.md` + `context.md` to resume
3. Continue with next phase: `/implement phase-2`

**If context reset happens**:
- Agent reads session files to understand state
- Decision Log in tasks.md preserves reasoning

**For longer gaps (>3 days)**:
- Consider creating handoff doc (use your `handoff-template.md`)
- Summarize what's done, what's next, why

---

### Q: When should I create a new skill?

**Rule of thumb**: After solving same problem 3+ times

**Signs you need a skill**:
- Copy-pasting same code pattern
- Explaining same concept repeatedly
- Forgetting your own conventions
- Want auto-reminder in specific contexts

**Don't create skills for**:
- One-off solutions
- Patterns you're still exploring
- Generic best practices (just link to docs)

---

### Q: How do I copy this setup to a new project?

**Simple**:
1. Copy `.claude/` directory to new project
2. Copy `CLAUDE.md` to new project
3. Update CLAUDE.md with project-specific info
4. Update skill-rules.json if different tech stack
5. Create `dev/sessions/` directory

**That's it.** Everything is self-contained.

---

### Q: What if the plan is wrong mid-implementation?

**Plans can change.** That's normal.

**Options**:
1. **Small change**: Update plan.md directly, note in Decision Log
2. **Medium change**: Re-run `/plan` with new context
3. **Large change**: Pause, reassess with `/understand` again

**Key**: Document why plan changed (Decision Log in tasks.md)

---

### Q: How much detail should current_state.md have?

**Goldilocks principle**: Not too much, not too little

**Too little** (bad):
```markdown
## What Exists
- Some auth code
- A few pages
```

**Too much** (bad):
```markdown
## What Exists
- backend/models/user.py line 1-250: [entire file pasted]
- backend/routes/auth.py line 1-180: [entire file pasted]
```

**Just right**:
```markdown
## What Exists
- User model (backend/models/user.py:15-45)
  - email, password_hash, created_at fields
  - SQLModel with Pydantic validation
- Auth routes (backend/routes/auth.py:20-120)
  - POST /login (JWT token generation)
  - POST /register (password hashing with bcrypt)
- Frontend auth store (src/stores/auth.ts:10-60)
  - currentUser state (reactive)
  - login/logout actions
```

**Rule**: Enough detail to plan, not so much you're reading entire files.

---

## What This System Is (And Isn't)

### This System Is:

✅ **A learning framework** - Teaches structured thinking
✅ **A workflow guide** - Phases prevent skipping steps
✅ **A memory system** - Survives context resets
✅ **Portable** - Copy to any project
✅ **Iterative** - Grows with your needs

### This System Isn't:

❌ **Mandatory** - Skip phases if you know what you're doing
❌ **Automated pipeline** - You make decisions, not robots
❌ **Perfect first try** - Iterate based on real usage
❌ **One size fits all** - Adapt to your workflow

---

## Next Steps

1. **Read** `.claude/agents/README.md` - Understand agent system
2. **Read** `.claude/commands/README.md` - See available commands
3. **Try** `/new-session test-feature` - Initialize first session
4. **Run** `/understand "simple goal"` - See analyzer in action
5. **Review** output in `dev/sessions/2025-11-18-test-feature/`
6. **Iterate** - Refine based on experience

---

**This is your setup.** Modify it, break it, rebuild it. The best architecture is the one that serves your learning and productivity.

Questions? Check `.claude/*/README.md` files or experiment!
