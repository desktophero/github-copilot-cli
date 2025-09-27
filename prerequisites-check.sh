#!/bin/bash
# Prerequisites Check Script for GitHub Copilot CLI
# This script verifies that all minimum requirements are met

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

# Check Node.js
if check_command "node" true; then
    NODE_VERSION=$(node --version | sed 's/v//')
    if [ "$(printf '%s\n' "18.0" "$NODE_VERSION" | sort -V | head -n1)" = "18.0" ]; then
        if [ "$(printf '%s\n' "22.0" "$NODE_VERSION" | sort -V | head -n1)" = "22.0" ]; then
            echo -e "${GREEN}✓${NC} Node.js version $NODE_VERSION is excellent (22+)"
        else
            echo -e "${YELLOW}⚠${NC} Node.js version $NODE_VERSION meets minimum (18+) but 22+ recommended"
        fi
    else
        echo -e "${RED}✗${NC} Node.js version $NODE_VERSION is below minimum requirement (18.0)"
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

# Check npm
if check_command "npm" true; then
    check_version "npm" "9.0"
else
    echo "  npm should be installed with Node.js"
fi

echo ""

# Check GitHub CLI
if check_command "gh" true; then
    check_version "gh" "2.40"
else
    echo "  Install GitHub CLI from: https://cli.github.com/"
    echo "  macOS: brew install gh"
    echo "  Ubuntu: Follow instructions at https://cli.github.com/"
fi

echo ""

# Check Git
if check_command "git" true; then
    check_version "git" "2.30"
else
    echo "  Git is required. Install from: https://git-scm.com/"
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

# Count issues
issues=0

if ! command -v node &> /dev/null; then
    issues=$((issues + 1))
elif [ "$(printf '%s\n' "18.0" "$(node --version | sed 's/v//')" | sort -V | head -n1)" != "18.0" ]; then
    issues=$((issues + 1))
fi

if ! command -v gh &> /dev/null; then
    issues=$((issues + 1))
elif [ "$(printf '%s\n' "2.40" "$(gh --version | head -n1 | grep -oE '[0-9]+\.[0-9]+' | head -n1)" | sort -V | head -n1)" != "2.40" ]; then
    issues=$((issues + 1))
fi

if ! command -v git &> /dev/null; then
    issues=$((issues + 1))
fi

if [ $issues -eq 0 ]; then
    echo -e "${GREEN}🎉 All prerequisites are met!${NC}"
    echo "You can now install GitHub Copilot CLI:"
    echo "  gh extension install github/gh-copilot"
    echo ""
    echo "Or run our automated setup:"
    echo "  curl -sSL https://raw.githubusercontent.com/your-username/gh-copilot-cli/main/setup.sh | bash"
else
    echo -e "${RED}❌ $issues critical issue(s) found${NC}"
    echo "Please address the issues above before proceeding."
    echo ""
    echo "Quick fix for most common issue (Node.js):"
    echo "  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
    echo "  source ~/.bashrc"
    echo "  nvm install 22 && nvm use 22 && nvm alias default 22"
fi