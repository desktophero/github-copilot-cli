#!/bin/bash
# GitHub Copilot CLI Global Setup Script
# This script configures GitHub Copilot CLI with opinionated defaults for:
# - Git commit signing with -sS flags
# - Python development with pipenv and src-layout
# - Conventional commit format
# - Development best practices

set -e

echo "🤖 GitHub Copilot CLI Global Configuration Setup"
echo "================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check prerequisites
echo "Checking prerequisites..."

# Check Node.js version
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version | sed 's/v//' | cut -d'.' -f1)
    if [ "$NODE_VERSION" -ge 18 ]; then
        log_info "Node.js version $(node --version) meets minimum requirements"
        if [ "$NODE_VERSION" -lt 22 ]; then
            log_warn "Node.js $(node --version) detected. Version 22+ recommended for best performance"
            log_warn "Consider upgrading with: nvm install 22 && nvm use 22"
        fi
    else
        log_error "Node.js version $(node --version) is too old. Minimum required: 18.x, Recommended: 22.x"
        echo "To upgrade Node.js:"
        echo "  1. Install NVM: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
        echo "  2. Reload shell: source ~/.bashrc"
        echo "  3. Install Node 22: nvm install 22 && nvm use 22"
        exit 1
    fi
else
    log_error "Node.js is not installed. Please install Node.js 22 first:"
    echo "  https://nodejs.org/ or use NVM for easier version management"
    exit 1
fi

# Check npm version
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version | cut -d'.' -f1)
    if [ "$NPM_VERSION" -ge 9 ]; then
        log_info "npm version $(npm --version) is compatible"
    else
        log_warn "npm version $(npm --version) is old. Consider updating: npm install -g npm@latest"
    fi
else
    log_error "npm is not installed (should come with Node.js)"
    exit 1
fi

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    log_error "GitHub CLI (gh) is not installed. Please install it first:"
    echo "  macOS: brew install gh"
    echo "  Ubuntu: sudo apt install gh (after adding GitHub CLI repository)"
    echo "  More info: https://cli.github.com/"
    exit 1
fi

# Check GitHub CLI version
GH_VERSION=$(gh --version | head -n1 | grep -oE '[0-9]+\.[0-9]+' | head -n1)
REQUIRED_GH_VERSION="2.40"
if [[ $(echo "$GH_VERSION >= $REQUIRED_GH_VERSION" | bc -l 2>/dev/null) != "1" ]]; then
    if [[ "$GH_VERSION" < "$REQUIRED_GH_VERSION" ]]; then
        log_error "GitHub CLI version $GH_VERSION is too old. Minimum required: $REQUIRED_GH_VERSION"
        echo "Please update GitHub CLI:"
        echo "  macOS: brew upgrade gh"
        echo "  Ubuntu: sudo apt update && sudo apt upgrade gh"
        exit 1
    fi
fi
log_info "GitHub CLI version $GH_VERSION meets requirements"

# Check if gh copilot extension is installed
if ! gh extension list | grep -q "github/gh-copilot"; then
    log_warn "GitHub Copilot CLI extension not found. Installing..."
    gh extension install github/gh-copilot
    log_info "GitHub Copilot CLI extension installed"
else
    log_info "GitHub Copilot CLI extension found"
fi

# Check authentication
if ! gh auth status &> /dev/null; then
    log_error "Not authenticated with GitHub. Please run: gh auth login"
    exit 1
fi
log_info "GitHub authentication verified"

# Create configuration directory
CONFIG_DIR="$HOME/.config/gh/copilot"
mkdir -p "$CONFIG_DIR"
log_info "Configuration directory created: $CONFIG_DIR"

# Create global instructions file
INSTRUCTIONS_FILE="$CONFIG_DIR/instructions.md"
echo "Creating global instructions file..."

