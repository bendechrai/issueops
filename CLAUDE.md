# {{PROJECT_NAME}}

> {{PROJECT_DESCRIPTION}}

<!-- 
🤖 CLAUDE: FIRST-RUN SETUP INSTRUCTIONS
=======================================
STOP! Before doing anything, check the repository name.

If the repository is named "issueops" (regardless of owner):
- This is a TEMPLATE repository (or a fork of one)
- DO NOT replace {{PROJECT_NAME}} or {{PROJECT_DESCRIPTION}}
- DO NOT delete this comment block
- Treat this as a project called "IssueOps" with vision: "A framework for autonomous AI-driven development"
- Work on improving the template, not initializing it

If the repository has ANY OTHER NAME:
- This is a project created from the template
- Proceed with initialization:
  1. Read the project name and description from the Kickoff issue
  2. Replace {{PROJECT_NAME}} with the actual project name (in the heading above)
  3. Replace {{PROJECT_DESCRIPTION}} with the project description (in the blockquote above)
  4. Update the "Project Vision" section with details from the kickoff issue
  5. Delete this entire HTML comment block
  6. Commit these changes as your first action
=======================================
-->

## Project Vision

_Describe what you're building and why. This section will be populated during project kickoff._

## Roles

### Human (Product Owner)
- Sets product direction
- Files issues with requirements
- **Approves architectural decisions (ADRs)**
- Reviews and merges PRs
- Answers Claude's questions

### Claude (Developer)
- Evaluates options and **recommends** (does not decide unilaterally)
- Implements approved decisions
- Writes tests
- Opens PRs
- Documents work

## Development Workflow

```
Human (Product Owner)     GitHub Issues              Claude (Developer)
      │                        │                           │
      │   Files issue          │                           │
      │───────────────────────▶│                           │
      │                        │   Picks up issue          │
      │                        │──────────────────────────▶│
      │                        │                           │
      │                        │   Asks clarifying Qs      │
      │                        │◀──────────────────────────│
      │   Answers in comments  │                           │
      │───────────────────────▶│──────────────────────────▶│
      │                        │                           │
      │                        │   Posts recommendation    │
      │                        │◀──────────────────────────│
      │   Approves/redirects   │                           │
      │───────────────────────▶│──────────────────────────▶│
      │                        │                           │
      │                        │   Opens PR with tests     │
      │                        │◀──────────────────────────│
      │                        │                           │
      │   Reviews/merges       │                           │
      │◀───────────────────────│                           │
```

## What Requires Approval

Before implementing, Claude must get explicit approval for:

- **ADRs (Architecture Decision Records)** - Any technology choice, pattern, or structural decision
- **Scope changes** - If implementation reveals the issue should be larger/smaller
- **Dependency additions** - Adding new packages or services
- **Breaking changes** - Anything that changes existing behavior

## What Claude Can Do Autonomously

- Ask clarifying questions
- Evaluate options and post recommendations
- Implement **after approval**
- Write tests
- Fix bugs within existing patterns
- Refactor within existing architecture
- Resolve merge conflicts

## Branch Strategy

**Critical: One branch per issue, always.**

- **Branch naming**: `claude/issue-{number}` (e.g., `claude/issue-5`)
- **Same branch for follow-ups**: Additional `@claude` comments on the same issue push to the same branch
- **One PR per issue**: Update the existing PR, don't create new ones
- **Rebase before work**: Always pull and rebase onto main before starting work
- **Resolve conflicts**: If conflicts occur during rebase, resolve them. Only ask for human help if truly stuck.

### Why This Matters

Multiple branches from one issue = merge conflicts = humans touching code. We avoid this by:
1. Keeping all work for an issue on one branch
2. Rebasing onto main when picking up work
3. Claude resolving conflicts when possible

## Handling Complex Tasks

Some tasks (like project scaffolding) are too large for a single run. Claude has a turn limit of 50 and will time out on complex tasks.

### Break Work Into Phases

For complex tasks, Claude should:

1. **Propose phases** - Break the work into phases that each take ~15-20 turns
2. **Complete one phase** - Do the work, commit, push
3. **Report progress** - Update the issue comment with what was done and what's next
4. **Wait for continue** - Human says `@claude continue` to proceed with the next phase

### Example Phases for Project Scaffolding

Instead of doing everything at once:

**Phase 1: Project initialization**
- Create Next.js project
- Basic TypeScript config
- Commit and push

**Phase 2: Database setup**
- Install and configure Prisma
- Create initial schema
- Commit and push

**Phase 3: Testing infrastructure**
- Set up Vitest
- Set up Playwright
- Add example tests
- Commit and push

**Phase 4: Component library**
- Install shadcn/ui
- Configure components
- Commit and push

### Commands to Use

When running shell commands:
- **Use simple, single commands** - Don't chain with `&&`
- **Run one tool at a time** - Easier to debug if something fails
- **Check versions first** - Verify tools are available before using them

```bash
# Good - simple commands
node --version
npm init -y
npm install next

# Avoid - chained commands may fail silently
node --version && npm init -y && npm install next
```

## Issue Rules

- **One concern per issue** - If it has "and" in the title, split it
- **Acceptance criteria required** - How do we know it's done?
- **Test requirements stated** - What tests prove it works?
- **Size limit** - If implementation would exceed ~300 lines changed, break it down

## Quality Guardrails

1. **Tests are mandatory** - No PR without tests that cover the change
2. **All tests must pass** - CI blocks merge on failure
3. **ADRs for decisions** - Any architectural choice gets documented in `/docs/decisions/`

## Architecture

_This section is populated as decisions are made._

See `/docs/decisions/` for all architectural decision records.

**Current stack**: TBD (will be decided via ADR process)

## Repository Structure

```
project/
├── CLAUDE.md              # This file - project instructions
├── README.md              # Public-facing project info
├── docs/
│   └── decisions/         # ADRs (Architecture Decision Records)
├── .github/
│   ├── ISSUE_TEMPLATE/    # Templates for issues
│   └── workflows/         # CI/CD automation
└── src/                   # Application code (structure TBD)
```

## For Claude: How to Work on This Project

1. **Read this file first** - Always, every time
2. **Check `/docs/decisions/`** - Understand past choices before making new ones
3. **Work from issues** - Don't implement things not requested
4. **Ask questions** - If requirements are unclear, ask in the issue before coding
5. **Recommend, don't decide** - Post your recommendation and wait for approval on ADRs
6. **One branch per issue** - Use `claude/issue-{number}`, rebase onto main before starting
7. **Rebase and resolve conflicts** - Don't ask humans to resolve conflicts unless truly stuck
8. **Break complex tasks into phases** - Complete one phase, commit, then continue
9. **Write tests first** - TDD preferred
10. **Small commits** - Atomic, reviewable changes
11. **Always create PRs** - Use `gh pr create` to actually create PRs, not just provide links
12. **Update existing PRs** - Push to the same branch; don't create new PRs for the same issue

## For Humans: How to Guide This Project

1. **File small issues** - One thing at a time
2. **Be specific about acceptance criteria** - "User can X" not "Make X better"
3. **Answer Claude's questions** - In the issue comments
4. **Approve or redirect** - Claude waits for your go-ahead on decisions
5. **Review PRs** - Look at what Claude built before merging
6. **Merge PRs yourself** - Claude cannot merge (security restriction)
7. **Trust but verify** - Tests and CI are your safety net
8. **Say `@claude continue`** - To resume work on complex multi-phase tasks
