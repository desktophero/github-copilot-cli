# Branch Protection Setup Guide

This guide will help you configure branch protection rules to enforce the PR-based workflow.

## Quick Setup

Run the provided script to automatically configure branch protection:

```bash
./configure-branch-protection.sh
```

This script will:
- ✅ Create a `develop` branch (if it doesn't exist)
- ✅ Configure branch protection rules for `main` branch
- ✅ Optionally protect `develop` branch
- ✅ Enable security features (Dependabot alerts, security updates)
- ✅ Set up required status checks from CI/CD pipeline

## Manual Configuration

If you prefer to configure manually through GitHub's web interface:

### 1. Go to Repository Settings

Navigate to: `https://github.com/YOUR_USERNAME/REPO_NAME/settings/branches`

### 2. Add Branch Protection Rule

Click "Add rule" and configure:

**Branch name pattern:** `main`

**Protection settings:**
- ✅ Require a pull request before merging
  - ✅ Require approvals: 1
  - ✅ Dismiss stale PR approvals when new commits are pushed
  - ✅ Require review from code owners (if you have CODEOWNERS file)
  - ✅ Require approval of the most recent reviewable push

- ✅ Require status checks to pass before merging
  - ✅ Require branches to be up to date before merging
  - **Required status checks:**
    - `spell-check`
    - `security-scan` 
    - `lint-and-format`
    - `docs-check`
    - `build-validation`

- ✅ Require conversation resolution before merging
- ✅ Require linear history
- ✅ Include administrators
- ❌ Allow force pushes
- ❌ Allow deletions

### 3. Enable Security Features

Go to: `https://github.com/YOUR_USERNAME/REPO_NAME/settings/security_analysis`

Enable:
- ✅ Dependabot alerts
- ✅ Dependabot security updates
- ✅ Secret scanning alerts (if available for your account type)

## Workflow After Branch Protection

### Feature Development

```bash
# 1. Start from main branch
git checkout main
git pull origin main

# 2. Create feature branch
git checkout -b feature/your-feature-name

# 3. Make changes and commit
git add .
git commit -sS -m "feat(scope): description of changes"

# 4. Push feature branch
git push origin feature/your-feature-name

# 5. Create PR through GitHub web interface
# - Fill out the PR template
# - Wait for CI checks to pass
# - Request review from team member
# - Address any feedback
# - Merge when approved and checks pass
```

### Bug Fix Workflow

```bash
# 1. Start from main branch
git checkout main
git pull origin main

# 2. Create fix branch
git checkout -b fix/issue-description

# 3. Make changes and commit
git add .
git commit -sS -m "fix(scope): description of fix"

# 4. Push and create PR
git push origin fix/issue-description
# Create PR through GitHub web interface
```

## CI/CD Pipeline Status Checks

The following checks must pass before merging:

### ✅ spell-check
- Validates spelling in documentation files
- Uses cspell with custom dictionary
- Fails on unknown words or typos

### ✅ security-scan  
- Runs Grype vulnerability scanner
- Scans for known vulnerabilities in dependencies
- Uploads results to GitHub Security tab
- Fails on medium+ severity findings

### ✅ lint-and-format
- Validates markdown formatting
- Checks for trailing whitespace
- Validates YAML syntax
- Ensures consistent documentation style

### ✅ docs-check
- Verifies required documentation files exist
- Checks for broken internal links
- Validates documentation completeness

### ✅ build-validation
- Validates shell script syntax
- Checks file permissions
- Ensures executables are properly configured

## Troubleshooting

### CI Checks Failing

**Spell Check Issues:**
```bash
# Run locally to see issues
npm install -g cspell
cspell "**/*.md" --config .cspell.json

# Add words to .cspell.json if needed
```

**Security Scan Issues:**
- Check Security tab for vulnerability details
- Update dependencies to fix known issues
- Consider suppressing false positives if necessary

**Lint Issues:**
```bash
# Run markdown linter locally
npm install -g markdownlint-cli
markdownlint "**/*.md" --config .markdownlint.json
```

### Branch Protection Issues

**Can't push to main:**
- This is expected! Create a feature branch instead
- Use PR workflow for all changes

**Status checks not appearing:**
- Ensure workflows have run at least once
- Check Actions tab for workflow status
- Verify workflow names match protection settings

**Admin bypass:**
- Even admins must follow the workflow
- This ensures consistent code quality
- Use "Include administrators" setting to enforce

## Benefits of This Setup

✅ **Quality Assurance**
- All code reviewed before merging
- Automated testing and validation
- Consistent formatting and style

✅ **Security**  
- Vulnerability scanning on every change
- Secret detection prevents credential leaks
- Dependency monitoring for supply chain security

✅ **Collaboration**
- Clear contribution guidelines
- Standardized PR process
- Documentation requirements enforced

✅ **Maintainability**
- Linear git history
- Conventional commit messages
- Comprehensive changelog tracking

✅ **Automation**
- Reduces manual oversight burden
- Consistent quality checks
- Automated security monitoring

---

This branch protection setup ensures high code quality while maintaining development velocity through automation and clear processes.