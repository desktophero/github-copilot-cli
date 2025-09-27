# Usage Information and Monitoring

## Overview

Understanding your GitHub Copilot CLI usage is crucial for managing costs, optimizing performance, and staying within limits.

## Basic Usage Commands

### Check Current Usage
```bash
# Overall usage summary
gh copilot usage

# Detailed usage breakdown
gh copilot usage --detailed

# Usage for specific time periods
gh copilot usage --today
gh copilot usage --week
gh copilot usage --month
```

### Context Window Information
```bash
# Current model's context window
gh copilot info context

# Context usage in current conversation
gh copilot info context --current

# Token count for specific text
gh copilot count-tokens "Your text here"
gh copilot count-tokens --file ./large-file.py
```

## Understanding Usage Metrics

### Token Usage
```bash
# Tokens used today
gh copilot usage tokens --today

# Token breakdown by model
gh copilot usage tokens --by-model

# Input vs output tokens
gh copilot usage tokens --split
```

**Example Output**:
```
Today's Usage:
┌─────────────┬─────────┬────────────┬─────────────┐
│ Model       │ Queries │ Input      │ Output      │
├─────────────┼─────────┼────────────┼─────────────┤
│ GPT-4       │ 15      │ 12,450     │ 3,200       │
│ GPT-3.5     │ 8       │ 2,100      │ 800         │
└─────────────┴─────────┴────────────┴─────────────┘
```

### Request Limits
```bash
# Current rate limits
gh copilot limits

# Requests remaining
gh copilot limits --remaining

# Reset time for limits
gh copilot limits --reset-time
```

### Cost Estimation
```bash
# Estimated costs for usage
gh copilot cost --today
gh copilot cost --week --detailed

# Cost by model
gh copilot cost --by-model
```

## Context Window Management

### Monitoring Context Usage
```bash
# Check current conversation token count
gh copilot context size

# Warning when approaching limit
gh copilot context check --warn-at 80%

# Detailed context breakdown
gh copilot context analyze
```

### Context Window Sizes by Model
| Model | Context Window | Recommended Usage |
|-------|----------------|-------------------|
| GPT-4 | 8,192 tokens | ~6,000 tokens max |
| GPT-4-32K | 32,768 tokens | ~25,000 tokens max |
| GPT-3.5-Turbo | 4,096 tokens | ~3,000 tokens max |
| GPT-3.5-Turbo-16K | 16,384 tokens | ~12,000 tokens max |

### Managing Context Efficiently
```bash
# Clear context when full
gh copilot clear

# Start fresh conversation
gh copilot chat --new

# Summarize and continue
gh copilot summarize --continue
```

## Advanced Usage Monitoring

### Historical Usage
```bash
# Usage trends over time
gh copilot usage --history --last-30-days

# Export usage data
gh copilot usage --export csv --output usage-report.csv
gh copilot usage --export json --output usage-data.json
```

### Team/Organization Usage
```bash
# Organization-wide usage (if admin)
gh copilot usage --org your-org

# Team usage summary
gh copilot usage --team your-team

# User breakdown
gh copilot usage --by-user
```

### Performance Metrics
```bash
# Response time statistics
gh copilot stats response-time --last-week

# Model performance comparison
gh copilot stats models --compare

# Tool usage statistics
gh copilot stats tools --detailed
```

## Setting Usage Alerts

### Configure Warnings
```bash
# Set daily token limit warning
gh copilot config set alerts.daily_tokens 10000

# Set cost warning threshold
gh copilot config set alerts.daily_cost 5.00

# Context window warning
gh copilot config set alerts.context_usage 0.8
```

### Alert Configuration
Edit `~/.config/gh/copilot/config.yml`:
```yaml
alerts:
  daily_tokens: 10000
  daily_cost: 5.00
  context_usage: 0.8
  rate_limit_threshold: 0.9
  notify:
    email: false
    desktop: true
    terminal: true
```

### Usage Notifications
```bash
# Enable desktop notifications
gh copilot config set notifications.desktop true

# Email alerts (requires setup)
gh copilot config set notifications.email your-email@domain.com

# Slack integration (if configured)
gh copilot config set notifications.slack "#copilot-alerts"
```

## Optimization Strategies

### Token Efficiency
```bash
# Analyze token usage patterns
gh copilot analyze usage --patterns

# Suggestions for optimization
gh copilot suggest optimization
```

**Best Practices**:
1. **Use precise questions** instead of broad ones
2. **Include only relevant context** files
3. **Clear conversation** when changing topics
4. **Use appropriate models** for task complexity
5. **Batch related questions** in one conversation

### Cost Management
```bash
# Set spending limits
gh copilot config set limits.daily_cost 10.00
gh copilot config set limits.monthly_cost 100.00

# Auto-switch to cheaper models when near limit
gh copilot config set auto_optimize.cost true

# Pause usage when limit reached
gh copilot config set limits.auto_pause true
```

### Model Optimization
```bash
# Automatic model selection based on complexity
gh copilot config set auto_optimize.model true

# Model switching based on context size
gh copilot config set auto_optimize.context true

# Performance-based model selection
gh copilot config set auto_optimize.performance true
```

## Usage Reports

### Daily Reports
```bash
# Generate daily summary
gh copilot report daily --date 2024-01-15

# Email daily report
gh copilot report daily --email
```

### Weekly/Monthly Reports
```bash
# Weekly usage summary
gh copilot report weekly

# Monthly detailed report
gh copilot report monthly --detailed --export pdf
```

### Custom Reports
```bash
# Custom date range
gh copilot report --from 2024-01-01 --to 2024-01-31

# Specific metrics
gh copilot report --metrics tokens,cost,response_time

# Compare periods
gh copilot report --compare --last-month --this-month
```

## API and Integration

### Usage API
```bash
# Get usage data via API
gh copilot api usage --json

# Historical data
gh copilot api usage --from "2024-01-01" --to "2024-01-31"

# Real-time monitoring
gh copilot api usage --stream
```

### Webhook Integration
```bash
# Setup usage webhooks
gh copilot webhook create --url "https://your-domain.com/webhook" --events usage

# Configure webhook alerts
gh copilot webhook config --threshold-exceeded --daily-limit
```

## Troubleshooting Usage Issues

### Common Problems

**Unexpected High Usage**:
```bash
gh copilot usage --detailed --break-by conversation
gh copilot audit --large-requests --last-week
```

**Context Window Errors**:
```bash
gh copilot context diagnose
gh copilot context optimize --auto
```

**Rate Limit Issues**:
```bash
gh copilot limits check
gh copilot queue status
```

### Recovery Commands
```bash
# Reset usage counters (if allowed)
gh copilot usage reset --confirm

# Clear all conversations to free up quota
gh copilot clear --all --confirm

# Switch to free tier model temporarily
gh copilot config set model gpt-3.5-turbo --temporary
```