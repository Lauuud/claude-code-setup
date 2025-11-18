# Requirements Document

**Status**: [DRAFT / APPROVED / REVISED v2]
**Created**: YYYY-MM-DD
**Approved**: YYYY-MM-DD (or "pending")

---

## User's Desire
> What the user wants in their own words (non-technical)

### Primary Goal
[One sentence: What does the user want to achieve?]

### User Story
As a [user type], I want to [action], so that [benefit].

### Key Requirements (User Language)
- Requirement 1 (in user's words)
- Requirement 2 (in user's words)
- Requirement 3 (in user's words)

### Success Criteria (From User's Perspective)
- [ ] User can [action 1]
- [ ] User sees [result 1]
- [ ] User experiences [outcome 1]

### Out of Scope (What This Is NOT)
- Not [thing user might confuse this with]
- Not [related feature that's separate]

---

## Technical Mapping
> Translation to validated technical terminology

### Technical Goal
[One sentence: What are we building technically?]

### Technology Stack (Validated)
**Frontend**:
- Framework: [e.g., Nuxt 3]
- UI Library: [e.g., Nuxt UI] (validated via: MCP/WebSearch/Manual)
- Key Components:
  - [Component 1]: [Actual API name, e.g., UModal]
  - [Component 2]: [Actual API name, e.g., UForm]

**Backend** (if applicable):
- Framework: [e.g., FastAPI]
- Key Patterns:
  - [Pattern 1]: [Actual implementation approach]

### Technical Requirements (Mapped from User Requirements)
| User Requirement | Technical Implementation |
|------------------|-------------------------|
| [User req 1] | [Tech approach 1] |
| [User req 2] | [Tech approach 2] |

### API Contracts (if applicable)
**Endpoint**: [HTTP method] [/path]
**Request**: [shape]
**Response**: [shape]

### Data Model (if applicable)
**Entity**: [Name]
**Fields**:
- field1: [type] - [purpose]
- field2: [type] - [purpose]

---

## Clarifications Made
> Questions asked and answers received during Step 1

**Q1**: [Question asked]
**A1**: [User's answer]

**Q2**: [Question asked]
**A2**: [User's answer]

---

## Validation Sources
- Nuxt UI: [MCP / WebSearch / Manual review]
- FastAPI: [MCP / WebSearch / Manual review]
- [Other tech]: [Validation method]

---

## Next Steps
- [ ] User reviews and approves this document
- [ ] Once approved → Proceed to Step 2 (codebase analysis) or skip if greenfield
- [ ] After Step 2 → /plan