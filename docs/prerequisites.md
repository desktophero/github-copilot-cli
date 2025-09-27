# System Requirements and Prerequisites

> **⚠️ MAJOR UPDATE**: This guide has been updated for the new standalone GitHub Copilot CLI,
> not the deprecated `gh copilot` extension.

## Overview

The new standalone GitHub Copilot CLI has updated system requirements. This guide ensures you
have the necessary components for the new `npm install -g @github/copilot` installation method.

**⚠️ Breaking Changes:**

- GitHub CLI is **no longer required**
- Node.js 22+ is now **required** (not just recommended)  
- Installation via npm package, not GitHub CLI extension
- Different authentication method

## System Requirements

### New Requirements (Standalone CLI)

| Component | Minimum Version | Notes |
|-----------|----------------|-------|
| **Node.js** | **22.x (REQUIRED)** | Breaking change: 22+ now required |
| **npm** | **10.x** | Comes with Node.js 22 |
| **PowerShell (Windows)** | **6+** | PowerShell Core, not Windows PowerShell |

### No Longer Required

- ❌ **GitHub CLI** - Not needed for standalone CLI
- ❌ **Git** - Useful but not required for CLI installation

### Operating System Support

- **macOS**: 11.0+ (Big Sur or later)
- **Linux**: Ubuntu 20.04+, RHEL 8+, or equivalent
- **Windows**: Windows 10+ with WSL2 recommended

## Node.js Installation

### Check Current Node.js Version

```bash
# Check if Node.js is installed and version
node --version

# Check npm version
npm --version
```text

### Install/Update Node.js using NVM (Recommended)

#### Install NVM

**macOS/Linux:**

```bash
# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Reload your shell
source ~/.bashrc
# or
source ~/.zshrc

# Verify NVM installation
nvm --version
```text

**Windows (using NVM for Windows):**

```powershell
# Download and install from: https://github.com/coreybutler/nvm-windows/releases
# Or use winget
winget install CoreyButler.NVMforWindows
```text

#### Install Node.js 22

```bash
# List available Node.js versions
nvm list-remote | grep "v22"

# Install Node.js 22 (latest LTS recommended)
nvm install 22

# Use Node.js 22 as default
nvm use 22
nvm alias default 22

# Verify installation
node --version  # Should show v22.x.x
npm --version   # Should show 10.x.x or higher
```text

### Alternative Installation Methods

#### Using Package Managers

**macOS (Homebrew):**

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Node.js
brew install node@22

# Link the version (if needed)
brew link --overwrite node@22
```text

**Ubuntu/Debian:**

```bash
# Install Node.js 22 from NodeSource repository
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify installation
node --version
npm --version
```text

**RHEL/CentOS/Fedora:**

```bash
# Install Node.js 22 from NodeSource repository
curl -fsSL https://rpm.nodesource.com/setup_22.x | sudo bash -
sudo dnf install -y nodejs npm

# Verify installation
node --version
npm --version
```text

## GitHub CLI Installation

### Check Current GitHub CLI Version

```bash
# Check if GitHub CLI is installed
gh --version

# Should show version 2.40.0 or higher
```text

### Install GitHub CLI

#### macOS

```bash
# Using Homebrew (recommended)
brew install gh

# Using MacPorts
sudo port install gh
```text

#### Linux

```bash
# Ubuntu/Debian
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
  sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
https://cli.github.com/packages stable main" | \
sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# RHEL/CentOS/Fedora
sudo dnf install 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh
```text

#### Windows

```powershell
# Using winget
winget install --id GitHub.cli

# Using Chocolatey
choco install gh

# Using Scoop
scoop install gh
```text

## Additional Prerequisites

### Git Configuration

```bash
# Verify Git installation
git --version

# Configure Git if not already done
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```text

### GPG Setup (for commit signing)

```bash
# Check if GPG is installed
gpg --version

# Install GPG if needed
# macOS
brew install gnupg

# Ubuntu/Debian
sudo apt install gnupg

# RHEL/CentOS/Fedora
sudo dnf install gnupg2
```text

## Verification Script

Create a verification script to check all prerequisites:

```bash
#!/bin/bash
# prerequisites-check.sh

echo "🔍 Checking GitHub Copilot CLI Prerequisites"
echo "============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_command() {
    if command -v "$1" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $1 is installed"
        if [ "$2" ]; then
            version=$($1 --version 2>/dev/null | head -n1)
            echo "  Version: $version"
        fi
        return 0
    else
        echo -e "${RED}✗${NC} $1 is not installed"
        return 1
    fi
}

