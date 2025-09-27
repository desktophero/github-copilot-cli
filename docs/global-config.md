# Global Configuration and Instructions

## Overview

GitHub Copilot CLI can be configured with global instructions and preferences that apply across
all conversations and projects. This guide shows how to set up persistent configurations,
including specific development preferences like git commit signing and Python project structure.

## Global Configuration File

### Location

The main configuration file is located at:

```bash
~/.config/gh/copilot/config.yml
```text

### Creating the Configuration Directory

```bash
# Create config directory if it doesn't exist
mkdir -p ~/.config/gh/copilot

# Create the main config file
touch ~/.config/gh/copilot/config.yml
```text

## Setting Global Instructions

### Instructions File

Create a global instructions file that Copilot will reference in all conversations:

```bash
# Create instructions file
touch ~/.config/gh/copilot/instructions.md
```text

### Example Global Instructions

Edit `~/.config/gh/copilot/instructions.md`:

```markdown
# Global Development Instructions

## Git Commit Preferences
- Always use `git commit -sS` to sign commits with GPG
- Include the `-s` flag for Signed-off-by line
- Include the `-S` flag for GPG signature
- Follow conventional commit format: `type(scope): description`

## Python Project Structure
- Use pipenv for dependency management
- Always create and maintain Pipfile and Pipfile.lock
- Standard project structure:
  ```

  project/
  ├── Pipfile
  ├── Pipfile.lock
  ├── src/
  │   └── package_name/
  ├── tests/
  ├── docs/
  └── README.md

```text
- Use pytest for testing
- Follow PEP 8 style guidelines
- Use black for code formatting
- Use isort for import sorting

## Code Style Preferences
- Use meaningful variable names
- Add type hints for all functions
- Include docstrings for all public functions
- Prefer composition over inheritance
- Write unit tests for all new functionality

## Security Preferences
- Never commit secrets or sensitive data
- Use environment variables for configuration
- Validate all user inputs
- Use parameterized queries for database operations

## Documentation Standards
- Update README.md for any significant changes
- Include usage examples in docstrings
- Document API changes in CHANGELOG.md
- Use clear, concise commit messages
```text

## Configuration Commands

### Set Global Instructions

```bash
# Set the path to your global instructions
gh copilot config set instructions ~/.config/gh/copilot/instructions.md

# Enable global instructions
gh copilot config set use_global_instructions true

# Verify configuration
gh copilot config get instructions
```text

### Additional Global Settings

```bash
# Set default behavior for git operations
gh copilot config set git.default_commit_flags "-sS"
gh copilot config set git.require_signed_commits true

# Set Python-specific preferences
gh copilot config set python.dependency_manager "pipenv"
gh copilot config set python.use_pipfile true
gh copilot config set python.test_framework "pytest"
gh copilot config set python.formatter "black"
gh copilot config set python.import_sorter "isort"

# Set project structure preferences
gh copilot config set project.python.structure "src-layout"
gh copilot config set project.python.tests_directory "tests"
gh copilot config set project.python.docs_directory "docs"
```text

## Complete Configuration Example

### Full `~/.config/gh/copilot/config.yml`

```yaml
# GitHub Copilot CLI Global Configuration

# Model and performance settings
default_model: gpt-4
tools:
  enabled: true
  web_browsing: true
  code_execution: true
  file_operations: true

# Global instructions
instructions: ~/.config/gh/copilot/instructions.md
use_global_instructions: true

# Git preferences
git:
  default_commit_flags: "-sS"
  require_signed_commits: true
  conventional_commits: true
  auto_sign: true

# Python-specific settings
python:
  dependency_manager: "pipenv"
  use_pipfile: true
  virtual_env_tool: "pipenv"
  test_framework: "pytest"
  formatter: "black"
  linter: "flake8"
  import_sorter: "isort"
  type_checker: "mypy"

# Project structure preferences
project:
  python:
    structure: "src-layout"
    source_directory: "src"
    tests_directory: "tests"
    docs_directory: "docs"
    config_files:
      - "Pipfile"
      - "Pipfile.lock"
      - "pyproject.toml"
      - "setup.cfg"

# Code style preferences
code_style:
  line_length: 88
  use_type_hints: true
  require_docstrings: true
  follow_pep8: true

# Security settings
security:
  scan_for_secrets: true
  require_env_vars: true
  validate_inputs: true

# Usage and monitoring
alerts:
  daily_tokens: 15000
  daily_cost: 10.00
  context_usage: 0.8

# Conversation preferences
conversation:
  auto_save: true
  include_context_files: true
  verbose_explanations: false
  code_examples: true
```text

## Applying Configurations to All Conversations

### Enable Global Context

