# Frequently Asked Questions

## Setup & Authentication

### Why do I need Claude Max? Can I use Claude Pro?

Claude Pro ($20/month) doesn't include the Claude Code features needed for GitHub integration. You need either:
- **Claude Max** ($100/month) - Uses OAuth token, included in subscription
- **Anthropic API key** - Pay per token used, no subscription required

### My OAuth token stopped working

OAuth tokens from `claude setup-token` expire after approximately 24 hours. You'll need to regenerate:

```bash
claude setup-token
```

Then update the `CLAUDE_CODE_OAUTH_TOKEN` secret in your GitHub repository settings.

**Tip:** You can automate this with a scheduled job if you have a GitHub Personal Access Token with `secrets:write` scope.

### How do I switch from OAuth token to API key?

1. Get an API key from [console.anthropic.com](https://console.anthropic.com)
2. Add it to GitHub Secrets as `ANTHROPIC_API_KEY`
3. Edit `.github/workflows/claude.yml`:
   - Comment out: `claude_code_oauth_token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}`
   - Uncomment: `anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}`

### Claude doesn't respond when I mention @claude

Check these in order:

1. **GitHub App installed?** Go to [github.com/apps/claude](https://github.com/apps/claude) and verify it's installed on your repo
2. **Token configured?** Check Settings → Secrets and variables → Actions for `CLAUDE_CODE_OAUTH_TOKEN` or `ANTHROPIC_API_KEY`
3. **Workflow enabled?** Check the Actions tab - is the workflow there? Is it enabled?
4. **Check logs** - Go to Actions tab, find the failed run, and read the error message

## Workflow & Branches

### I got a merge conflict. What do I do?

If you're following IssueOps correctly, Claude should handle merge conflicts. But if you're stuck:

1. **Option A:** Ask Claude to fix it: `@claude Please rebase onto main and resolve the conflicts`
2. **Option B:** Close the PR and ask Claude to start fresh: `@claude Please start over from current main`

### Why one branch per issue?

Multiple branches from one issue leads to:
- Merge conflicts between related changes
- Confusion about which branch is "current"
- Extra work for humans resolving conflicts

One branch per issue means Claude rebases and resolves conflicts as part of its normal workflow.

### Claude created multiple PRs for one issue

This shouldn't happen with the current setup. If it does:
1. Close the extra PRs
2. Keep the one with the most complete work
3. Comment on the issue: `@claude Continue work on branch claude/issue-{N}. Do not create new branches.`

### Can I have Claude work on multiple issues at once?

Yes, but each issue gets its own branch. Claude can context-switch between issues, but:
- Each `@claude` mention triggers a separate workflow run
- Multiple simultaneous runs may cause conflicts
- Better to wait for one PR to merge before starting another

## Turn Limits & Performance

### Claude ran out of turns

The default is 50 turns. If Claude hits this limit:

1. **Break down the task** - The issue might be too big. Split it into smaller issues.
2. **Increase the limit** - Edit `.github/workflows/claude.yml` and change `--max-turns 50` to a higher number
3. **Continue the work** - Comment `@claude Continue where you left off` to start a new run

### How much does each run cost?

With Claude Max: Included in your subscription (no additional cost)

With API key: Depends on tokens used. A typical run might cost $0.10-$1.00 depending on complexity. Check [Anthropic's pricing](https://www.anthropic.com/pricing) for current rates.

### Can I use a different Claude model?

Yes, edit `.github/workflows/claude.yml` and change the `--model` parameter. Options include:
- `claude-sonnet-4-5-20250929` (default, balanced)
- `claude-opus-4-5-20250929` (more capable, slower, more expensive)

## Quality & Testing

### Claude wrote code but no tests

This shouldn't happen if the issue template includes test requirements. If it does:
1. Comment: `@claude This PR is missing tests. Please add tests for [specific functionality]`
2. For future issues, always fill in the "Test Requirements" field

### How do I set up CI to run tests?

IssueOps doesn't include CI configuration by default because it depends on your tech stack. Ask Claude:

`@claude Please create a GitHub Actions workflow that runs our test suite on every PR`

### Claude made a mistake. How do I fix it?

Just comment on the issue or PR:
- `@claude This isn't quite right. [Explain what's wrong]`
- `@claude Please change X to Y`
- `@claude Revert the last commit and try a different approach`

## ADRs & Decisions

### What's an ADR?

An Architecture Decision Record documents important technical choices. Use them for:
- Technology choices (which database, framework, etc.)
- Structural decisions (folder structure, naming conventions)
- Integration choices (which APIs, services)

ADRs live in `/docs/decisions/` and create a history of why things are the way they are.

### Do I need to approve every ADR?

Yes! This is the main control point for humans. Claude proposes, you approve. If you don't want to be that involved, you can:
1. Give blanket approvals: "For framework choices, use whatever you think is best"
2. Delegate categories: "For testing libraries, just pick a popular one"

But for important decisions, stay involved.

## Troubleshooting

### "fatal: not a git repository"

The workflow is missing the checkout step. Check that `.github/workflows/claude.yml` includes:

```yaml
- name: Checkout repository
  uses: actions/checkout@v4
  with:
    fetch-depth: 0
```

### "Could not fetch an OIDC token"

The workflow needs the `id-token: write` permission. Check that your workflow has:

```yaml
permissions:
  contents: write
  pull-requests: write
  issues: write
  id-token: write
```

### Claude says it can't create a PR

Make sure `Bash(gh:*)` is in the `--allowedTools` list in your workflow file.

### My language/framework isn't supported

The default workflow includes common tools, but you can add more. Edit the `--allowedTools` line in `.github/workflows/claude.yml` to add your toolchain:

```
Bash(your-tool:*)
```

## Philosophy & Best Practices

### Can I edit code directly?

Yes, but consider:
- Claude won't know about your changes unless they're in main
- It's better to describe what you want changed and let Claude do it
- If you must edit directly, merge to main before asking Claude to work on related issues

### How do I give feedback on Claude's work?

Comment on the issue or PR. Be specific:
- ✅ "The button should be blue, not green"
- ✅ "This function should handle the case where X is null"
- ❌ "This doesn't look right" (too vague)

### What if Claude keeps making the same mistake?

1. Add clarification to CLAUDE.md in the relevant section
2. Create an ADR that documents the correct approach
3. Reference the ADR in future issues

### Can multiple people use the same IssueOps repo?

Yes! Multiple people can:
- Create issues
- Approve decisions
- Review PRs
- Comment on Claude's work

Just be careful about conflicting direction - designate one person as the decision-maker for each issue.
