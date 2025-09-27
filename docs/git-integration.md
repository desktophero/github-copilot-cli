# Git Integration and Commit Signing

## Overview

Configure GitHub Copilot CLI to consistently use signed commits and follow your git workflow preferences across all projects.

## Global Git Configuration

### Set Default Commit Behavior

```bash
# Always use -sS flags for commits (sign and add Signed-off-by)
gh copilot config set git.default_commit_flags "-sS"

# Require signed commits
gh copilot config set git.require_signed_commits true

# Enable conventional commits format
gh copilot config set git.conventional_commits true

# Auto-suggest signing
gh copilot config set git.auto_sign true
```text

### Git Preferences in Global Instructions

Add to `~/.config/gh/copilot/instructions.md`:

```markdown
## Git Workflow Standards

### Commit Signing Requirements
- Always use `git commit -sS` for all commits
  - `-s` adds Signed-off-by line with your email
  - `-S` adds GPG signature to commit
- Ensure GPG key is properly configured
- All commits must be signed for security

### Commit Message Format
Use conventional commit format:
```text

<type>(<scope>): <description>

[optional body]

[optional footer(s)]

```text

Types: feat, fix, docs, style, refactor, test, chore, ci, build, perf

Examples:
- `feat(auth): add user authentication endpoint`
- `fix(api): resolve validation error handling`
- `docs(readme): update installation instructions`
- `refactor(database): optimize query performance`

### Branch Naming
- Feature branches: `feature/description` or `feat/description`
- Bug fixes: `fix/description` or `bugfix/description`
- Documentation: `docs/description`
- Refactoring: `refactor/description`

### Workflow Preferences
- Create meaningful commit messages
- Squash commits when appropriate
- Use pull requests for all changes
- Review code before merging
- Keep commits atomic and focused
```text

## GPG Setup for Commit Signing

### Prerequisites Check

```bash
# Check if GPG key exists
gpg --list-secret-keys --keyid-format=long

# Check git configuration
git config --global user.signingkey
git config --global commit.gpgsign
```text

### GPG Setup Commands

If you need to set up GPG signing:

```bash
# Generate new GPG key (if needed)
gpg --full-generate-key

# List keys to get key ID
gpg --list-secret-keys --keyid-format=long

# Configure git to use GPG key (replace KEY_ID with your key)
git config --global user.signingkey KEY_ID
git config --global commit.gpgsign true

# Add GPG key to GitHub account
gpg --armor --export KEY_ID
```text

### Verification

```bash
# Test signed commit
git commit -sS -m "test: verify GPG signing setup"

# Verify signature
git log --show-signature -1
```text

## Copilot Integration with Git

### Automatic Commit Generation

With global configuration, Copilot will always suggest signed commits:

```bash
# Generate commit message
gh copilot ask "Generate a commit message for my changes" --include-diff
# Will automatically suggest using -sS flags

# Interactive commit help
gh copilot ask "Help me commit these database schema changes" --include-diff
# Will generate conventional format message and remind about signing
```text

### Example Commit Workflows

```bash
# Feature development workflow
gh copilot ask "I've added user authentication. Help me create proper commits for these changes" --include-diff

# Bug fix workflow  
gh copilot ask "I fixed a validation bug. Create an appropriate commit message" --include-diff

# Documentation updates
gh copilot ask "I updated the README. Generate a commit message" --include README.md
```text

## Advanced Git Configuration

### Complete Git Section in Config

Add to `~/.config/gh/copilot/config.yml`:

```yaml
git:
  # Commit signing
  default_commit_flags: "-sS"
  require_signed_commits: true
  auto_sign: true
  
  # Commit format
  conventional_commits: true
  enforce_format: true
  
  # Default commit types
  default_types:
    - "feat"
    - "fix" 
    - "docs"
    - "style"
    - "refactor"
    - "test"
    - "chore"
    - "ci"
    - "build"
    - "perf"
  
  # Branch naming
  branch_naming:
    feature_prefix: "feature/"
    bugfix_prefix: "fix/"
    docs_prefix: "docs/"
    
  # Workflow preferences
  workflow:
    require_pr: true
    squash_commits: false
    delete_merged_branches: true
    
  # Security
  verify_signatures: true
  require_signature_verification: true
```text

### Git Hooks Integration

Copilot can help set up git hooks that enforce your standards:

