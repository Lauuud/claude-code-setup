# My Claude Workflow Setup

This is a complete 4-phase development workflow system for Claude Code.

## Quick Start

### 1. Copy to Your Project

```bash
# From your project root
cp -r /Users/jamesbond/Desktop/Claude/my-claude-setup/.claude .
cp /Users/jamesbond/Desktop/Claude/my-claude-setup/CLAUDE.md .
```

### 2. Read the Documentation

**Start here**: `CLAUDE.md` - Complete guide with examples

### 3. Try the Workflow

```bash
# Initialize a test session
/new-session test-feature

# Understand current state
/understand "Add a simple feature"

# Create implementation plan
/plan

# Implement phase by phase
/implement phase-1

# Validate implementation
/validate
```

## What's Inside

### Core Files (20 files + skill-developer)

- **CLAUDE.md** - Complete documentation
- **settings.json** - Permissions & hooks config
- **3 Agents** - analyzer, planner, reviewer
- **5 Commands** - new-session, understand, plan, implement, validate
- **5 Templates** - Session file templates
- **2 Hooks** - Skill auto-activation
- **Skills** - skill-developer (meta-skill)

## Directory Structure

```
.
├── CLAUDE.md                    # Read this first!
└── .claude/
    ├── settings.json           # Config
    ├── agents/                 # 3 core agents
    ├── commands/               # 5 workflow commands
    ├── docs/templates/         # 5 session templates
    ├── hooks/                  # Auto-activation
    └── skills/                 # skill-developer
```

## The 4-Phase Workflow

1. **UNDERSTAND** (`/understand`) - Analyze current state (no suggestions)
2. **PLAN** (`/plan`) - Create strategic plan with research
3. **IMPLEMENT** (`/implement`) - Execute phase-by-phase with task tracking
4. **VALIDATE** (`/validate`) - Review against plan and standards

## Key Design Principles

- **Single source of truth**: CLAUDE.md has all documentation
- **Irreducible, not minimal**: Simple enough to understand, complete enough to work
- **First principles thinking**: Understand the "why" behind solutions
- **Portable**: Copy .claude/ + CLAUDE.md to any project
- **Iterative**: Start simple, add complexity when you feel pain

## Next Steps

1. Copy to a project
2. Read CLAUDE.md thoroughly
3. Run `/new-session` to try it out
4. Iterate based on your workflow

## Growth Path

- **Week 1-2**: Learn the 4-phase workflow
- **Week 3-4**: Create your first custom skill
- **Week 5+**: Optimize based on real usage

---

**This is your setup.** Modify it, break it, rebuild it. The best architecture is the one that serves your learning and productivity.