check_version() {
    current_version=$($1 --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+' | head -n1)
    if [ "$current_version" ]; then
        if [[ $(echo "$current_version >= $2" | bc -l 2>/dev/null) == "1" ]] || [[ "$current_version" > "$2" ]]; then
            echo -e "${GREEN}✓${NC} $1 version $current_version meets minimum requirement ($2)"
            return 0
        else
            echo -e "${YELLOW}⚠${NC} $1 version $current_version is below minimum requirement ($2)"
            return 1
        fi
    else
        echo -e "${RED}✗${NC} Cannot determine $1 version"
        return 1
    fi
}

echo "Checking core dependencies..."

# Check Node.js
if check_command "node" true; then
    check_version "node" "18.0"
else
    echo "  Install Node.js 22 using: nvm install 22"
fi

# Check npm
if check_command "npm" true; then
    check_version "npm" "9.0"
fi

# Check GitHub CLI
if check_command "gh" true; then
    check_version "gh" "2.40"
else
    echo "  Install GitHub CLI from: https://cli.github.com/"
fi

# Check Git
if check_command "git" true; then
    check_version "git" "2.30"
fi

# Check GPG (optional but recommended)
if check_command "gpg"; then
    echo "  GPG is available for commit signing"
else
    echo -e "${YELLOW}⚠${NC} GPG not found - commit signing will not work"
fi

echo ""
echo "🔧 Additional Checks"
echo "===================="

# Check GitHub authentication
if gh auth status &> /dev/null; then
    echo -e "${GREEN}✓${NC} GitHub CLI is authenticated"
else
    echo -e "${YELLOW}⚠${NC} GitHub CLI is not authenticated"
    echo "  Run: gh auth login"
fi

# Check for GitHub Copilot extension
if gh extension list 2>/dev/null | grep -q "github/gh-copilot"; then
    echo -e "${GREEN}✓${NC} GitHub Copilot CLI extension is installed"
else
    echo -e "${YELLOW}⚠${NC} GitHub Copilot CLI extension is not installed"
    echo "  Run: gh extension install github/gh-copilot"
fi

echo ""
echo "📋 Summary"
echo "=========="
echo "If all checks pass with ✓, you're ready to install GitHub Copilot CLI!"
echo "If you see ⚠ or ✗, please address those issues first."
```text

Save this as `prerequisites-check.sh`, make it executable, and run:

```bash
chmod +x prerequisites-check.sh
./prerequisites-check.sh
```text

## Troubleshooting Common Issues

### Node.js Version Issues

**Problem**: "GitHub Copilot CLI requires Node.js 18 or higher"

**Solution**:

```bash
# Using NVM
nvm install 22
nvm use 22
nvm alias default 22

# Verify
node --version  # Should show v22.x.x
```text

**Problem**: "Cannot find module" errors during installation

**Solution**:

```bash
# Clear npm cache
npm cache clean --force

# Update npm
npm install -g npm@latest

# Try installation again
gh extension install github/gh-copilot
```text

### GitHub CLI Issues

**Problem**: "gh: command not found"

**Solution**:

```bash
# Install GitHub CLI first
# macOS
brew install gh

# Linux (Ubuntu/Debian)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
  sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) \
signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
https://cli.github.com/packages stable main" | \
sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh
```text

**Problem**: "HTTP 401: Bad credentials" when installing extension

#### This is the most common error when running setup.sh

**Error message you might see:**

```text
⚠ GitHub Copilot CLI extension not found. Installing...
could not check for binary extension: HTTP 401: Bad credentials (https://api.github.com/repos/github/gh-copilot/releases/latest)
Try authenticating with:  gh auth login
```text

**Solution**:

```bash
# Authenticate with GitHub FIRST
gh auth login

# Follow the prompts to authenticate, then re-run setup
./setup.sh
```text

**Why this happens:**

- Installing GitHub CLI extensions requires authenticated access to GitHub's API
- The setup script tries to install the Copilot extension before checking authentication
- GitHub returns a 401 error when trying to access extension metadata without authentication

### Permission Issues

**Problem**: "Permission denied" errors during npm operations

**Solution**:

```bash
# Configure npm to use a different directory for global packages
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

# Add to your shell profile (.bashrc, .zshrc, etc.)
export PATH=~/.npm-global/bin:$PATH

# Reload your shell
source ~/.bashrc  # or ~/.zshrc
```text

## Quick Setup Verification

After addressing prerequisites, verify everything works:

```bash
# 1. Check versions
node --version    # Should be 18+ (22+ recommended)
npm --version     # Should be 9+
gh --version      # Should be 2.40+

# 2. Authenticate GitHub CLI
gh auth login

# 3. Install Copilot CLI extension
gh extension install github/gh-copilot

# 4. Test installation
gh copilot --help

# 5. Run our automated setup (optional)
curl -sSL https://raw.githubusercontent.com/your-username/gh-copilot-cli/main/setup.sh | bash
```text

If all these commands succeed, you're ready to use GitHub Copilot CLI with the configurations in this repository!