cat > "$INSTRUCTIONS_FILE" << 'EOF'
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
  ```
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
EOF

log_info "Global instructions created: $INSTRUCTIONS_FILE"

# Apply global configuration
echo "Applying global configuration..."

# Basic settings
gh copilot config set instructions "$INSTRUCTIONS_FILE" || log_warn "Failed to set instructions path"
gh copilot config set use_global_instructions true || log_warn "Failed to enable global instructions"

# Git preferences
gh copilot config set git.default_commit_flags "-sS" || log_warn "Failed to set git commit flags"
gh copilot config set git.require_signed_commits true || log_warn "Failed to require signed commits"
gh copilot config set git.conventional_commits true || log_warn "Failed to enable conventional commits"

# Python preferences
gh copilot config set python.dependency_manager "pipenv" || log_warn "Failed to set pipenv as dependency manager"
gh copilot config set python.use_pipfile true || log_warn "Failed to enable Pipfile usage"
gh copilot config set python.test_framework "pytest" || log_warn "Failed to set pytest as test framework"
gh copilot config set python.formatter "black" || log_warn "Failed to set black as formatter"
gh copilot config set python.import_sorter "isort" || log_warn "Failed to set isort for import sorting"

# Project structure preferences
gh copilot config set project.python.structure "src-layout" || log_warn "Failed to set src-layout structure"
gh copilot config set project.python.source_directory "src" || log_warn "Failed to set source directory"
gh copilot config set project.python.tests_directory "tests" || log_warn "Failed to set tests directory"

# Enable tools
gh copilot config set tools.enabled true || log_warn "Failed to enable tools"
gh copilot config set tools.code_execution true || log_warn "Failed to enable code execution"
gh copilot config set tools.file_operations true || log_warn "Failed to enable file operations"

log_info "Global configuration applied"

# Create complete config file
CONFIG_FILE="$CONFIG_DIR/config.yml"
echo "Creating comprehensive configuration file..."

cat > "$CONFIG_FILE" << EOF
# GitHub Copilot CLI Global Configuration
# Generated by setup script

# Model and performance settings
default_model: gpt-4
tools:
  enabled: true
  web_browsing: true
  code_execution: true
  file_operations: true

# Global instructions
instructions: $INSTRUCTIONS_FILE
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
EOF

log_info "Configuration file created: $CONFIG_FILE"

# GPG setup check
echo "Checking GPG setup for commit signing..."
if gpg --list-secret-keys --keyid-format=long &> /dev/null; then
    log_info "GPG keys found"
    
    # Check if git is configured for signing
    if git config --global user.signingkey &> /dev/null; then
        log_info "Git is configured for commit signing"
    else
        log_warn "Git is not configured for commit signing"
        echo "To enable GPG signing, run:"
        echo "  git config --global user.signingkey YOUR_KEY_ID"
        echo "  git config --global commit.gpgsign true"
    fi
else
    log_warn "No GPG keys found"
    echo "To set up GPG signing:"
    echo "  1. Generate a GPG key: gpg --full-generate-key"
    echo "  2. List keys: gpg --list-secret-keys --keyid-format=long" 
    echo "  3. Configure git: git config --global user.signingkey KEY_ID"
    echo "  4. Enable signing: git config --global commit.gpgsign true"
    echo "  5. Add key to GitHub: gpg --armor --export KEY_ID"
fi

# Test configuration
echo "Testing configuration..."

# Test basic functionality
if gh copilot ask "test configuration" --help &> /dev/null; then
    log_info "GitHub Copilot CLI is responding"
else
    log_error "GitHub Copilot CLI test failed"
fi

# Display current configuration
echo ""
echo "Current configuration summary:"
echo "=============================="
gh copilot config list 2>/dev/null || echo "Unable to display configuration (this may be normal)"

echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "Your GitHub Copilot CLI is now configured with:"
echo "• Global instructions for development practices"
echo "• Git commit signing with -sS flags"
echo "• Python development with pipenv and src-layout"
echo "• Conventional commit format"
echo "• Development tools and best practices"
echo ""
echo "Next steps:"
echo "1. Verify GPG setup if needed (see warnings above)"
echo "2. Test with: gh copilot ask 'How should I commit my changes?'"
echo "3. Create a Python project: gh copilot ask 'Create a new Python project structure'"
echo ""
echo "Configuration files created:"
echo "• $INSTRUCTIONS_FILE"
echo "• $CONFIG_FILE"
echo ""
echo "To customize further, edit these files or run:"
echo "  gh copilot config set <setting> <value>"
echo ""
echo "For more information, see the documentation at:"
echo "  https://github.com/your-username/gh-copilot-cli"