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
```text

### Context Window Information

```bash
# Current model's context window
gh copilot info context

# Context usage in current conversation
gh copilot info context --current

# Token count for specific text
gh copilot count-tokens "Your text here"
gh copilot count-tokens --file ./large-file.py
```text

## Understanding Usage Metrics

### Token Usage

```bash
# Tokens used today
gh copilot usage tokens --today

# Token breakdown by model
gh copilot usage tokens --by-model

# Input vs output tokens
gh copilot usage tokens --split
```text

**Example Output**:

```text
Today's Usage:
┌─────────────┬─────────┬────────────┬─────────────┐
│ Model       │ Queries │ Input      │ Output      │
├─────────────┼─────────┼────────────┼─────────────┤
│ GPT-4       │ 15      │ 12,450     │ 3,200       │
│ GPT-3.5     │ 8       │ 2,100      │ 800         │
└─────────────┴─────────┴────────────┴─────────────┘
```text

### Request Limits

```bash
# Current rate limits
gh copilot limits

# Requests remaining
gh copilot limits --remaining

# Reset time for limits
gh copilot limits --reset-time
```text

### Cost Estimation

```bash
# Estimated costs for usage
gh copilot cost --today
gh copilot cost --week --detailed

# Cost by model
gh copilot cost --by-model
```text

## Context Window Management

### Monitoring Context Usage

```bash
# Check current conversation token count
gh copilot context size

# Warning when approaching limit
gh copilot context check --warn-at 80%

# Detailed context breakdown
gh copilot context analyze
```text

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
```text

## Advanced Usage Monitoring

### Historical Usage

```bash
# Usage trends over time
gh copilot usage --history --last-30-days

# Export usage data
gh copilot usage --export csv --output usage-report.csv
gh copilot usage --export json --output usage-data.json
```text

### Team/Organization Usage

```bash
# Organization-wide usage (if admin)
gh copilot usage --org your-org

# Team usage summary
gh copilot usage --team your-team

# User breakdown
gh copilot usage --by-user
```text

### Performance Metrics

```bash
# Response time statistics
gh copilot stats response-time --last-week

# Model performance comparison
gh copilot stats models --compare

# Tool usage statistics
gh copilot stats tools --detailed
```text

## Setting Usage Alerts

### Configure Warnings

```bash
# Set daily token limit warning
gh copilot config set alerts.daily_tokens 10000

# Set cost warning threshold
gh copilot config set alerts.daily_cost 5.00

# Context window warning
gh copilot config set alerts.context_usage 0.8
```text

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
```text

### Usage Notifications

```bash
# Enable desktop notifications
gh copilot config set notifications.desktop true

# Email alerts (requires setup)
gh copilot config set notifications.email your-email@domain.com

# Slack integration (if configured)
gh copilot config set notifications.slack "#copilot-alerts"
```text

## Optimization Strategies

### Token Efficiency

```bash
# Analyze token usage patterns
gh copilot analyze usage --patterns

# Suggestions for optimization
gh copilot suggest optimization
```text

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
```text

### Model Optimization

```bash
# Automatic model selection based on complexity
gh copilot config set auto_optimize.model true

# Model switching based on context size
gh copilot config set auto_optimize.context true

# Performance-based model selection
gh copilot config set auto_optimize.performance true
```text

## Usage Reports

### Daily Reports

```bash
# Generate daily summary
gh copilot report daily --date 2024-01-15

# Email daily report
gh copilot report daily --email
```text

### Weekly/Monthly Reports

```bash
# Weekly usage summary
gh copilot report weekly

# Monthly detailed report
gh copilot report monthly --detailed --export pdf
```text

### Custom Reports

```bash
# Custom date range
gh copilot report --from 2024-01-01 --to 2024-01-31

# Specific metrics
gh copilot report --metrics tokens,cost,response_time

# Compare periods
gh copilot report --compare --last-month --this-month
```text

## API and Integration

### Usage API

```bash
# Get usage data via API
gh copilot api usage --json

# Historical data
gh copilot api usage --from "2024-01-01" --to "2024-01-31"

# Real-time monitoring
gh copilot api usage --stream
```text

### Webhook Integration

```bash
# Setup usage webhooks
gh copilot webhook create --url "https://your-domain.com/webhook" --events usage

# Configure webhook alerts
gh copilot webhook config --threshold-exceeded --daily-limit
```text

