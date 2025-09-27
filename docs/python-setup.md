# Python Project Setup with Pipenv

## Overview

This guide shows how to configure GitHub Copilot CLI to consistently work with Python
projects using pipenv, proper project structure, and development best practices.

## Global Python Configuration

### Set Python Preferences

```bash
# Configure pipenv as default dependency manager
gh copilot config set python.dependency_manager "pipenv"
gh copilot config set python.use_pipfile true
gh copilot config set python.virtual_env_tool "pipenv"

# Set testing and formatting tools
gh copilot config set python.test_framework "pytest"
gh copilot config set python.formatter "black"
gh copilot config set python.linter "flake8"
gh copilot config set python.import_sorter "isort"
gh copilot config set python.type_checker "mypy"

# Project structure preferences
gh copilot config set project.python.structure "src-layout"
gh copilot config set project.python.source_directory "src"
gh copilot config set project.python.tests_directory "tests"
```text

### Global Python Instructions

Add to `~/.config/gh/copilot/instructions.md`:

```markdown
## Python Project Standards

### Dependency Management
- Always use pipenv for dependency management
- Create Pipfile and maintain Pipfile.lock
- Use `pipenv install` for dependencies
- Use `pipenv install --dev` for development dependencies
- Use `pipenv shell` to activate virtual environment

### Project Structure
Use src-layout structure:
```text

my_project/
├── Pipfile                 # Dependencies
├── Pipfile.lock           # Locked dependencies
├── README.md              # Project documentation
├── setup.py               # Package configuration
├── pyproject.toml         # Modern Python config
├── src/
│   └── my_project/        # Main package
│       ├── __init__.py
│       ├── main.py
│       └── modules/
├── tests/                 # Test files
│   ├── __init__.py
│   └── test_main.py
├── docs/                  # Documentation
└── .env.example           # Environment variables template

```text

### Code Quality
- Use black for code formatting (line length: 88)
- Use isort for import sorting
- Use flake8 for linting
- Use mypy for type checking
- Add type hints to all functions
- Write docstrings for all public functions
- Use pytest for testing

### Development Workflow
- Create virtual environment: `pipenv install`
- Install dev dependencies: `pipenv install --dev pytest black flake8 isort mypy`
- Run tests: `pipenv run pytest`
- Format code: `pipenv run black src/ tests/`
- Sort imports: `pipenv run isort src/ tests/`
- Type checking: `pipenv run mypy src/`
```text

## Automated Project Creation

### Project Template Commands

When asked to create a Python project, Copilot will now follow your structure:

```bash
# Create new Python project
gh copilot ask "Create a new Python web API project called 'user-service'"

# Expected structure creation:
gh copilot generate --language python --task "FastAPI project with pipenv, \
src layout, and proper structure" --create-dir user-service
```text

### Development Environment Setup

```bash
# Setup development environment for existing project
gh copilot ask "Setup development environment for this Python project" --include Pipfile

# Add development dependencies
gh copilot ask "Add common development dependencies to Pipfile" --modify Pipfile
```text

## Pipenv-Specific Commands

### Common Pipenv Operations

Global instructions will ensure these patterns are always suggested:

```bash
# Install dependencies
pipenv install

# Install development dependencies
pipenv install --dev

# Add new dependency
pipenv install requests

# Add development dependency
pipenv install --dev pytest

# Activate shell
pipenv shell

# Run commands in virtual environment
pipenv run python src/main.py
pipenv run pytest
pipenv run black src/
```text

### Pipfile Configuration

Standard Pipfile template that Copilot will generate:

```toml
[[source]]
url = "https://pypi.org/simple"
verify_ssl = true
name = "pypi"

[packages]
# Production dependencies

[dev-packages]
pytest = "*"
black = "*"
flake8 = "*"
isort = "*"
mypy = "*"

[requires]
python_version = "3.11"

[scripts]
test = "pytest"
format = "black src/ tests/"
lint = "flake8 src/ tests/"
type-check = "mypy src/"
sort-imports = "isort src/ tests/"
dev-setup = "pre-commit install"
```text

## Integration Examples

### Project Creation Workflow

