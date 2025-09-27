# GitHub Copilot CLI Tips

> **⚠️ DEPRECATION NOTICE**: The `gh copilot` CLI extension has been deprecated. This repository now
> covers the new standalone GitHub Copilot CLI.
>
> **Migration Info**: The new CLI is installed via `npm install -g @github/copilot` and invoked with
> `copilot` (not `gh copilot`).

A comprehensive guide to using GitHub Copilot CLI effectively.

## Table of Contents

- [Installation](#installation)
- [Basic Configuration](#basic-configuration)
- [Global Configuration](#global-configuration)
- [Model Management](#model-management)
- [Tools and Extensions](#tools-and-extensions)
- [Usage Information](#usage-information)
- [Common Commands](#common-commands)
- [Tips and Tricks](#tips-and-tricks)

## Installation

### System Requirements

**Important**: The new standalone GitHub Copilot CLI requires specific minimum versions:

| Component | Minimum Version | Recommended |
|-----------|----------------|-------------|
| Node.js | 22.x | **22.x** (Required) |
| npm | 10.x | **Latest** |
| PowerShell (Windows) | 6+ | **Latest** |

**Breaking Changes**:

- GitHub CLI is **no longer required** - the new CLI is standalone
- Node.js 22 is now **required** (not just recommended)
- Windows users need PowerShell 6+ (not Windows PowerShell)

**Common Issue**: If you encounter installation errors, you likely need to update Node.js to version 22.

### Prerequisites Setup

#### 1. Install/Update Node.js to Version 22

**Using NVM (Recommended)**:

```bash
# Install NVM if not already installed
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc  # or ~/.zshrc

# Install and use Node.js 22
nvm install 22
nvm use 22
nvm alias default 22

# Verify
node --version  # Should show v22.x.x
```

**Alternative methods**:

```bash
# macOS (Homebrew)
brew install node@22

# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
```

#### 2. Install the New Standalone CLI

**New Installation Method**:

```bash
# Install the standalone GitHub Copilot CLI
npm install -g @github/copilot

# Verify installation
copilot --version
```

**Migration from old extension**:

```bash
# Remove the old extension (if installed)
gh extension remove github/gh-copilot

# Install the new standalone CLI
npm install -g @github/copilot
```

#### 3. Verify Prerequisites

```bash
# Download and run our verification script
curl -sSL https://raw.githubusercontent.com/your-username/gh-copilot-cli/main/docs/prerequisites-check.sh | bash
```

For detailed prerequisites information, see **[System Requirements Guide](docs/prerequisites.md)**.

### Automated Setup (Updated for New CLI)

> **⚠️ Note**: The automated setup script is being updated to support the new standalone CLI.
> Manual installation is recommended for now.

**Manual Installation Steps**:

```bash
# 1. Install the new standalone CLI
npm install -g @github/copilot

# 2. Launch and authenticate
copilot
# (Follow the /login command prompts)
```

### Manual Installation

**New Standalone Installation**:

```bash
# Install the standalone GitHub Copilot CLI
npm install -g @github/copilot

# Launch for first time setup
copilot
```

**Authentication Options**:

1. **OAuth Flow** (Recommended):

   ```bash
   copilot
   # Enter /login and follow the prompts
   ```

2. **Personal Access Token**:

   ```bash
   # Create a PAT with "Copilot Requests" permission at:
   # https://github.com/settings/personal-access-tokens/new
   
   # Set environment variable
   export GH_TOKEN="your-pat-here"
   # or
   export GITHUB_TOKEN="your-pat-here"
   
   # Launch copilot
   copilot
   ```

## Basic Configuration

### Authentication

The new standalone CLI handles authentication internally:

```bash
# Launch copilot and use /login command
copilot
# In the copilot shell, run:
# /login
```

### Initial Setup

The new CLI uses an interactive approach:

```bash
# Launch copilot - configuration is done through the interactive interface
copilot
```

## Global Configuration

> **⚠️ Note**: The new standalone CLI uses a different configuration system. Global configuration
> is managed through environment variables and the interactive interface.

### Setting Model Preferences

```bash
# Use environment variable to set model
export COPILOT_MODEL=gpt-5  # or claude-sonnet-4 (default)

# Launch with specific model
COPILOT_MODEL=gpt-5 copilot
```

### Authentication Configuration

```bash
# Set up authentication token
export GH_TOKEN="your-personal-access-token"
# or
export GITHUB_TOKEN="your-personal-access-token"
```

### Basic Configuration Example

```bash
# Environment variables for the new CLI
export COPILOT_MODEL=claude-sonnet-4  # Default model
export GH_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxx"  # Your PAT

# Launch options
copilot --banner  # Show the animated banner
COPILOT_MODEL=gpt-5 copilot  # Launch with GPT-5
```

## Troubleshooting

### Common Setup Errors

#### Installation Issues

##### Error: "Cannot find module '@github/copilot'"

```bash
# Solution: Install using npm
npm install -g @github/copilot

# Verify installation
copilot --version
```

##### Error: Node.js version issues

```bash
# The new CLI requires Node.js 22+
nvm install 22
nvm use 22
npm install -g @github/copilot
```

#### Authentication Problems

##### Error: "Authentication failed"

**Solution:**

1. Create a fine-grained PAT with "Copilot Requests" permission
2. Set environment variable:

   ```bash
   export GH_TOKEN="your-pat-here"
   copilot
   ```

3. Or use the `/login` command in copilot for OAuth flow

**Why this happens:** The new standalone CLI requires direct authentication, not through GitHub CLI.

For more troubleshooting information, see **[System Requirements Guide](docs/prerequisites.md)**.

---

For detailed configuration instructions, see:

- **[Global Configuration Guide](docs/global-config.md)** - Complete setup instructions
- **[Git Integration](docs/git-integration.md)** - Commit signing and workflow preferences
- **[Python Project Setup](docs/python-setup.md)** - Pipenv and project structure preferences

## Model Management

### Available Models

The new CLI supports these models:

- **Claude Sonnet 4** (default)
- **GPT-5** (via environment variable)

### Set Default Model

```bash
# Use environment variable
export COPILOT_MODEL=gpt-5

# Launch with specific model
COPILOT_MODEL=gpt-5 copilot

# Or on Windows
set COPILOT_MODEL=gpt-5
copilot
```

### View Current Model

The current model is displayed in the copilot interface or set by environment variable.

## Tools and Extensions

### Built-in Capabilities

The new CLI has built-in tools and GitHub integration:

- **Terminal-native development**
- **GitHub integration** (repos, issues, PRs)
- **Code execution and file operations**
- **MCP-powered extensibility**

### GitHub Integration

```bash
# Launch in your project directory
cd /path/to/your/project
copilot

# The CLI automatically detects your GitHub context
```

## Usage Information

### Understanding Premium Requests

Each prompt to GitHub Copilot CLI consumes one premium request from your monthly quota.

### Usage Commands

```bash
# Check basic information - run within copilot
/help          # Show available commands
/feedback      # Submit feedback survey

# Environment check
node --version  # Should be 22+
copilot --version
```

## Common Commands

### Starting the CLI

```bash
# Basic launch
copilot

# With animated banner
copilot --banner

# With specific model
COPILOT_MODEL=gpt-5 copilot
```

### Within the Copilot Interface

```bash
/login         # Authenticate with GitHub
/help          # Show available commands
/feedback      # Submit feedback survey
```

### Working with Code

The new CLI uses natural language within the interactive session:

- "Help me debug this error"
- "Review my staged changes"
- "Create a Python REST API"
- "Explain this codebase"

## Tips and Tricks

### 1. Use Context Effectively

- Launch copilot from your project directory for automatic context
- The CLI can access your GitHub repositories, issues, and pull requests
- Use clear, specific natural language prompts

### 2. Model Selection Tips

- **Claude Sonnet 4** (default): Excellent for most development tasks
- **GPT-5**: Available via `COPILOT_MODEL=gpt-5` environment variable
- Models are set at launch time

### 3. GitHub Integration Best Practices

- Launch from your project root directory
- The CLI automatically detects your GitHub context
- Ask about issues, PRs, and repository information naturally

### 4. Managing Conversations

- Each session is independent - no persistent conversation history
- Use descriptive prompts to provide context in each request
- Be mindful of premium request quota

### 5. Productivity Shortcuts

```bash
# Create aliases for common usage
alias cop="copilot"
alias copr="COPILOT_MODEL=gpt-5 copilot"

# Environment setup in your shell profile
export COPILOT_MODEL=claude-sonnet-4  # Set default model
export GH_TOKEN="your-pat-here"        # Set authentication
```

### 6. Integration with Development Workflow

The new CLI integrates directly with your development environment:

- Automatic detection of project context
- Access to GitHub repositories and metadata
- Direct terminal integration without context switching

## Configuration Reference

### Environment Variables

The new CLI uses environment variables for configuration:

- `COPILOT_MODEL`: Set the model (claude-sonnet-4 or gpt-5)
- `GH_TOKEN` or `GITHUB_TOKEN`: Personal access token for authentication

### Example Configuration

```bash
# In your shell profile (.bashrc, .zshrc, etc.)
export COPILOT_MODEL=claude-sonnet-4
export GH_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxx"

# Create aliases
alias cop="copilot"
alias cop5="COPILOT_MODEL=gpt-5 copilot"
```

## Content Filtering and Model Issues

### Content Filtering Issues

#### Model Call Failures and Content Filtering

#### Model Call Failed: Content Filtering Error

This error occurs when the AI model's content filtering system blocks a request or response.
This is expected behavior and not a bug.

**Common causes:**

- Content appears to violate content policies (even if unintentional)
- Code or text triggers false positives in safety filters
- Large code blocks that contain patterns flagged by filters
- Discussions about security, vulnerabilities, or sensitive topics

**Solutions:**

```bash
# 1. Rephrase your request
# Instead of: "Show me how to exploit this vulnerability"
# Try: "Help me understand and fix this security issue"

# 2. Break down large requests
# Instead of sending entire files, send smaller sections

# 3. Use more specific, technical language
# Instead of: "hack this code"
# Try: "debug this implementation"

# 4. Try a different model if available
copilot --model gpt-3.5  # May have different filtering
```

**What to expect:**

- ⚠️ Content filtering is **normal behavior**, not an error
- 🔄 Rephrasing usually resolves the issue
- 📝 More specific, professional language reduces false positives
- 🛡️ Filters protect against generating harmful content

**When this happens:**

1. **Don't retry the exact same request** - it will likely fail again
2. **Rephrase using professional/technical language**
3. **Break large requests into smaller parts**
4. **Focus on the specific technical problem you're solving**

### General Troubleshooting

#### Installation Problems

```bash
# Update Node.js to version 22
nvm install 22 && nvm use 22

# Reinstall the CLI
npm install -g @github/copilot

# Verify installation
copilot --version
```

#### Authentication Issues

```bash
# Check your PAT has "Copilot Requests" permission
# Set environment variable
export GH_TOKEN="your-pat-here"

# Or use OAuth flow
copilot
# Then use /login command
```

#### Model Access Issues

```bash
# Verify model setting
echo $COPILOT_MODEL

# Try different model
COPILOT_MODEL=claude-sonnet-4 copilot
```

## Advanced Usage

> **⚠️ Note**: Advanced features like templates and batch operations are not yet available in the
> new standalone CLI. These were features of the old `gh copilot` extension.

### Current Advanced Features

The new CLI focuses on interactive, conversational development:

```bash
# Work with your entire project context
cd /path/to/your/project
copilot
# Ask: "Help me understand this codebase structure"
# Ask: "Review my recent changes"
# Ask: "Create tests for the authentication module"
```

### Future Features

The new CLI is rapidly evolving. Check the [official repository](https://github.com/github/copilot-cli) for updates on:

- Batch operations
- Custom prompt templates  
- Advanced configuration options

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## More Information

For more information, visit:

- [Official GitHub Copilot CLI Repository](https://github.com/github/copilot-cli)
- [GitHub Copilot CLI Documentation](https://docs.github.com/copilot/concepts/agents/about-copilot-cli)