```bash
# Setup pre-commit hooks
gh copilot ask "Create a pre-commit hook that ensures commits are signed and follow conventional format"

# Setup commit message validation
gh copilot ask "Create commit-msg hook to validate conventional commit format"
```text

## Practical Examples

### Daily Development Workflow

```bash
# Start feature work
gh copilot ask "I'm starting work on user authentication. What git commands should I use?"
# Response will include: branch creation, signed commits, etc.

# Mid-development commits
gh copilot ask "I've implemented the login endpoint. Help me commit this work" --include src/auth/
# Will generate proper commit message with signing

# Ready for review
gh copilot ask "My feature is complete. Help me prepare it for review" --include-diff
# Will suggest final commits, PR creation, etc.
```text

### Commit Message Generation

With global configuration, all commit messages will follow your format:

```bash
# Basic change
gh copilot ask "Generate commit message for bug fix" --include-diff
# Output: "fix(validation): resolve email format validation error"

# Feature addition
gh copilot ask "Generate commit message for new API endpoint" --include-diff  
# Output: "feat(api): add user registration endpoint with validation"

# Documentation update
gh copilot ask "Generate commit message" --include README.md
# Output: "docs(readme): update installation and usage instructions"
```text

### Multi-Commit Workflows

```bash
# Complex feature with multiple commits
gh copilot ask "I've built a complete authentication system. \
Help me create a series of well-structured commits" --include src/auth/

# Expected response will suggest:
# 1. feat(auth): add user model and database schema
# 2. feat(auth): implement user registration endpoint  
# 3. feat(auth): add login and JWT token generation
# 4. feat(auth): implement logout and token validation
# 5. test(auth): add comprehensive authentication tests
# 6. docs(auth): add authentication API documentation
```text

## Team Configuration

### Shared Git Standards

Create team configuration file:

```yaml
# team-git-config.yml
git:
  default_commit_flags: "-sS"
  require_signed_commits: true
  conventional_commits: true
  
  # Team-specific scopes
  scopes:
    - "api"
    - "web"
    - "database" 
    - "auth"
    - "deployment"
    
  # Team workflow
  workflow:
    require_pr: true
    require_reviews: 2
    enforce_linear_history: true
    
  # Branch protection
  branch_protection:
    main:
      require_signed_commits: true
      require_status_checks: true
      require_up_to_date: true
```text

### Team Setup Script

```bash
#!/bin/bash
# setup-team-git.sh

echo "Setting up team git configuration for GitHub Copilot CLI..."

# Apply team git settings
gh copilot config set git.default_commit_flags "-sS"
gh copilot config set git.require_signed_commits true
gh copilot config set git.conventional_commits true

# Team-specific settings
gh copilot config set git.scopes "api,web,database,auth,deployment"
gh copilot config set git.workflow.require_pr true

echo "Team git configuration applied!"
echo "Remember to:"
echo "1. Configure your GPG key for commit signing"
echo "2. Add your GPG key to your GitHub account" 
echo "3. Test with: git commit -sS -m 'test: verify setup'"
```text

## Troubleshooting

### Common Issues

```bash
# GPG signing not working
gh copilot ask "My commits aren't being signed. Help me troubleshoot GPG setup"

# Commit message format validation
gh copilot ask "My commits are being rejected for format. Show me the correct conventional commit format"

# Configuration not applying
gh copilot config get git.default_commit_flags
gh copilot config validate git
```text

### Debug Commands

```bash
# Check git configuration
git config --global --list | grep -E "(sign|gpg)"

# Test GPG
gpg --list-secret-keys
echo "test" | gpg --clearsign

# Verify Copilot git config
gh copilot config get git --verbose
```text

### Reset Git Configuration

```bash
# Reset git section
gh copilot config reset git

# Reapply your preferences
gh copilot config set git.default_commit_flags "-sS"
gh copilot config set git.require_signed_commits true
```text

## Integration with Other Tools

### Pre-commit Hooks

```bash
# Install pre-commit
pip install pre-commit

# Create .pre-commit-config.yaml
gh copilot ask "Create pre-commit configuration that ensures signed commits and conventional format"
```text

### IDE Integration

```bash
# VS Code settings for git signing
gh copilot ask "Create VS Code settings to always use signed commits"

# Git alias setup
gh copilot ask "Create git aliases for common signed commit operations"
```text

This configuration ensures that GitHub Copilot CLI will consistently remind you about commit
signing and format your commits according to your team's standards across all projects.