```bash
# Ask Copilot to create a complete project
gh copilot ask "Create a Python FastAPI project with the following requirements:
- User authentication
- Database integration
- Proper testing structure
- Development tooling setup"

# This will now automatically:
# 1. Create src-layout structure
# 2. Generate Pipfile with appropriate dependencies
# 3. Setup testing with pytest
# 4. Include development tools (black, flake8, etc.)
# 5. Create proper __init__.py files
# 6. Setup basic configuration files
```text

### Development Workflow Integration

```bash
# Setup new feature development
gh copilot ask "I want to add a new feature to my FastAPI project. \
Setup the development environment and create the basic structure for user authentication endpoints"

# Add dependencies
gh copilot ask "Add authentication dependencies to my Pipfile" --modify Pipfile

# Create tests
gh copilot ask "Create pytest tests for the authentication module" --create-file tests/test_auth.py --include src/my_project/auth.py
```text

## Code Generation Examples

### With Global Configuration Applied

All code generation will now follow your preferences:

```bash
# Generate API endpoint
gh copilot generate --language python --task "user registration endpoint with validation"
# Will automatically include:
# - Type hints
# - Proper imports
# - Error handling
# - Docstrings
# - Pipenv-compatible structure
```text

### Example Generated Code

With global configuration, Copilot will generate code like:

```python
# src/my_project/auth.py
from typing import Optional
from fastapi import HTTPException
from pydantic import BaseModel, EmailStr


class UserCreate(BaseModel):
    """User creation model with validation."""
    email: EmailStr
    password: str
    full_name: Optional[str] = None


async def create_user(user_data: UserCreate) -> dict:
    """
    Create a new user account.
    
    Args:
        user_data: User creation data
        
    Returns:
        dict: Created user information
        
    Raises:
        HTTPException: If user creation fails
    """
    # Implementation here
    pass
```text

## Configuration Templates

### Complete Python Project Config

Add to `~/.config/gh/copilot/config.yml`:

```yaml
python:
  dependency_manager: "pipenv"
  use_pipfile: true
  virtual_env_tool: "pipenv"
  test_framework: "pytest"
  formatter: "black"
  linter: "flake8"
  import_sorter: "isort"
  type_checker: "mypy"
  
  # Development dependencies to always suggest
  default_dev_dependencies:
    - "pytest"
    - "black"
    - "flake8" 
    - "isort"
    - "mypy"
    - "pre-commit"
  
  # Code style preferences
  line_length: 88
  use_type_hints: true
  require_docstrings: true
  
project:
  python:
    structure: "src-layout"
    source_directory: "src"
    tests_directory: "tests"
    docs_directory: "docs"
    
    # Standard files to create
    standard_files:
      - "README.md"
      - "Pipfile"
      - ".gitignore"
      - "setup.py"
      - "pyproject.toml"
      - ".env.example"
    
    # Standard directories
    standard_directories:
      - "src"
      - "tests" 
      - "docs"
```text

## Testing the Configuration

### Verification Commands

```bash
# Test Python project creation
gh copilot ask "Create a simple Python CLI tool project structure"

# Test dependency management
gh copilot ask "Add database and HTTP client dependencies to my Python project" --include Pipfile

# Test development setup
gh copilot ask "Setup development environment with testing and linting for my Python project"

# Verify configuration
gh copilot config get python
gh copilot config get project.python
```text

### Expected Behaviors

With proper configuration, Copilot should:

1. __Always suggest pipenv__ for dependency management
2. __Create src-layout structure__ for new projects
3. __Generate Pipfile__ instead of requirements.txt
4. __Include type hints__ in all generated code
5. __Add proper docstrings__ to functions
6. __Suggest pytest__ for testing
7. __Use black formatting__ standards
8. __Follow PEP 8__ guidelines

## Troubleshooting

### Common Issues

```bash
# Configuration not applying
gh copilot config validate python
gh copilot config get python.dependency_manager

# Pipenv not being used
gh copilot config set python.use_pipfile true
gh copilot config set python.dependency_manager "pipenv"

# Structure preferences ignored
gh copilot config get project.python.structure
gh copilot config set project.python.structure "src-layout"
```text

### Reset Python Configuration

```bash
# Reset Python-specific settings
gh copilot config reset python

# Reconfigure with your preferences
gh copilot config set python.dependency_manager "pipenv"
gh copilot config set python.use_pipfile true
```text
