# Contributing to GitHub Copilot CLI Tips

Thank you for your interest in contributing to this project! This guide will help you get started.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)

## Code of Conduct

This project adheres to a code of conduct. By participating, you are expected to uphold this code.

## Getting Started

### Prerequisites

- Git
- Node.js 18+ (for tooling)
- GitHub CLI

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/gh-copilot-cli.git
   cd gh-copilot-cli
   ```

3. Add the upstream remote:
   ```bash
   git remote add upstream https://github.com/desktophero/github-copilot-cli.git
   ```

## Development Workflow

### Branch Strategy

We use a feature branch workflow:

1. **main** - Production-ready code
2. **develop** - Integration branch for features (optional)
3. **feature/*** - Feature branches
4. **fix/*** - Bug fix branches
5. **docs/*** - Documentation-only changes

### Creating a Feature Branch

```bash
# Ensure you're on main and up to date
git checkout main
git pull upstream main

# Create and checkout your feature branch
git checkout -b feature/your-feature-name

# Or for bug fixes
git checkout -b fix/issue-description
```

### Branch Naming Convention

- `feature/add-user-authentication`
- `fix/resolve-config-parsing-error`
- `docs/update-installation-guide`
- `chore/update-dependencies`

## Pull Request Process

### Before Creating a PR

1. **Sync with upstream:**
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Run quality checks:**
   ```bash
   # Spell check (if you have cspell installed)
   npm install -g cspell
   cspell "**/*.md"
   
   # Markdown lint (if you have markdownlint installed)
   npm install -g markdownlint-cli
   markdownlint "**/*.md"
   
   # Check shell scripts
   find . -name "*.sh" -exec bash -n {} \;
   ```

3. **Test your changes:**
   - Manually test any scripts or configurations
   - Verify documentation accuracy
   - Ensure examples work as expected

### Creating the Pull Request

1. **Push your branch:**
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create PR on GitHub:**
   - Use the provided PR template
   - Write a clear, descriptive title following [conventional commit format](https://www.conventionalcommits.org/)
   - Fill out all sections of the PR template

3. **PR Title Examples:**
   - `feat(auth): add OAuth authentication guide`
   - `fix(docs): correct installation command syntax`
   - `docs(readme): add troubleshooting section`
   - `chore(ci): update security scanning workflow`

### PR Requirements

✅ **Required for all PRs:**
- [ ] Clear description of changes
- [ ] Conventional commit title format
- [ ] All CI checks passing
- [ ] No conflicts with main branch
- [ ] Self-review completed

✅ **Required for documentation changes:**
- [ ] Spell check passes
- [ ] Markdown lint passes
- [ ] Links are valid
- [ ] Examples are tested

✅ **Required for workflow/config changes:**
- [ ] YAML syntax is valid
- [ ] Changes tested in fork
- [ ] Security implications considered

## Coding Standards

### Documentation

- **Markdown:** Follow standard markdown formatting
- **Line Length:** Prefer 80-120 characters per line
- **Headers:** Use consistent header hierarchy
- **Links:** Use descriptive link text
- **Code Blocks:** Always specify language for syntax highlighting

### Shell Scripts

- Use `#!/bin/bash` shebang
- Add error handling with `set -e`
- Use meaningful variable names
- Add comments for complex logic
- Make scripts executable (`chmod +x`)

### YAML/JSON

- Use 2-space indentation
- Quote strings when necessary
- Validate syntax before committing
- Use meaningful names for workflows/jobs

### Commit Messages

Follow [conventional commit format](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat` - New features
- `fix` - Bug fixes
- `docs` - Documentation changes
- `style` - Formatting, no code change
- `refactor` - Code restructuring
- `test` - Adding tests
- `chore` - Maintenance tasks
- `ci` - CI/CD changes

**Examples:**
```bash
feat(auth): add OAuth configuration guide
fix(setup): resolve Node.js version check issue
docs(readme): clarify installation prerequisites
chore(deps): update workflow action versions
```

## Testing

### Documentation Testing

1. **Spell Check:**
   ```bash
   cspell "**/*.md" --config .cspell.json
   ```

2. **Markdown Lint:**
   ```bash
   markdownlint "**/*.md" --config .markdownlint.json
   ```

3. **Link Validation:**
   ```bash
   # Manual verification of internal links
   grep -r '\[.*\](\..*\.md)' . --include="*.md"
   ```

### Script Testing

1. **Syntax Check:**
   ```bash
   find . -name "*.sh" -exec bash -n {} \;
   ```

2. **Manual Testing:**
   - Test setup scripts in clean environment
   - Verify prerequisites checks work
   - Confirm examples produce expected results

### Workflow Testing

1. **YAML Validation:**
   ```bash
   python -c "import yaml; yaml.safe_load(open('.github/workflows/ci.yml'))"
   ```

2. **Fork Testing:**
   - Test workflow changes in your fork first
   - Verify security scans work correctly
   - Ensure all jobs complete successfully

## Documentation

### What Needs Documentation

- New features or tools
- Configuration changes
- Installation procedures
- Troubleshooting steps
- Examples and use cases

### Documentation Structure

```
docs/
├── usage.md          # How to use the tools
├── models.md         # Model configuration
├── tools.md          # Available tools
├── global-config.md  # Configuration guide
├── git-integration.md # Git workflow
├── python-setup.md   # Python-specific setup
└── prerequisites.md  # System requirements
```

### Writing Guidelines

- Start with clear overview
- Use numbered steps for procedures
- Include code examples
- Add troubleshooting sections
- Keep examples up to date
- Use consistent terminology

## Review Process

### What Reviewers Look For

1. **Accuracy** - Information is correct and current
2. **Completeness** - All necessary information included
3. **Clarity** - Easy to understand and follow
4. **Consistency** - Matches existing style and format
5. **Testing** - Examples work as documented

### Addressing Review Feedback

1. **Respond promptly** to review comments
2. **Ask questions** if feedback is unclear
3. **Make requested changes** in separate commits
4. **Update PR description** if scope changes
5. **Request re-review** after making changes

## Getting Help

### Content Filtering and AI Model Issues

When working on documentation, you may encounter content filtering from AI models:

**Common Error:**
```
× Model call failed: {"message":"Output blocked by content filtering policy","code":"invalid_request_body"}
```

**This is normal behavior** when discussing security, vulnerabilities, or certain technical topics.

**Solutions for Contributors:**
- Use professional, technical language
- Focus on educational and defensive security practices
- Frame security discussions as "best practices" or "hardening"
- Break large technical discussions into smaller parts
- Provide clear context about legitimate educational purposes

**When documenting security features:**
- ✅ "Configure security scanning to detect vulnerabilities"
- ✅ "Implement input validation to prevent injection attacks"
- ✅ "Review code for security best practices"
- ❌ Avoid language that could be misinterpreted as malicious

### Where to Ask Questions

- **GitHub Issues** - For bugs or feature requests
- **GitHub Discussions** - For general questions
- **PR Comments** - For specific implementation questions

### Resources

- [GitHub Flow Guide](https://guides.github.com/introduction/flow/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

---

Thank you for contributing! Every contribution, no matter how small, helps make this project better for everyone. 🚀