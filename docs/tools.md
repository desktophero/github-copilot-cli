# Tools and Extensions Guide

## Overview

GitHub Copilot CLI tools extend the basic chat functionality with enhanced capabilities like web browsing, code execution, and file operations.

## Enabling Tools

### Global Tools Configuration
```bash
# Enable all tools
gh copilot config set tools.enabled true

# Check current tools status
gh copilot config get tools
```

### Individual Tool Control
```bash
# Enable specific tools
gh copilot config set tools.web_browsing true
gh copilot config set tools.code_execution true
gh copilot config set tools.file_operations true

# Disable specific tools
gh copilot config set tools.web_browsing false
```

## Available Tools

### 1. Web Browsing Tool

**Purpose**: Access current web content and documentation

**Enable**:
```bash
gh copilot config set tools.web_browsing true
```

**Usage Examples**:
```bash
# Get current information
gh copilot ask "What are the latest React 18 features?" --web

# Research documentation
gh copilot ask "Show me the latest Python asyncio best practices" --web

# Compare technologies
gh copilot ask "Compare FastAPI vs Flask for 2024" --web
```

**Best Practices**:
- Use for current information that might have changed
- Great for documentation research
- Useful for technology comparisons
- Be specific about what you're looking for

### 2. Code Execution Tool

**Purpose**: Run and test code snippets safely

**Enable**:
```bash
gh copilot config set tools.code_execution true
```

**Usage Examples**:
```bash
# Test a Python snippet
gh copilot ask "Create and test a function to reverse a string" --execute

# Debug code
gh copilot ask "Why isn't this sorting correctly?" --code "my_list.sort(reverse=True)" --execute

# Validate algorithms
gh copilot ask "Test this binary search implementation" --execute --include search.py
```

**Supported Languages**:
- Python
- JavaScript/Node.js
- Shell/Bash
- SQL (with SQLite)

**Safety Features**:
- Sandboxed execution environment
- Time limits on execution
- No network access (by default)
- File system restrictions

### 3. File Operations Tool

**Purpose**: Read, analyze, and modify files in your workspace

**Enable**:
```bash
gh copilot config set tools.file_operations true
```

**Usage Examples**:
```bash
# Analyze code structure
gh copilot ask "Review the architecture of my project" --include-dir src/

# Modify files
gh copilot ask "Add error handling to this function" --modify src/api.py

# Generate new files
gh copilot ask "Create a unit test for this module" --create-file tests/test_api.py
```

**Permissions**:
```bash
# Set file operation permissions
gh copilot config set tools.file_ops.read true
gh copilot config set tools.file_ops.write true
gh copilot config set tools.file_ops.create true
gh copilot config set tools.file_ops.delete false  # Recommended: keep false
```

## Advanced Tool Configuration

### Tool-Specific Settings

**Web Browsing Configuration**:
```bash
# Set search preferences
gh copilot config set tools.web.search_engine "google"
gh copilot config set tools.web.max_results 5

# Enable specific sources
gh copilot config set tools.web.allow_github true
gh copilot config set tools.web.allow_stackoverflow true
```

**Code Execution Limits**:
```bash
# Set execution timeout (seconds)
gh copilot config set tools.execution.timeout 30

# Set memory limit (MB)
gh copilot config set tools.execution.memory_limit 256

# Enable/disable specific languages
gh copilot config set tools.execution.python true
gh copilot config set tools.execution.javascript true
gh copilot config set tools.execution.bash false
```

**File Operations Scope**:
```bash
# Limit to specific directories
gh copilot config set tools.files.allowed_dirs "src/,tests/,docs/"

# Set file size limits (KB)
gh copilot config set tools.files.max_file_size 100

# File type restrictions
gh copilot config set tools.files.allowed_extensions ".py,.js,.md,.json"
```

## Using Tools Effectively

### Combining Tools
```bash
# Research + Execute
gh copilot ask "Find the latest pandas method for handling missing data and show me an example" --web --execute

# File + Execute
gh copilot ask "Fix the bug in this file and test the solution" --include bug.py --execute

# Web + File + Execute
gh copilot ask "Research async patterns, apply to my code, and test" --web --include api.py --execute
```

### Tool Flags and Options

| Flag | Purpose | Example |
|------|---------|---------|
| `--web` | Enable web browsing | `gh copilot ask "Latest Docker best practices" --web` |
| `--execute` | Run code | `gh copilot ask "Test this function" --execute` |
| `--include <file>` | Include file | `gh copilot ask "Review this" --include main.py` |
| `--modify <file>` | Modify file | `gh copilot ask "Add logging" --modify app.py` |
| `--create-file <file>` | Create new file | `gh copilot ask "Make config" --create-file config.yaml` |

## Security and Safety

### Sandboxing
- Code execution runs in isolated containers
- No access to sensitive system files
- Network restrictions apply
- Automatic cleanup after execution

### Permission Model
```bash
# View current permissions
gh copilot config get tools --verbose

# Reset to safe defaults
gh copilot config reset tools --safe-mode

# Audit tool usage
gh copilot audit tools --last-week
```

### Best Practices
1. **Review before execution**: Always understand what code will run
2. **Limit file access**: Only enable write access when needed
3. **Monitor usage**: Check tool usage regularly
4. **Use version control**: Commit before major modifications
5. **Test in development**: Don't run experimental code in production

## Troubleshooting Tools

### Common Issues

**Tool Not Available**:
```bash
gh copilot tools status
gh copilot extension update
```

**Execution Failures**:
```bash
gh copilot logs --tool execution --tail 50
gh copilot config validate tools.execution
```

**Permission Errors**:
```bash
gh copilot config reset tools
gh copilot auth check --tools
```

### Debug Mode
```bash
# Enable verbose tool logging
gh copilot config set debug.tools true

# Run with debug output
gh copilot ask "Debug this" --execute --debug
```

## Tool Development

### Creating Custom Tools
```bash
# Initialize tool template
gh copilot tool init my-custom-tool

# Install custom tool
gh copilot tool install ./my-custom-tool

# List installed tools
gh copilot tool list --custom
```

### Tool API
Custom tools can integrate with:
- File system operations
- External APIs
- Database connections
- Custom execution environments

See [Tool Development Guide](tool-development.md) for details.