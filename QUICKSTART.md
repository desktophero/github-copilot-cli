# Quick Start Guide

> **⚠️ MIGRATION NOTICE**: This guide has been updated for the new standalone GitHub Copilot CLI
> (`copilot`), not the deprecated `gh copilot` extension.

## Prerequisites Check

**⚠️ Important**: The new GitHub Copilot CLI requires specific minimum versions:

| Component | Minimum | Recommended | Check Command |
|-----------|---------|-------------|---------------|
| Node.js | **22.x** (Required) | **22.x** | `node --version` |
| npm | **10.x** | Latest | `npm --version` |
| PowerShell (Windows) | 6+ | Latest | `pwsh --version` |

**Breaking Changes**:

- GitHub CLI is **no longer required**
- Node.js 22 is **now required** (not just recommended)
- Completely new installation method

### Quick Prerequisites Setup

If you need to update Node.js (required):

```bash
# Install NVM and Node.js 22 (Required)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc  # or ~/.zshrc
nvm install 22 && nvm use 22 && nvm alias default 22

# Verify
node --version  # Should show v22.x.x
```

### Prerequisites Verification Script

> **⚠️ Note**: The verification script is being updated for the new CLI. Manual verification recommended for now.

```bash
# Manual verification
node --version   # Should be 22.x
npm --version    # Should be 10.x+

# On Windows, also check:
pwsh --version   # Should be 6.x+
```

---

## New Installation Method

**⚠️ BREAKING CHANGE**: The installation method has completely changed.

### Install the New Standalone CLI

```bash
# Install globally with npm
npm install -g @github/copilot

# Verify installation
copilot --version
```

### Migration from Old Extension

```bash
# Remove old extension (if installed)
gh extension remove github/gh-copilot

# Install new standalone CLI
npm install -g @github/copilot
```

### First Launch and Authentication

```bash
# Launch the new CLI
copilot

# Authenticate using the /login command
# In the copilot interface, type:
/login
# Follow the OAuth prompts
```

#### Alternative: PAT Authentication

```bash
# Create PAT with "Copilot Requests" permission at:
# https://github.com/settings/personal-access-tokens/new

# Set environment variable
export GH_TOKEN="your-pat-here"
# or
export GITHUB_TOKEN="your-pat-here"

# Launch copilot
copilot
```

## Essential Commands to Get Started

### 1. Installation and Setup

```bash
# Install the new standalone CLI
npm install -g @github/copilot

# Launch for first time
copilot

# Authenticate (within copilot interface)
/login
```

### 2. Basic Usage

```bash
# Launch copilot (from your project directory)
cd /path/to/your/project
copilot

# Basic interactions (within copilot)
# Just type natural language:
# "Help me understand this codebase"
# "Review my recent changes" 
# "Create a Python function to parse JSON"
```

### 3. Essential Configuration

```bash
# Set preferred model (before launching)
export COPILOT_MODEL=gpt-5
copilot

# Or use default (Claude Sonnet 4)
copilot

# Launch with banner
copilot --banner
```

### 4. Working with Different Models

```bash
# Use default Claude Sonnet 4
copilot

# Use GPT-5
COPILOT_MODEL=gpt-5 copilot

# Set as environment variable
export COPILOT_MODEL=gpt-5
copilot
```

### 5. Get Help

```bash
# General help
copilot --help

# Within copilot interface
/help      # Show available slash commands
/feedback  # Submit feedback survey
```

## Your First Session

Try these steps in order:

1. **Install and launch:**

   ```bash
   npm install -g @github/copilot
   copilot
   ```

2. **Authenticate:**

   ```bash
   # Within copilot, run:
   /login
   # Follow the OAuth flow
   ```

3. **Try basic interactions:**
   - "What are the most important git commands for beginners?"
   - "Help me create a Python function to read a CSV file"
   - "Explain the files in this project"

4. **Test different models:**

   ```bash
   # Exit copilot (Ctrl+C), then try:
   COPILOT_MODEL=gpt-5 copilot
   # Ask the same question to compare responses
   ```

## Next Steps

- Read the updated [README.md](README.md) for comprehensive documentation  
- Understand the [new architecture](https://github.com/github/copilot-cli)
- Check [official documentation](https://docs.github.com/copilot/concepts/agents/about-copilot-cli)

> **⚠️ Note**: Many advanced features from the old `gh copilot` extension are being reimplemented
> in the new CLI. Check the official repository for the latest updates.
