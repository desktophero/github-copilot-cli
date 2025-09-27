# Documentation Index

> **⚠️ MAJOR UPDATE**: This repository has been updated for the new standalone GitHub Copilot CLI
> (`copilot`). The old `gh copilot` extension is deprecated.

Welcome to the GitHub Copilot CLI Tips repository! This collection of guides will help you master
the new standalone GitHub Copilot command-line interface.

## Getting Started

### New Installation Method

**⚠️ BREAKING CHANGE**: Installation has completely changed:

```bash
# NEW: Install standalone CLI
npm install -g @github/copilot

# Launch and authenticate  
copilot
# Use /login command for OAuth
```

**Migration from old extension**:

```bash
# Remove old extension
gh extension remove github/gh-copilot

# Install new CLI
npm install -g @github/copilot
```

### Manual Setup

- **[Quick Start Guide](QUICKSTART.md)** - Essential commands for the new CLI
- **[Main README](README.md)** - Comprehensive overview of all features  
- **[Practical Examples](EXAMPLES.md)** - Real-world usage scenarios and workflows

## Detailed Guides

> **⚠️ Note**: The detailed guides are being updated for the new CLI. Some information may be outdated.

### Configuration  

- **[Prerequisites](docs/prerequisites.md)** - System requirements (Node.js 22+, no longer needs GitHub CLI)
- **[Global Configuration](docs/global-config.md)** - Configuration via environment variables (old config system deprecated)
- **[Model Configuration](docs/models.md)** - Claude Sonnet 4 (default) and GPT-5 models
- **[Tools and Extensions](docs/tools.md)** - Built-in GitHub integration and MCP support
- **[Usage Information](docs/usage.md)** - Understanding premium requests and usage limits

### Development-Specific Guides  

- **[Git Integration](docs/git-integration.md)** - Built-in git context detection (no manual configuration needed)
- **[Python Project Setup](docs/python-setup.md)** - Conversational project setup guidance

## Quick Reference

### Essential Commands

```bash
# Installation (NEW METHOD)
npm install -g @github/copilot

# Basic usage
copilot                           # Launch CLI
copilot --banner                  # Launch with banner  
COPILOT_MODEL=gpt-5 copilot      # Launch with GPT-5

# Authentication
# Within copilot interface:
/login                           # OAuth flow
/help                           # Show available commands
/feedback                       # Submit feedback

# Environment setup
export COPILOT_MODEL=claude-sonnet-4  # Set default model
export GH_TOKEN="your-pat-here"       # Set authentication
```

### Common Tasks

| Task | Method |
|------|---------|
| Install CLI | `npm install -g @github/copilot` |
| Launch CLI | `copilot` |  
| Change model | `COPILOT_MODEL=gpt-5 copilot` |
| Authenticate | `/login` (within copilot) |
| Get help | `/help` (within copilot) |
| Set auth token | `export GH_TOKEN="your-pat"` |
| Check version | `copilot --version` |
| Project context | Launch from project root directory |

## File Structure

```text
.
├── README.md              # Main documentation (UPDATED)
├── QUICKSTART.md          # Quick start guide (UPDATED) 
├── EXAMPLES.md            # Practical examples (UPDATED)
├── docs/                  # ⚠️ Being updated for new CLI
│   ├── prerequisites.md   # System requirements (Node.js 22+)
│   ├── global-config.md   # Environment variables & config  
│   ├── git-integration.md # Built-in git context detection
│   ├── python-setup.md    # Conversational project setup
│   ├── models.md          # Claude Sonnet 4 & GPT-5
│   ├── tools.md           # Built-in tools & GitHub integration
│   └── usage.md           # Premium requests & usage monitoring
├── setup.sh               # ⚠️ Legacy script (being updated)
├── prerequisites-check.sh # ⚠️ Legacy script (being updated)
└── INDEX.md               # This file (UPDATED)
```

## Support

For issues with the new GitHub Copilot CLI:

- [Official GitHub Copilot CLI Repository](https://github.com/github/copilot-cli)  
- [GitHub Copilot CLI Documentation](https://docs.github.com/copilot/concepts/agents/about-copilot-cli)
- [GitHub Support](https://support.github.com/)

For issues with this documentation:

- Open an issue in this repository
- Submit a pull request with improvements

## Migration Notes

**Key Changes from old `gh copilot` to new `copilot`:**

- ✅ **Standalone npm package** (no GitHub CLI dependency)
- ✅ **Interactive conversational interface**
- ✅ **Automatic project context detection**
- ✅ **Built-in GitHub integration**
- ✅ **MCP-powered extensibility**
- ⚠️ **Configuration via environment variables** (not config files)
- ⚠️ **Premium request quota system**
- ❌ **Advanced CLI flags removed** (interactive prompts instead)
- ❌ **Batch operations deprecated** (conversational workflow)
