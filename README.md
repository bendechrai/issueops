# IssueOps

> Build software by having conversations. No coding required.

IssueOps is a framework for autonomous AI-driven development. You describe what you want to build in GitHub Issues, and Claude builds it.

## How It Works

```
You (Product Owner)          GitHub Issues              Claude (Developer)
      │                           │                           │
      │   "Build me a todo app"   │                           │
      │──────────────────────────▶│                           │
      │                           │   Reads, asks questions   │
      │                           │◀──────────────────────────│
      │   Answers questions       │                           │
      │──────────────────────────▶│──────────────────────────▶│
      │                           │                           │
      │                           │   Proposes tech stack     │
      │                           │◀──────────────────────────│
      │   "Looks good, go ahead"  │                           │
      │──────────────────────────▶│──────────────────────────▶│
      │                           │                           │
      │                           │   Opens PR with code      │
      │                           │◀──────────────────────────│
      │                           │                           │
      │   Merges PR               │                           │
      │◀──────────────────────────│                           │
      │                           │                           │
      │   "Now add user login"    │                           │
      │──────────────────────────▶│                           │
      │                           │          ...              │
```

## Who Is This For?

- **Non-developers** who want to build software without learning to code
- **Developers** who want to describe features and let AI implement them
- **Teams** who want a documented, issue-driven development process
- **Anyone** who wants to experiment with AI-assisted software development

## Getting Started

See [SETUP.md](./SETUP.md) for step-by-step instructions.

**Quick version:**
1. Use this repo as a template
2. Add your Claude token to GitHub Secrets
3. Install the Claude GitHub App
4. Create a Project Kickoff issue and say `@claude Let's get started!`

## What You Need

- A GitHub account
- A **Claude Max subscription** ($100/month) OR an Anthropic API key
- About 10 minutes for setup

## Philosophy

- **Conversations, not code** - Describe what you want in plain English
- **Issues are the source of truth** - All decisions are documented in issues
- **Humans approve, Claude implements** - You stay in control
- **Small iterations** - One feature per issue, one branch per issue
- **Quality through tests** - Claude writes tests, CI enforces them

## Project Structure

```
your-project/
├── CLAUDE.md              # Instructions for Claude (auto-configured on kickoff)
├── .github/
│   ├── workflows/
│   │   └── claude.yml     # The automation that makes this work
│   └── ISSUE_TEMPLATE/    # Templates for different issue types
├── docs/
│   └── decisions/         # Architecture Decision Records
└── src/                   # Your code (Claude creates this)
```

## Learn More

- [SETUP.md](./SETUP.md) - Detailed setup instructions
- [CLAUDE.md](./CLAUDE.md) - How Claude works on this project
- [docs/FAQ.md](./docs/FAQ.md) - Frequently asked questions
- [docs/decisions/](./docs/decisions/) - Architecture decisions

## License

MIT - Use this however you want.

---

Built with ❤️ and 🤖
