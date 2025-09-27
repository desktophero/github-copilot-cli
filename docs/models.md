# Model Configuration Guide

## Available Models

### GPT-4 Models
- **gpt-4**: Latest GPT-4 model, best for complex reasoning
- **gpt-4-turbo**: Faster version with good performance
- **gpt-4-32k**: Extended context window (32,768 tokens)

### GPT-3.5 Models  
- **gpt-3.5-turbo**: Fast and efficient for most tasks
- **gpt-3.5-turbo-16k**: Extended context window (16,384 tokens)

## Setting Your Default Model

### Command Line
```bash
# Set GPT-4 as default
gh copilot config set model gpt-4

# Set GPT-3.5 for faster responses
gh copilot config set model gpt-3.5-turbo

# Use extended context version
gh copilot config set model gpt-4-32k
```

### Environment Variable
```bash
export GH_COPILOT_MODEL="gpt-4"
```

### Configuration File
Edit `~/.config/gh/copilot/config.yml`:
```yaml
default_model: gpt-4
```

## Model Selection Guidelines

### Use GPT-4 for:
- Complex code architecture decisions
- Detailed code reviews
- Advanced debugging
- Learning new technologies
- Writing documentation

### Use GPT-3.5 for:
- Quick code snippets
- Simple explanations
- Basic debugging
- Faster iteration
- Testing ideas

## Context Windows

### Understanding Token Limits
```bash
# Check current model's context window
gh copilot info context

# View token usage for conversation
gh copilot usage --conversation
```

### Model Context Sizes
| Model | Context Window | Best For |
|-------|----------------|----------|
| GPT-4 | 8,192 tokens | Standard tasks |
| GPT-4-32K | 32,768 tokens | Large codebases |
| GPT-3.5-Turbo | 4,096 tokens | Quick tasks |
| GPT-3.5-Turbo-16K | 16,384 tokens | Medium projects |

### Managing Context
```bash
# Clear conversation to free tokens
gh copilot clear

# Start new focused conversation
gh copilot chat --new

# Include specific files in context
gh copilot ask "Explain this function" --include src/main.py
```

## Switching Models Mid-Conversation

### Temporary Switch
```bash
# Use different model for one question
gh copilot ask "Complex algorithm question" --model gpt-4

# Continue with default model
gh copilot ask "Simple follow-up"
```

### Permanent Switch
```bash
# Change default model
gh copilot config set model gpt-3.5-turbo

# All subsequent commands use new model
gh copilot ask "This uses the new model"
```

## Cost Optimization

### Token Usage Monitoring
```bash
# Daily usage
gh copilot usage --today

# Weekly summary
gh copilot usage --week

# Model-specific usage
gh copilot usage --model gpt-4
```

### Best Practices
1. **Start with GPT-3.5** for exploration
2. **Switch to GPT-4** for complex problems
3. **Use extended context models** sparingly
4. **Clear context** when switching topics
5. **Monitor usage** regularly

## Model Testing

### Test Model Performance
```bash
# Test response quality
gh copilot ask "Explain recursion" --model gpt-4
gh copilot ask "Explain recursion" --model gpt-3.5-turbo

# Compare context handling
gh copilot ask "Summarize this large file" --include large-file.py --model gpt-4-32k
```

### Benchmark Commands
```bash
# Time response speed
time gh copilot ask "Quick Python function" --model gpt-3.5-turbo
time gh copilot ask "Quick Python function" --model gpt-4
```

## Configuration Validation

### Check Current Model
```bash
gh copilot config get model
```

### Verify Model Access
```bash
gh copilot model test gpt-4
gh copilot model test gpt-3.5-turbo
```

### Reset to Defaults
```bash
gh copilot config reset model
```