## Troubleshooting Usage Issues

### Model Call Failures and Content Filtering

#### Understanding Content Filtering Errors

**Error Message:**

```text
× Model call failed: {"message":"Output blocked by content filtering policy","code":"invalid_request_body"}
```text

This is **normal behavior**, not a system error. AI models have built-in safety filters to prevent generating harmful content.

#### Why Content Filtering Occurs

**Common Triggers:**

- Security-related discussions (even legitimate ones)
- Code containing certain patterns or keywords
- Large code blocks that trigger false positives
- Requests that could be misinterpreted as malicious
- Content involving sensitive topics

**Examples that might trigger filters:**

```bash
# These might get blocked:
gh copilot ask "How to bypass authentication in this code"
gh copilot ask "Show me vulnerabilities in this system"
gh copilot ask "Help me hack this script"

# These are more likely to work:
gh copilot ask "Help me fix authentication issues in this code"
gh copilot ask "Review this code for security best practices"
gh copilot ask "Debug this script's logic"
```text

#### Strategies to Avoid Content Filtering

**1. Use Professional Language:**

```bash
# Instead of: "exploit", "hack", "break"
# Use: "debug", "analyze", "optimize", "review"

# Instead of: "How to crack this?"
# Use: "How to troubleshoot this issue?"
```text

**2. Be Specific and Technical:**

```bash
# Vague (may trigger filters):
gh copilot ask "Make this code malicious"

# Specific (less likely to trigger):
gh copilot ask "Add error handling to this function"
```text

**3. Break Down Large Requests:**

```bash
# Instead of sending entire files:
gh copilot ask "Review this entire codebase" --include-dir src/

# Send smaller sections:
gh copilot ask "Review this authentication module" --include src/auth.py
```text

**4. Context Matters:**

```bash
# Provide clear context:
gh copilot ask "I'm debugging a security issue in my application. \
Help me identify why authentication is failing" --include auth.py
```text

#### Recovery Strategies

**When You Get Blocked:**

1. **Rephrase the Question:**

   ```bash
   # Original (blocked): "How to exploit this vulnerability?"
   # Rephrased: "How to fix this security vulnerability?"
   ```

1. **Use Different Terminology:**

   ```bash
   # Blocked terms: exploit, hack, crack, bypass
   # Better terms: debug, analyze, fix, resolve, optimize
   ```

2. **Add Professional Context:**

   ```bash
   gh copilot ask "As a developer working on security improvements, help me understand this code pattern" --include code.py
   ```

3. **Break Into Smaller Questions:**

   ```bash
   # Instead of one large security review:
   gh copilot ask "Review the input validation in this function"
   gh copilot ask "Check error handling in this module"
   gh copilot ask "Suggest improvements for this authentication flow"
   ```

4. **Try Different Models:**

   ```bash
   # Some models may have different filtering sensitivity
   gh copilot ask "Your question" --model gpt-3.5-turbo
   ```

#### Best Practices for Avoiding Blocks

**✅ Do:**

- Use professional, technical language
- Provide clear context about your legitimate use case
- Be specific about what you're trying to accomplish
- Frame requests as learning or improvement opportunities
- Use industry-standard terminology

**❌ Avoid:**

- Ambiguous language that could be misinterpreted
- Terms associated with malicious activities
- Requesting harmful or unethical content
- Large, unfocused requests without context
- Repetitive attempts with the same blocked phrasing

#### When Content Filtering is Helpful

Content filtering protects against:

- Generating actually harmful code
- Providing information that could be misused
- Creating content that violates terms of service
- Accidentally generating inappropriate material

**Remember:** Content filtering is a feature, not a bug. It helps ensure responsible AI usage.

### Common Problems

**Unexpected High Usage**:

```bash
gh copilot usage --detailed --break-by conversation
gh copilot audit --large-requests --last-week
```text

**Context Window Errors**:

```bash
gh copilot context diagnose
gh copilot context optimize --auto
```text

**Rate Limit Issues**:

```bash
gh copilot limits check
gh copilot queue status
```text

### Recovery Commands

```bash
# Reset usage counters (if allowed)
gh copilot usage reset --confirm

# Clear all conversations to free up quota
gh copilot clear --all --confirm

# Switch to free tier model temporarily
gh copilot config set model gpt-3.5-turbo --temporary
```text
