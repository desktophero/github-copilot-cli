# Documentation Index

Welcome to the GitHub Copilot CLI Tips repository! This collection of guides will help you master the GitHub Copilot command-line interface.

## Getting Started

### Automated Setup
The fastest way to get started is with our setup script:

```bash
# Run automated setup
curl -sSL https://raw.githubusercontent.com/your-username/gh-copilot-cli/main/setup.sh | bash
```

This configures:
- Global instructions for development practices  
- Git commit signing with `-sS` flags
- Python development with pipenv and src-layout
- Conventional commit format
- Tools and best practices

### Manual Setup

- **[Quick Start Guide](QUICKSTART.md)** - Essential commands to get up and running quickly
- **[Main README](README.md)** - Comprehensive overview of all features
- **[Practical Examples](EXAMPLES.md)** - Real-world usage scenarios and workflows

## Detailed Guides

### Configuration
- **[Prerequisites](docs/prerequisites.md)** - System requirements, Node.js 22, GitHub CLI setup
- **[Global Configuration](docs/global-config.md)** - Setting up persistent global instructions and preferences
- **[Model Configuration](docs/models.md)** - Setting and changing default models, context windows  
- **[Tools and Extensions](docs/tools.md)** - Enabling tools like web browsing, code execution
- **[Usage Information](docs/usage.md)** - Monitoring usage, context windows, and costs

### Development-Specific Guides
- **[Git Integration](docs/git-integration.md)** - Commit signing, conventional commits, and git workflow
- **[Python Project Setup](docs/python-setup.md)** - Pipenv, project structure, and Python development preferences

## Quick Reference

### Essential Commands
```bash
# Installation
gh extension install github/gh-copilot

# Basic usage
gh copilot chat                    # Start interactive session
gh copilot ask "your question"     # Quick question
gh copilot usage                   # Check usage

# Configuration
gh copilot config set model gpt-4  # Set model
gh copilot config set tools.enabled true  # Enable tools

# Global configuration
gh copilot config set instructions ~/.config/gh/copilot/instructions.md
gh copilot config set git.default_commit_flags "-sS"
gh copilot config set python.dependency_manager "pipenv"
```

### Common Tasks
| Task | Command |
|------|---------|
| Change model | `gh copilot config set model <model-name>` |
| Enable tools | `gh copilot config set tools.enabled true` |
| Set global instructions | `gh copilot config set instructions <path>` |
| Configure git signing | `gh copilot config set git.default_commit_flags "-sS"` |
| Set Python preferences | `gh copilot config set python.dependency_manager "pipenv"` |
| Check usage | `gh copilot usage` |
| View context info | `gh copilot info context` |
| Generate code | `gh copilot generate --language python --task "description"` |

## File Structure

```
.
├── README.md              # Main documentation
├── QUICKSTART.md          # Quick start guide  
├── EXAMPLES.md            # Practical examples
├── docs/
│   ├── global-config.md   # Global configuration setup
│   ├── git-integration.md # Git commit signing & workflow
│   ├── python-setup.md    # Python & pipenv configuration
│   ├── models.md          # Model configuration
│   ├── tools.md           # Tools and extensions
│   └── usage.md           # Usage monitoring
└── INDEX.md              # This file
```

## Contributing

This repository is designed to be a community resource. Feel free to contribute:

1. Fork the repository
2. Add or improve documentation
3. Submit a pull request

## Support

For issues with GitHub Copilot CLI itself, please refer to:
- [GitHub Copilot CLI Documentation](https://docs.github.com/en/copilot/github-copilot-in-the-cli)
- [GitHub Support](https://support.github.com/)

For issues with this documentation:
- Open an issue in this repository
- Submit a pull request with improvements