```bash
# Make instructions apply to all new conversations
gh copilot config set conversation.use_global_context true

# Include project preferences in all coding tasks
gh copilot config set conversation.include_project_prefs true

# Automatically apply code style preferences
gh copilot config set conversation.enforce_style_prefs true
```text

### Test Your Configuration

```bash
# Test that global instructions are loaded
gh copilot ask "How should I commit my changes?"
# Should respond with information about using -sS flags

# Test Python project setup
gh copilot ask "Create a new Python project structure"
# Should create structure with pipenv and your preferred layout

# Test git integration
gh copilot ask "Generate a commit message for these changes" --include-diff
# Should generate conventionally formatted message and mention signing
```text

## Project-Specific Overrides

### Local Configuration

Create `.copilot/config.yml` in project root for project-specific overrides:

```yaml
# Project-specific overrides
python:
  test_framework: "unittest"  # Override global pytest preference
  additional_dependencies:
    - "fastapi"
    - "uvicorn"

git:
  conventional_commit_scope: "api"  # Default scope for this project

project:
  type: "web-api"
  framework: "fastapi"
```text

### Environment-Specific Instructions

```bash
# Create environment-specific instruction files
mkdir -p ~/.config/gh/copilot/environments

# Development environment
cat > ~/.config/gh/copilot/environments/development.md << EOF
# Development Environment Instructions
- Use local database connections
- Enable debug logging
- Use development API endpoints
- Create detailed commit messages
EOF

# Production environment  
cat > ~/.config/gh/copilot/environments/production.md << EOF
# Production Environment Instructions
- Use environment variables for all configs
- Ensure proper error handling
- Add comprehensive logging
- Require code review before deployment
EOF

# Activate environment-specific instructions
gh copilot config set environment development
```text

## Automation Scripts

### Setup Script

Create `~/.config/gh/copilot/setup.sh`:

```bash
#!/bin/bash
# GitHub Copilot CLI Global Setup Script

echo "Setting up GitHub Copilot CLI global configuration..."

# Create config directory
mkdir -p ~/.config/gh/copilot

# Set global instructions
gh copilot config set instructions ~/.config/gh/copilot/instructions.md
gh copilot config set use_global_instructions true

# Git settings
gh copilot config set git.default_commit_flags "-sS"
gh copilot config set git.require_signed_commits true

# Python settings
gh copilot config set python.dependency_manager "pipenv"
gh copilot config set python.use_pipfile true
gh copilot config set python.formatter "black"

# Enable tools
gh copilot config set tools.enabled true
gh copilot config set tools.code_execution true

echo "Global configuration completed!"
echo "Edit ~/.config/gh/copilot/instructions.md to customize your global instructions."
```text

Make it executable and run:

```bash
chmod +x ~/.config/gh/copilot/setup.sh
~/.config/gh/copilot/setup.sh
```text

## Validation and Testing

### Validate Configuration

```bash
# Check all configuration settings
gh copilot config list --global

# Validate instructions file
gh copilot config validate instructions

# Test global preferences
gh copilot test config --all
```text

### Common Commands to Test

```bash
# Test git commit workflow
gh copilot ask "I made changes to my Python project, help me commit them properly"

# Test Python project creation
gh copilot ask "Create a new Python web API project with proper structure"

# Test code generation with preferences
gh copilot generate --language python --task "user authentication endpoint with type hints"
```text

## Sharing Configuration with Team

### Export Configuration

```bash
# Export your configuration for sharing
gh copilot config export --output my-copilot-config.yml

# Include instructions in export
gh copilot config export --include-instructions --output complete-config.tar.gz
```text

### Team Setup Script

Create `team-setup.sh` for team members:

```bash
#!/bin/bash
# Team GitHub Copilot CLI Setup

# Download team configuration
curl -O https://your-team-repo.com/copilot-config.yml

# Apply team configuration
gh copilot config import copilot-config.yml

# Set team-specific instructions
gh copilot config set instructions ./team-instructions.md

echo "Team configuration applied!"
echo "Run 'gh copilot config list' to verify settings."
```text

## Troubleshooting Global Configuration

### Common Issues

```bash
# Instructions not loading
gh copilot config get instructions
gh copilot config set use_global_instructions true

# Git settings not applying
gh copilot config get git.default_commit_flags
gh copilot test config --git

# Python preferences ignored
gh copilot config validate python
gh copilot config reset python  # Reset and reconfigure if needed
```text

### Reset Configuration

```bash
# Reset all configuration to defaults
gh copilot config reset --all --confirm

# Reset specific section
gh copilot config reset git
gh copilot config reset python

# Backup before reset
cp ~/.config/gh/copilot/config.yml ~/.config/gh/copilot/config.yml.backup
```text
