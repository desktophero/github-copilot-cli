# GitHub Copilot CLI Tips

A comprehensive guide to using GitHub Copilot CLI effectively.

## Table of Contents

- [Installation](#installation)
- [Basic Configuration](#basic-configuration)
- [Model Management](#model-management)
- [Tools and Extensions](#tools-and-extensions)
- [Usage Information](#usage-information)
- [Common Commands](#common-commands)
- [Tips and Tricks](#tips-and-tricks)

## Installation

First, install the GitHub Copilot CLI extension:

```bash
gh extension install github/gh-copilot
```

## Basic Configuration

### Authentication
Ensure you're authenticated with GitHub:

```bash
gh auth login
```

### Initial Setup
Configure your basic settings:

```bash
gh copilot config
```

## Model Management

### View Available Models
See what models are available:

```bash
gh copilot model list
```

### Set Default Model
Change your default model:

```bash
gh copilot config set model <model-name>
```

### View Current Model
Check which model you're currently using:

```bash
gh copilot config get model
```

## Tools and Extensions

### Enable Tools
Enable specific tools for enhanced functionality:

```bash
gh copilot config set tools.enabled true
```

### Available Tool Categories
- **Web browsing**: Access web content during conversations
- **Code execution**: Run code snippets safely
- **File operations**: Read and modify files in your workspace

### Configure Tool Permissions
```bash
gh copilot config set tools.web_browsing true
gh copilot config set tools.code_execution true
gh copilot config set tools.file_operations true
```

## Usage Information

### Context Window Information
View context window limits for your current model:

```bash
gh copilot info context
```

### Usage Statistics
Check your usage and limits:

```bash
gh copilot usage
```

### Token Usage
See detailed token usage:

```bash
gh copilot usage --detailed
```

### Rate Limits
Check current rate limits:

```bash
gh copilot limits
```

## Common Commands

### Start a Chat Session
```bash
gh copilot chat
```

### Ask a Quick Question
```bash
gh copilot ask "How do I optimize this SQL query?"
```

### Generate Code
```bash
gh copilot generate --language python --task "create a REST API endpoint"
```

### Explain Code
```bash
gh copilot explain --file ./src/main.py
```

## Tips and Tricks

### 1. Use Context Effectively
- Keep relevant files open in your editor
- Provide clear, specific questions
- Use the `--include` flag to add specific files to context

### 2. Model Selection Tips
- Use **GPT-4** for complex reasoning and detailed explanations
- Use **GPT-3.5** for faster responses and simpler tasks
- Switch models based on your current needs

### 3. Tool Usage Best Practices
- Enable web browsing when you need current information
- Use code execution for testing snippets
- Be mindful of file operation permissions

### 4. Managing Context Window
- Monitor your token usage with `gh copilot usage`
- Break down large problems into smaller questions
- Use `gh copilot clear` to reset conversation context when needed

### 5. Productivity Shortcuts
```bash
# Create aliases for common commands
alias ghc="gh copilot chat"
alias gha="gh copilot ask"
alias ghg="gh copilot generate"

# Use environment variables for consistent settings
export GH_COPILOT_MODEL="gpt-4"
export GH_COPILOT_TOOLS_ENABLED="true"
```

### 6. Integration with Development Workflow
```bash
# Use with git for commit messages
gh copilot ask "Generate a commit message for these changes:" --include-diff

# Code review assistance
gh copilot explain --file ./changes.diff

# Debug help
gh copilot ask "Help me debug this error: $(cat error.log | tail -20)"
```

## Configuration Reference

### Global Configuration File
Location: `~/.config/gh/copilot/config.yml`

Example configuration:
```yaml
default_model: gpt-4
tools:
  enabled: true
  web_browsing: true
  code_execution: false
  file_operations: true
preferences:
  verbose: false
  auto_save_conversations: true
  context_window_warning: 0.8
```

### Environment Variables
- `GH_COPILOT_MODEL`: Override default model
- `GH_COPILOT_TOOLS`: Enable/disable tools
- `GH_COPILOT_VERBOSE`: Enable verbose output
- `GH_COPILOT_CONFIG_PATH`: Custom config file path

## Troubleshooting

### Common Issues

#### Authentication Problems
```bash
gh auth status
gh auth refresh
```

#### Model Access Issues
```bash
gh copilot auth check
gh copilot model test <model-name>
```

#### Tool Permission Errors
```bash
gh copilot config reset tools
gh copilot config set tools.enabled true
```

## Advanced Usage

### Custom Prompts
Create reusable prompt templates:

```bash
# Save a prompt template
gh copilot template save "code-review" "Review this code for security issues and performance optimizations"

# Use a saved template
gh copilot template use "code-review" --file ./src/auth.py
```

### Batch Operations
Process multiple files or questions:

```bash
# Explain multiple files
find ./src -name "*.py" -exec gh copilot explain --file {} \;

# Generate documentation for all modules
gh copilot batch --task "generate documentation" --pattern "src/**/*.py"
```

---

For more information, visit the [GitHub Copilot CLI documentation](https://docs.github.com/en/copilot/github-copilot-in-the-cli).