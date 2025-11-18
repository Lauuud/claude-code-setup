---
name: research
description: Phase 1 - Two-step requirement gathering and analysis
---

# Research Command (Phase 1)

## Purpose

Two-step process to transform vague user input into clear requirements, then analyze existing codebase.

## Usage

```bash
/research "description of what you want"
```

**Example**:
```bash
/research "Add user dashboard showing activity metrics"
```

## What This Command Does

### Step 1: Requirement Gathering (always runs)
1. Engages user in conversational dialogue to clarify:
   - What they want (user's language)
   - Success criteria (user's perspective)
   - Technical terminology (validated against docs/MCP)
2. Creates `requirement.md` in session directory
3. Asks user to approve requirements
4. If approved → proceed to Step 2
5. If not approved → iterate until approved

### Step 2: Codebase Analysis (conditional)
1. Reads approved `requirement.md`
2. Determines if greenfield (0→1) or addition (1→N)
3. If greenfield: Skip analysis (no code to find)
4. If addition: Launch analyzer agent to find patterns
5. Creates `current_state.md` if relevant patterns found

## Your Task

When user runs `/research {goal}`:

### Find Active Session

Look for most recent session directory:

```bash
ls -t dev/sessions/ | head -1
```

If no session directory found:
```
❌ No session found. Run /new-session {feature-name} first.
```

### Phase 1 Step 1: Requirement Gathering

**Sub-step 1a: Initial Dialogue**

Ask clarifying questions to understand:

1. **Primary goal**: What does user want to achieve?
2. **User story**: Who is this for? What action? What benefit?
3. **Key requirements**: What are the must-haves?
4. **Success criteria**: How will user know it works?
5. **Out of scope**: What is this NOT?

**Important**:
- Keep conversational, not interrogative
- Ask 2-3 questions at a time max
- Build on previous answers
- Stop when you have enough to map to technical implementation

**Example Dialogue:**
```
User: "Add a modal for user profile editing"

You: "Got it! To make sure I build the right thing:

1. What fields should users be able to edit in the modal?
2. Where will this modal be triggered from (which page/button)?
3. Should changes save immediately or require confirmation?"

User: "Name, email, avatar. From settings page nav. Need save/cancel buttons."

You: "Perfect. A few technical details:

1. Any validation needed (email format, name length)?
2. Should avatar be upload or URL input?
3. After saving, should modal stay open or close automatically?"

User: "Email validation yes, name 2-50 chars. Avatar upload. Close on save."

You: "Excellent, I have what I need. Let me validate the tech stack..."
```

**Sub-step 1b: Technical Validation**

Use available tools to validate terminology:

1. **If MCP available**: Query for component names, APIs
   ```
   Example: Query Nuxt UI MCP for "modal component"
   Response: UModal with props documentation
   ```

2. **If MCP unavailable**: Use WebSearch
   ```
   Example: Search "Nuxt UI modal component 2025"
   Find official docs: nuxt.com/ui/modal
   ```

3. **Map user requirements → validated technical terms**
   ```
   User said: "modal"
   Technical: UModal from Nuxt UI
   Validated: MCP Nuxt UI server
   ```

**Sub-step 1c: Create requirement.md**

Use template from `.claude/docs/templates/requirement-template.md`

Fill all sections:
- User's Desire (user's words)
- Technical Mapping (validated terminology)
- Clarifications Made (Q&A log)
- Validation Sources (MCP/WebSearch)

**Sub-step 1d: Get User Approval**

Present summary and ask:

```
✅ Requirement document created!
📄 See: dev/sessions/YYYY-MM-DD-feature/requirement.md

Summary:
**User's Desire**:
- Edit profile modal with name, email, avatar upload
- Triggered from settings page
- Save/cancel buttons, close on save

**Technical Mapping**:
- Modal: UModal (Nuxt UI) - validated via MCP
- Form: UForm with validation
- Upload: UUpload component
- Validation: Zod schema (name 2-50 chars, email format)

Does this match what you want? (yes/no/revise)
```

**If user says yes** → Mark requirement.md as APPROVED, proceed to Step 2
**If user says no** → Ask what to revise, update requirement.md, re-present
**If user says revise** → Make specific changes requested

---

### Phase 1 Step 2: Codebase Analysis (Conditional)

**Decision Gate**: Should we analyze codebase?

**Skip analysis if**:
- Greenfield project (no existing code)
- User explicitly says "new feature, nothing like this exists"
- Quick grep shows no similar patterns

**Run analysis if**:
- Similar feature might exist (1→N)
- User mentions "like the X feature"
- Grep finds related keywords

**Example Greenfield Detection:**
```bash
# Quick check
grep -r "UModal" src/

# If empty result → Greenfield
# If results found → Might have pattern, run analyzer
```

**If running analysis**:

Launch analyzer agent:
```
Agent: analyzer
Prompt:
"Analyze codebase to find patterns relevant to approved requirements.

Requirements document: dev/sessions/YYYY-MM-DD-feature/requirement.md

Your task:
1. Read requirement.md to understand WHAT to build
2. Search codebase for similar implementations
3. Document existing patterns that can be reused
4. Identify integration points
5. Create current_state.md

Focus: Map requirements to existing code, NOT questioning requirements (already approved).

Use template from .claude/docs/templates/current_state-template.md"
```

**If skipping analysis**:

Create minimal current_state.md:
```markdown
# Current State Analysis

**Based on Requirements**: requirement.md
**Analysis Type**: GREENFIELD (0→1)
**Analyzed**: YYYY-MM-DD

---

## What Exists Already

**Status**: No similar implementation found.

This is a greenfield feature. No existing code patterns to reuse.

---

## Dependencies Identified

[Only list external dependencies like auth, UI library]

**Authentication**: [Exists / Not Exists]
**UI Components**: [Library name if installed]

---

## Integration Points

**Frontend**:
- Create: [New files based on requirement.md]
- Use: [Existing auth/routing if applicable]

---

## Notes

Greenfield feature - planning phase will research best practices.
```

---

### Final Report

After both steps complete:

```
✅ Research phase complete!

📄 Files created:
   - requirement.md (approved requirements)
   - current_state.md (codebase analysis) [or "skipped - greenfield"]

**Requirements Summary**:
- [Key requirement 1]
- [Key requirement 2]
- [Key requirement 3]

**Codebase State**:
- [GREENFIELD: No existing patterns] OR [ADDITION: Found X reusable patterns]

✅ Ready for planning!

Next: /plan
```

## Example Flow

### Example 1: Greenfield Feature

```bash
/research "Add notification bell in navbar"

# Step 1: Requirement Gathering
You: "I'd like to understand a few details:

1. What should the bell show (count, recent messages)?
2. What happens when user clicks it (dropdown, full page)?
3. Where should notifications come from (API, real-time)?"

User: "Show unread count badge. Dropdown with last 5. API polling every 30s."

You: "Perfect. Validation details:

1. Clicking notification should mark as read?
2. Any actions in dropdown (mark all read, view all)?
3. Icon style (outline or solid when unread)?"

User: "Yes mark as read on click. Just show list, no actions. Solid when has unread."

# Creates requirement.md
# Gets approval ✅

# Step 2: Quick codebase check
grep -r "notification" src/ → No results

# Creates minimal current_state.md (greenfield)

✅ Research complete!
📄 requirement.md (approved)
📄 current_state.md (greenfield - no existing patterns)

Ready for: /plan
```

### Example 2: Addition Feature (1→N)

```bash
/research "Add admin dashboard like the user dashboard"

# Step 1: Requirement Gathering
You: "I see you mentioned 'like the user dashboard'.

What should the admin dashboard show differently?"

User: "All users list, system metrics, recent activity across all users."

# Q&A continues, creates requirement.md, gets approval ✅

# Step 2: Codebase check
grep -r "dashboard" src/ → Found src/views/UserDashboard.vue

# Launches analyzer agent
# Agent finds reusable patterns in UserDashboard.vue
# Creates detailed current_state.md

✅ Research complete!
📄 requirement.md (approved)
📄 current_state.md (found reusable UserDashboard pattern)

Ready for: /plan
```

## Notes

- Step 1 always runs (even if user prompt is detailed)
- Step 2 conditional on whether analysis adds value
- requirement.md is source of truth for "what to build"
- current_state.md is snapshot of "what exists"
- Both files feed into planning phase