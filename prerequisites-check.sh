#!/bin/bash
# Prerequisites Check Script for GitHub Copilot CLI
# 
# ⚠️ UPDATE NOTICE: This script has been updated for the new standalone
# GitHub Copilot CLI (npm package @github/copilot), not the deprecated
# gh copilot extension.

echo "🔍 Checking GitHub Copilot CLI Prerequisites (New Standalone CLI)"
echo "=================================================================="
echo ""
echo "ℹ️  This checks requirements for the NEW standalone CLI:"
echo "   Installation: npm install -g @github/copilot"
echo "   Usage: copilot (not gh copilot)"
echo ""

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
        # Simple version comparison (works for major.minor)
        if [ "$(printf '%s\n' "$2" "$current_version" | sort -V | head -n1)" = "$2" ]; then
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
echo ""

# Check Node.js (now REQUIRED to be 22+)
if check_command "node" true; then
    NODE_VERSION=$(node --version | sed 's/v//')
    if [ "$(printf '%s\n' "22.0" "$NODE_VERSION" | sort -V | head -n1)" = "22.0" ]; then
        echo -e "${GREEN}✓${NC} Node.js version $NODE_VERSION meets requirements (22+)"
    else
        echo -e "${RED}✗${NC} Node.js version $NODE_VERSION is below REQUIRED minimum (22.0)"
        echo "  The new standalone CLI REQUIRES Node.js 22+"
        echo "  Please upgrade to Node.js 22 using NVM:"
        echo "  nvm install 22 && nvm use 22 && nvm alias default 22"
    fi
else
    echo -e "${RED}✗${NC} Node.js is required but not installed"
    echo "  Install using NVM:"
    echo "  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
    echo "  source ~/.bashrc && nvm install 22"
fi

echo ""

# Check npm (required, should be 10+)
if check_command "npm" true; then
    if check_version "npm" "10.0"; then
        echo -e "${GREEN}✓${NC} npm meets requirements"  
    else
        echo -e "${YELLOW}⚠${NC} npm version is old, consider updating: npm install -g npm@latest"
    fi
else
    echo -e "${RED}✗${NC} npm should be installed with Node.js"
fi

echo ""

# Check for Windows PowerShell requirement
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
    echo "Windows system detected - checking PowerShell..."
    if command -v pwsh &> /dev/null; then
        PWSH_VERSION=$(pwsh --version | grep -oE '[0-9]+\.[0-9]+' | head -n1)
        if [ "$(printf '%s\n' "6.0" "$PWSH_VERSION" | sort -V | head -n1)" = "6.0" ]; then
            echo -e "${GREEN}✓${NC} PowerShell $PWSH_VERSION meets requirements (6+)"
        else
            echo -e "${RED}✗${NC} PowerShell $PWSH_VERSION is below minimum (6.0)"
            echo "  Install PowerShell 7+ from: https://github.com/PowerShell/PowerShell"
        fi
    else
        echo -e "${RED}✗${NC} PowerShell 6+ is required on Windows"
        echo "  Install from: https://github.com/PowerShell/PowerShell"
    fi
    echo ""
fi

# GitHub CLI is NO LONGER REQUIRED
echo -e "${GREEN}ℹ${NC} GitHub CLI is no longer required for the standalone Copilot CLI"
if command -v gh &> /dev/null; then
    echo -e "${GREEN}✓${NC} GitHub CLI found ($(gh --version | head -n1)) - can be used alongside but not required"
else
    echo -e "${GREEN}ℹ${NC} GitHub CLI not found - this is fine, it's not needed for the new CLI"
fi

echo ""

# Git is still useful but not strictly required
if check_command "git" true; then
    check_version "git" "2.30"
else
    echo -e "${YELLOW}⚠${NC} Git not found - recommended for development but not required for Copilot CLI"
fi

echo ""

# Check GPG (optional but recommended)
if check_command "gpg"; then
    echo -e "${GREEN}✓${NC} GPG is available for commit signing"
else
    echo -e "${YELLOW}⚠${NC} GPG not found - commit signing will not work"
    echo "  Install GPG:"
    echo "  macOS: brew install gnupg"
    echo "  Ubuntu: sudo apt install gnupg"
fi

echo ""
echo "🔧 Additional Checks"
echo "===================="

# Check if old extension is still installed  
if command -v gh &> /dev/null && gh extension list 2>/dev/null | grep -q "github/gh-copilot"; then
    echo -e "${YELLOW}⚠${NC} Old GitHub Copilot CLI extension is still installed"
    echo "  Consider removing: gh extension remove github/gh-copilot"
    echo "  The new CLI is completely separate"
fi

# Check for new CLI installation
if command -v copilot &> /dev/null; then
    echo -e "${GREEN}✓${NC} New GitHub Copilot CLI is installed"
    echo "  Version: $(copilot --version 2>/dev/null || echo 'Unable to determine')"
else
    echo -e "${YELLOW}ℹ${NC} New GitHub Copilot CLI is not installed yet"
    echo "  Install with: npm install -g @github/copilot"
fi

# Check environment variables
if [ "$GH_TOKEN" ] || [ "$GITHUB_TOKEN" ]; then
    echo -e "${GREEN}✓${NC} Authentication token environment variable is set"
else
    echo -e "${YELLOW}ℹ${NC} No authentication token set in environment"
    echo "  You can set: export GH_TOKEN=\"your-pat-here\""
    echo "  Or use OAuth via /login command in copilot"
fi

echo ""
echo "📋 Summary"
echo "=========="

# Count issues for new CLI requirements
issues=0

# Node.js 22+ is now REQUIRED
if ! command -v node &> /dev/null; then
    issues=$((issues + 1))
elif [ "$(printf '%s\n' "22.0" "$(node --version | sed 's/v//')" | sort -V | head -n1)" != "22.0" ]; then
    issues=$((issues + 1))
fi

# npm 10+ is required
if ! command -v npm &> /dev/null; then
    issues=$((issues + 1))
elif [ "$(printf '%s\n' "10.0" "$(npm --version | head -n1 | grep -oE '[0-9]+\.[0-9]+' | head -n1)" | sort -V | head -n1)" != "10.0" ]; then
    issues=$((issues + 1))
fi

# Windows PowerShell check
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
    if ! command -v pwsh &> /dev/null; then
        issues=$((issues + 1))
    elif [ "$(printf '%s\n' "6.0" "$(pwsh --version | grep -oE '[0-9]+\.[0-9]+' | head -n1)" | sort -V | head -n1)" != "6.0" ]; then
        issues=$((issues + 1))
    fi
fi

if [ $issues -eq 0 ]; then
    echo -e "${GREEN}🎉 All prerequisites are met for the new CLI!${NC}"
    echo "You can now install the standalone GitHub Copilot CLI:"
    echo "  npm install -g @github/copilot"
    echo "  copilot"
    echo ""
    echo "Authentication options:"
    echo "  1. OAuth: Use /login command in copilot"
    echo "  2. PAT: export GH_TOKEN=\"your-pat-with-copilot-requests-permission\""
else
    echo -e "${RED}❌ $issues critical issue(s) found${NC}"
    echo "Please address the issues above before proceeding."
    echo ""
    echo "Most common fix (Node.js 22 requirement):"
    echo "  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
    echo "  source ~/.bashrc"
    echo "  nvm install 22 && nvm use 22 && nvm alias default 22"
    echo "  npm install -g @github/copilot"
fi