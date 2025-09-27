# Quick Start Guide

## Automated Setup (Recommended)

Use the provided setup script to configure everything automatically:

```bash
# Download and run setup script
curl -sSL https://raw.githubusercontent.com/your-username/gh-copilot-cli/main/setup.sh | bash

# Or clone and run locally
git clone https://github.com/your-username/gh-copilot-cli.git
cd gh-copilot-cli
./setup.sh
```

The script automatically configures:
- Global instructions for development practices
- Git commit signing with `-sS` flags  
- Python development with pipenv and src-layout
- Conventional commit format
- Tools and best practices

## Manual Setup

## Essential Commands to Get Started

### 1. Installation and Setup
```bash
# Install the extension
gh extension install github/gh-copilot

# Authenticate
gh auth login

# Initial configuration
gh copilot config
```

### 2. Basic Usage
```bash
# Start a chat session
gh copilot chat

# Ask a quick question
gh copilot ask "What's the difference between malloc and calloc?"

# Generate code
gh copilot generate --language javascript --task "HTTP request with error handling"
```

### 3. Essential Configuration
```bash
# Set your preferred model
gh copilot config set model gpt-4

# Enable tools for enhanced functionality
gh copilot config set tools.enabled true

# Check your current settings
gh copilot config list
```

### 4. Monitor Usage
```bash
# Check usage and limits
gh copilot usage

# View context window information
gh copilot info context
```

### 5. Get Help
```bash
# General help
gh copilot --help

# Command-specific help
gh copilot chat --help
gh copilot config --help
```

## Your First Session

Try these commands in order:

1. `gh copilot ask "What are the most important git commands for beginners?"`
2. `gh copilot generate --language python --task "function to calculate fibonacci sequence"`
3. `gh copilot usage` (to see your token consumption)

## Next Steps

- Read the full [README.md](README.md) for comprehensive documentation
- Explore [Model Configuration](docs/models.md)
- Learn about [Tools and Extensions](docs/tools.md)