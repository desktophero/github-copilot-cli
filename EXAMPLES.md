# Practical Examples

> **⚠️ MIGRATION NOTICE**: These examples have been updated for the new standalone GitHub
> Copilot CLI (`copilot`), not the deprecated `gh copilot` extension.

## Common Development Scenarios

### 1. Code Review and Analysis

With the new CLI, interactions are conversational within the copilot interface:

```bash
# Launch copilot in your project directory
cd /path/to/your/project
copilot

# Then use natural language prompts:
# "Review my staged changes for security issues"
# "Analyze the complexity of the authentication module"
# "Are there performance bottlenecks in this API?"
```

### 2. Debugging Help

```bash
# Launch copilot from your project root
copilot

# Natural language debugging:
# "I'm getting a TypeError in my Python script, can you help debug it?"
# "Explain this stack trace: [paste your stack trace]" 
# "The authentication function isn't working correctly, what could be wrong?"
```

### 3. Code Generation

```bash
# In copilot session:
# "Create a REST API endpoint for user authentication with JWT"
# "Generate unit tests for the User class"
# "Write a Python function to parse CSV files and handle errors"
```

### 4. Learning and Explanation

```bash
# In copilot session:
# "Explain how the authentication system works in this project"
# "What are the best practices for error handling in this codebase?"
# "Teach me about dependency injection with examples"
```

## Configuration Examples

### Setting Up Your Environment

```bash
# Install the new standalone CLI
npm install -g @github/copilot

# Set up authentication (PAT method)
export GH_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxx"

# Set preferred model
export COPILOT_MODEL=claude-sonnet-4  # or gpt-5

# Create shell aliases
echo 'alias cop="copilot"' >> ~/.bashrc
echo 'alias cop5="COPILOT_MODEL=gpt-5 copilot"' >> ~/.bashrc
```

### Model Switching Workflows

```bash
# Start with default model (Claude Sonnet 4)
copilot
# Ask: "Give me an overview of this codebase"

# Exit and switch to GPT-5 for complex analysis
COPILOT_MODEL=gpt-5 copilot  
# Ask: "Design a new architecture for better scalability"

# Create aliases for easy switching
alias cop="copilot"
alias cop5="COPILOT_MODEL=gpt-5 copilot"
```

## Workflow Integration Examples

### Git Integration

The new CLI automatically detects your git context:

```bash
# Launch from your project directory
cd /path/to/your/project
copilot

# Natural language git workflows:
# "Generate a commit message for my staged changes"
# "Review what I've changed since the last commit"
# "Explain what happened in the last 5 commits"
# "Help me resolve this merge conflict"
```

### Project-Based Development

```bash
# Always launch from your project root
cd /path/to/your/project
copilot

# The CLI automatically understands your project context:
# "Help me understand how this authentication system works"
# "Create tests for the payment processing module"
# "Review my recent changes for security issues"
# "Help me optimize the database queries in this project"
```

### Documentation Workflows

```bash
# In your project directory
copilot

# Documentation tasks:
# "Create API documentation for the user endpoints"
# "Update the README with the new features I added"
# "Generate a changelog from my recent commits"
# "Write installation instructions for this project"
```

## Advanced Use Cases

### Architecture Planning

```bash
# In your project directory
copilot

# Architecture discussions:
# "Help me design a microservices architecture for this e-commerce platform"
# "What database schema would work best for this application?"
# "How can I optimize this system for high load?"
```

### Security Analysis

```bash
# Security-focused sessions
copilot

# Security queries:
# "Review this authentication system for security vulnerabilities"
# "Are there any security issues in my user registration flow?"
# "Help me create security guidelines for this project"
```

### Code Migration

```bash
# Migration assistance
copilot

# Migration tasks:
# "Help me convert this Python Flask app to FastAPI"
# "What would this JavaScript code look like in TypeScript?"
# "Guide me through migrating from MySQL to PostgreSQL"
```

## Team Collaboration Examples

### Code Review Workflows

```bash
# Launch copilot in the project with pending changes
copilot

# Collaborative review tasks:
# "Summarize the changes I made for my team"
# "Review this code and suggest improvements"  
# "What should I tell reviewers about these changes?"
```

### Knowledge Sharing

```bash
# Knowledge transfer sessions
copilot

# Knowledge sharing:
# "Create onboarding documentation for new developers on this project"
# "Document why we chose this architecture approach"
# "Create a tutorial for using this authentication system"
```

## Productivity Shortcuts

### Aliases and Functions

Add to your `.bashrc` or `.zshrc`:

```bash
# Quick aliases for the new CLI
alias cop="copilot"
alias cop5="COPILOT_MODEL=gpt-5 copilot"
alias copb="copilot --banner"

# Set default model
export COPILOT_MODEL=claude-sonnet-4

# Authentication
export GH_TOKEN="your-personal-access-token"

# Useful functions
function cophelp() {
    echo "GitHub Copilot CLI Commands:"
    echo "  cop     - Launch with default model (Claude Sonnet 4)"
    echo "  cop5    - Launch with GPT-5"
    echo "  copb    - Launch with banner"
    echo ""
    echo "Within copilot:"
    echo "  /help      - Show available commands"
    echo "  /login     - Authenticate with GitHub"
    echo "  /feedback  - Submit feedback"
}

function copauth() {
    echo "Setting up Copilot authentication..."
    echo "1. Create PAT at: https://github.com/settings/personal-access-tokens/new"
    echo "2. Add 'Copilot Requests' permission"
    echo "3. Set: export GH_TOKEN=\"your-pat-here\""
}
```

### Development Integration

```bash
# Project-specific workflows
function copproject() {
    cd /path/to/your/project
    echo "Launching Copilot in project: $(basename $(pwd))"
    copilot
}

# Model-specific launches
function copgpt5() {
    echo "Launching Copilot with GPT-5..."
    COPILOT_MODEL=gpt-5 copilot
}

function copclaude() {
    echo "Launching Copilot with Claude Sonnet 4..."
    COPILOT_MODEL=claude-sonnet-4 copilot
}

# Quick checks
function copcheck() {
    echo "Checking Copilot CLI setup..."
    echo "Node.js: $(node --version)"
    echo "npm: $(npm --version)"
    echo "Copilot: $(copilot --version 2>/dev/null || echo 'Not installed')"
    echo "Auth token: ${GH_TOKEN:+Set} ${GH_TOKEN:-Not set}"
    echo "Model: ${COPILOT_MODEL:-Default (Claude Sonnet 4)}"
}
```

## Error Handling Examples

### Common Issues and Solutions

```bash
# Installation issues
npm install -g @github/copilot  # Reinstall if needed
node --version  # Ensure version 22+

# Authentication problems
export GH_TOKEN="your-pat-here"
copilot
# Use /login command for OAuth

# Model availability
COPILOT_MODEL=claude-sonnet-4 copilot  # Try default model
COPILOT_MODEL=gpt-5 copilot           # Try alternative model

# General troubleshooting session
copilot
# Ask: "I'm having trouble with [describe your issue], can you help troubleshoot?"
```

### Migration from Old CLI

```bash
# Remove old extension
gh extension remove github/gh-copilot

# Clear old configuration (optional)
rm -rf ~/.config/gh/copilot/

# Install new CLI
npm install -g @github/copilot

# Set up authentication
export GH_TOKEN="your-pat-with-copilot-requests-permission"

# Test installation
copilot --version
copilot --banner  # First launch with banner
```

> **⚠️ Note**: Many advanced features from the old CLI are being reimplemented. Check the
> [official repository](https://github.com/github/copilot-cli) for the latest feature updates and
> migration guides.
