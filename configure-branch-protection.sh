#!/bin/bash

# Branch Protection Configuration Script
# This script helps configure branch protection rules for the repository

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔒 GitHub Branch Protection Setup${NC}"
echo "=========================================="
echo

# Check if gh CLI is available
if ! command -v gh &> /dev/null; then
    echo -e "${RED}❌ GitHub CLI (gh) is not installed or not in PATH${NC}"
    echo "Please install GitHub CLI first: https://cli.github.com/"
    exit 1
fi

# Check if user is authenticated
if ! gh auth status &> /dev/null; then
    echo -e "${YELLOW}⚠️  Not authenticated with GitHub CLI${NC}"
    echo "Please run: gh auth login"
    exit 1
fi

# Get repository information
REPO_INFO=$(gh repo view --json owner,name)
OWNER=$(echo "$REPO_INFO" | jq -r '.owner.login')
REPO=$(echo "$REPO_INFO" | jq -r '.name')

echo -e "${BLUE}Repository:${NC} $OWNER/$REPO"
echo

# Function to configure branch protection
configure_branch_protection() {
    local branch=$1
    echo -e "${YELLOW}Configuring protection for branch: $branch${NC}"
    
    # Enable branch protection with comprehensive rules
    gh api \
        --method PUT \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "/repos/$OWNER/$REPO/branches/$branch/protection" \
        -f required_status_checks='{"strict":true,"contexts":["spell-check","security-scan","lint-and-format","docs-check","build-validation"]}' \
        -f enforce_admins=true \
        -f required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true,"require_code_owner_reviews":false,"require_last_push_approval":true}' \
        -f restrictions='null' \
        -f required_linear_history=true \
        -f allow_force_pushes=false \
        -f allow_deletions=false \
        -f block_creations=false \
        -f required_conversation_resolution=true \
        -f lock_branch=false \
        -f allow_fork_syncing=true
    
    echo -e "${GREEN}✅ Branch protection configured for $branch${NC}"
}

# Create develop branch if it doesn't exist
echo -e "${BLUE}Checking for develop branch...${NC}"
if ! gh api "/repos/$OWNER/$REPO/branches/develop" &> /dev/null; then
    echo -e "${YELLOW}⚠️  develop branch not found. Creating it...${NC}"
    
    # Get the SHA of main branch
    MAIN_SHA=$(gh api "/repos/$OWNER/$REPO/git/refs/heads/main" --jq '.object.sha')
    
    # Create develop branch from main
    gh api \
        --method POST \
        -H "Accept: application/vnd.github+json" \
        "/repos/$OWNER/$REPO/git/refs" \
        -f ref='refs/heads/develop' \
        -f sha="$MAIN_SHA"
    
    echo -e "${GREEN}✅ develop branch created${NC}"
else
    echo -e "${GREEN}✅ develop branch already exists${NC}"
fi

echo

# Configure protection for main branch
echo -e "${BLUE}Setting up branch protection rules...${NC}"
configure_branch_protection "main"

echo

# Configure protection for develop branch (if desired)
read -p "Do you want to protect the 'develop' branch as well? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    configure_branch_protection "develop"
fi

echo

# Set default branch (ensure it's main)
echo -e "${BLUE}Setting default branch to main...${NC}"
gh api \
    --method PATCH \
    -H "Accept: application/vnd.github+json" \
    "/repos/$OWNER/$REPO" \
    -f default_branch='main'

echo -e "${GREEN}✅ Default branch set to main${NC}"

echo

# Enable vulnerability alerts
echo -e "${BLUE}Enabling security features...${NC}"

# Enable Dependabot alerts
gh api \
    --method PUT \
    -H "Accept: application/vnd.github+json" \
    "/repos/$OWNER/$REPO/vulnerability-alerts"

# Enable Dependabot security updates
gh api \
    --method PUT \
    -H "Accept: application/vnd.github+json" \
    "/repos/$OWNER/$REPO/automated-security-fixes"

echo -e "${GREEN}✅ Security features enabled${NC}"

echo

# Summary
echo -e "${GREEN}🎉 Branch protection setup complete!${NC}"
echo
echo -e "${BLUE}Configuration Summary:${NC}"
echo "• Main branch is protected and set as default"
echo "• Pull requests required for all changes to main"
echo "• Status checks required (CI/CD pipeline)"
echo "• At least 1 review required for PRs"
echo "• Stale reviews dismissed when new commits pushed"
echo "• Linear history enforced (no merge commits)"
echo "• Force pushes and deletions blocked"
echo "• Conversation resolution required before merge"
echo "• Dependabot alerts and security updates enabled"

echo
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Create a new feature branch: git checkout -b feature/your-feature"
echo "2. Make your changes and commit them"
echo "3. Push to GitHub: git push origin feature/your-feature"
echo "4. Create a pull request through GitHub web interface"
echo "5. Wait for CI checks and get review approval"
echo "6. Merge via GitHub (squash and merge recommended)"

echo
echo -e "${BLUE}Workflow Commands:${NC}"
cat << 'EOF'
# Feature development workflow:
git checkout main
git pull origin main
git checkout -b feature/your-feature-name
# ... make changes ...
git add .
git commit -sS -m "feat(scope): description of changes"
git push origin feature/your-feature-name
# Create PR via GitHub web interface

# Bug fix workflow:
git checkout main
git pull origin main
git checkout -b fix/issue-description
# ... make changes ...
git add .
git commit -sS -m "fix(scope): description of fix"
git push origin fix/issue-description
# Create PR via GitHub web interface
EOF

echo
echo -e "${GREEN}Branch protection is now active! 🔒${NC}"