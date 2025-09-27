# Documentation Index

Welcome to the GitHub Copilot CLI Tips repository! This collection of guides will help you master the GitHub Copilot command-line interface.

## Getting Started

- **[Quick Start Guide](QUICKSTART.md)** - Essential commands to get up and running quickly
- **[Main README](README.md)** - Comprehensive overview of all features
- **[Practical Examples](EXAMPLES.md)** - Real-world usage scenarios and workflows

## Detailed Guides

### Configuration
- **[Model Configuration](docs/models.md)** - Setting and changing default models, context windows
- **[Tools and Extensions](docs/tools.md)** - Enabling tools like web browsing, code execution
- **[Usage Information](docs/usage.md)** - Monitoring usage, context windows, and costs

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
```

### Common Tasks
| Task | Command |
|------|---------|
| Change model | `gh copilot config set model <model-name>` |
| Enable tools | `gh copilot config set tools.enabled true` |
| Check usage | `gh copilot usage` |
| View context info | `gh copilot info context` |
| Generate code | `gh copilot generate --language python --task "description"` |

## File Structure

```
.
├── README.md           # Main documentation
├── QUICKSTART.md       # Quick start guide
├── EXAMPLES.md         # Practical examples
├── docs/
│   ├── models.md       # Model configuration
│   ├── tools.md        # Tools and extensions
│   └── usage.md        # Usage monitoring
└── INDEX.md           # This file
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