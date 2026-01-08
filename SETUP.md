# Setup Guide

Get your IssueOps project running in about 10 minutes.

## Prerequisites

You'll need:
- A GitHub account (free)
- A Claude subscription: either **Claude Max** ($100/month at [claude.ai](https://claude.ai)) OR an Anthropic API key

## Step 1: Create Your Repository

1. Click the green **"Use this template"** button at the top of this repo
2. Choose a name for your project (e.g., `my-awesome-app`)
3. Choose Public or Private
4. Click **"Create repository"**

## Step 2: Get Your Claude Token

### Option A: Claude Max Subscription (Recommended)

If you have a Claude Max subscription:

1. Install Claude Code CLI: `npm install -g @anthropic-ai/claude-code`
2. Run: `claude login` (follow the prompts)
3. Run: `claude setup-token`
4. Copy the token that's displayed

> ⚠️ **Note:** OAuth tokens expire after about 24 hours. You'll need to regenerate periodically with `claude setup-token`. See [FAQ](./docs/FAQ.md) for automation options.

### Option B: Anthropic API Key

If you have an Anthropic API key:

1. Go to [console.anthropic.com](https://console.anthropic.com)
2. Create or copy your API key

> 💡 **Note:** API usage is billed separately based on tokens used.

## Step 3: Add Token to GitHub Secrets

1. Go to your new repository on GitHub
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **"New repository secret"**
4. Add your secret:
   - **If using Claude Max token:**
     - Name: `CLAUDE_CODE_OAUTH_TOKEN`
     - Value: (paste your token)
   - **If using API key:**
     - Name: `ANTHROPIC_API_KEY`
     - Value: (paste your API key)
5. Click **"Add secret"**

> ⚠️ **If using API key:** You also need to edit `.github/workflows/claude.yml` and change `claude_code_oauth_token` to `anthropic_api_key`.

## Step 4: Install the Claude GitHub App

1. Go to [github.com/apps/claude](https://github.com/apps/claude)
2. Click **"Install"**
3. Choose your account
4. Select **"Only select repositories"**
5. Choose your new project repository
6. Click **"Install"**

## Step 5: Start Building!

1. Go to your repository's **Issues** tab
2. Click **"New issue"**
3. Choose **"🚀 Project Kickoff"** template
4. Fill in your project name, description, and ideas
5. Submit the issue
6. Comment `@claude Let's get started!`

Claude will:
- Update `CLAUDE.md` with your project details
- Ask clarifying questions about your project
- Propose a technical approach
- Wait for your approval
- Start building!

## What Happens Next

1. **Claude asks questions** - Answer them in issue comments
2. **Claude proposes decisions** - Review and approve (or suggest changes)
3. **Claude creates PRs** - Review the changes and merge when ready
4. **Repeat** - File new issues for new features

## Troubleshooting

See the [FAQ](./docs/FAQ.md) for common issues and solutions.

### Quick Fixes

**Claude doesn't respond to @claude**
- Check that the Claude GitHub App is installed on your repo
- Check that your token/API key is correctly saved in Secrets
- Check the Actions tab for error messages

**"Permission denied" or "OIDC token" errors**
- Make sure the workflow has the correct permissions (check `claude.yml`)
- Try regenerating your token with `claude setup-token`

**Claude runs out of turns**
- Large tasks may hit the turn limit (default: 50)
- Break the task into smaller issues

## Tips for Success

1. **Start small** - Begin with simple features to learn the workflow
2. **Be specific** - The clearer your description, the better the results
3. **One thing at a time** - One feature per issue works best
4. **Review PRs** - Always look at what Claude built before merging
5. **Iterate** - If something's not right, comment and ask Claude to fix it

## Getting Help

- Check the [FAQ](./docs/FAQ.md)
- [Open an issue](https://github.com/bendechrai/issueops/issues) in the IssueOps template repo
- Ask Claude for help! (`@claude I'm having trouble with...`)

---

**Ready?** Go to your repository and create your first issue! 🚀
