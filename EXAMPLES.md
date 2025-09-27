# Practical Examples

## Common Development Scenarios

### 1. Code Review and Analysis

```bash
# Review a pull request
gh copilot ask "Review this PR for security issues and best practices" --include-diff

# Analyze code complexity
gh copilot ask "How can I simplify this function?" --include src/complex_function.py

# Check for performance issues
gh copilot ask "Are there any performance bottlenecks in this code?" --include src/api.py
```

### 2. Debugging Help

```bash
# Debug an error
gh copilot ask "Why am I getting this error?" --include error.log

# Explain stack trace
gh copilot ask "Explain this stack trace and suggest fixes" --code "$(cat stack_trace.txt)"

# Debug with context
gh copilot ask "Help debug this function that's not working correctly" --include src/broken.py --execute
```

### 3. Code Generation

```bash
# Generate API endpoint
gh copilot generate --language python --task "REST API endpoint for user authentication with JWT"

# Create test cases
gh copilot ask "Generate unit tests for this class" --include src/user.py --create-file tests/test_user.py

# Generate documentation
gh copilot ask "Create README documentation for this project" --include-dir src/ --create-file README.md
```

### 4. Learning and Explanation

```bash
# Understand complex code
gh copilot ask "Explain how this algorithm works step by step" --include algorithms/quicksort.py

# Learn new concepts
gh copilot ask "Explain dependency injection with examples in Python" --execute

# Best practices
gh copilot ask "What are the best practices for error handling in this code?" --include src/api.py
```

## Configuration Examples

### Setting Up Your Environment

```bash
# Initial setup
gh extension install github/gh-copilot
gh auth login
gh copilot config set model gpt-4
gh copilot config set tools.enabled true

# Create config file
cat > ~/.config/gh/copilot/config.yml << EOF
default_model: gpt-4
tools:
  enabled: true
  web_browsing: true
  code_execution: true
  file_operations: true
preferences:
  verbose: false
  auto_save_conversations: true
alerts:
  daily_tokens: 15000
  context_usage: 0.8
EOF
```

### Model Switching Workflows

```bash
# Start with fast model for exploration
gh copilot config set model gpt-3.5-turbo
gh copilot ask "Give me an overview of this codebase" --include-dir src/

# Switch to powerful model for complex analysis
gh copilot config set model gpt-4
gh copilot ask "Design a new architecture for better scalability"

# Use extended context for large files
gh copilot ask "Refactor this entire module" --include large_module.py --model gpt-4-32k
```

## Workflow Integration Examples

### Git Integration

```bash
# Generate commit messages
gh copilot ask "Generate a commit message for these changes:" --include-diff

# Code review before commit
gh copilot ask "Review my staged changes" --code "$(git diff --staged)"

# Explain git history
gh copilot ask "Explain what changed in the last 5 commits" --code "$(git log --oneline -5)"
```

### CI/CD Integration

```bash
# Analyze test failures
gh copilot ask "Why are these tests failing?" --include test_output.log

# Generate GitHub Actions workflow
gh copilot generate --task "GitHub Actions workflow for Python project with tests and linting" --create-file .github/workflows/ci.yml

# Fix deployment issues
gh copilot ask "Help fix this deployment error" --include deployment.log --web
```

### Documentation Workflows

```bash
# Generate API documentation
gh copilot ask "Create API documentation for these endpoints" --include-dir api/ --create-file docs/api.md

# Update README
gh copilot ask "Update the README with new features" --modify README.md --include-dir src/

# Generate changelog
gh copilot ask "Generate changelog from recent commits" --code "$(git log --since='1 month ago' --pretty=format:'%h %s')"
```

## Advanced Use Cases

### Architecture Planning

```bash
# System design
gh copilot ask "Design a microservices architecture for an e-commerce platform" --web

# Database schema
gh copilot ask "Design database schema for this application" --include requirements.md --execute

# Performance optimization
gh copilot ask "How can I optimize this system for high load?" --include-dir src/ --web
```

### Security Analysis

```bash
# Security audit
gh copilot ask "Perform security audit on this code" --include-dir src/ --web

# Check for vulnerabilities
gh copilot ask "Are there any security vulnerabilities in this authentication system?" --include auth/

# Generate security documentation
gh copilot ask "Create security guidelines for this project" --create-file SECURITY.md
```

### Code Migration

```bash
# Language migration
gh copilot ask "Convert this Python code to JavaScript" --include old_script.py --create-file new_script.js

# Framework migration
gh copilot ask "Migrate this Flask app to FastAPI" --include app.py

# Database migration
gh copilot ask "Create migration script from MySQL to PostgreSQL" --include schema.sql
```

## Team Collaboration Examples

### Code Review Workflows

```bash
# Prepare for review
gh copilot ask "Summarize changes in this PR for reviewers" --include-diff

# Address review comments
gh copilot ask "Fix the issues mentioned in this review comment" --include review_comment.txt --modify src/file.py

# Review someone else's code
gh copilot ask "Review this code and suggest improvements" --include colleague_code.py
```

### Knowledge Sharing

```bash
# Explain codebase to new team members
gh copilot ask "Create onboarding documentation for new developers" --include-dir src/ --create-file docs/onboarding.md

# Document decisions
gh copilot ask "Document why we chose this architecture" --include architecture.md --create-file docs/decisions.md

# Create tutorials
gh copilot ask "Create tutorial for this feature" --include feature/ --create-file tutorials/feature_guide.md
```

## Productivity Shortcuts

### Aliases and Functions

Add to your `.bashrc` or `.zshrc`:

```bash
# Quick aliases
alias ghc="gh copilot chat"
alias gha="gh copilot ask"
alias ghg="gh copilot generate"
alias ghu="gh copilot usage"

# Useful functions
function ghreview() {
    gh copilot ask "Review this file: $1" --include "$1"
}

function ghexplain() {
    gh copilot ask "Explain this code: $1" --include "$1"
}

function ghfix() {
    gh copilot ask "Fix issues in this file: $1" --modify "$1"
}

function ghdebug() {
    gh copilot ask "Debug this error: $1" --code "$1" --execute
}
```

### IDE Integration

```bash
# VS Code integration (if using Copilot Chat extension)
gh copilot ask "Open this in VS Code with explanation" --include src/main.py

# Terminal workflow
gh copilot ask "What should I run next?" --include package.json

# File watching for continuous help
watch -n 5 'gh copilot usage --today'
```

## Error Handling Examples

### Common Issues and Solutions

```bash
# When model is unavailable
gh copilot ask "Same question but simpler" --model gpt-3.5-turbo

# When context is too large
gh copilot ask "Summarize the main issues" --include large_file.py
gh copilot clear
gh copilot ask "Now help with specific part" --include small_section.py

# When rate limited
gh copilot limits
gh copilot config set model gpt-3.5-turbo  # Switch to faster model
```

### Backup Workflows

```bash
# Save important conversations
gh copilot export conversation --id last --output important_discussion.md

# Backup configuration
cp ~/.config/gh/copilot/config.yml ~/backup/copilot-config-$(date +%Y%m%d).yml

# Restore configuration
cp ~/backup/copilot-config-20240115.yml ~/.config/gh/copilot/config.yml
```