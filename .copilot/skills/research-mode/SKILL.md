---
name: research-mode
description: "Rapid deep-dive research on any topic. When Ahmed says 'take a look at this', 'what do you know about X', or 'research X', this skill activates. Outputs in Ahmed's preferred format: facts first, then how it applies to his projects."
---

# Research Mode

## Trigger
- "take a look at this"
- "what do you know about X"
- "research X"
- "how does X work"
- "check if X can do Y"

## Protocol

### 1. Rapid Scan (< 30 seconds)
- Search web for current information
- Check Microsoft Learn/docs for official guidance
- Check if the topic connects to any of Ahmed's existing projects

### 2. Output Format
```
📖 [Topic]
━━━━━━━━━━
What it is: [1-2 sentences]
How it works: [3-5 bullet points, technical]
Why it matters for you: [connection to Ahmed's projects]
Action: [what Ahmed could do with this — be specific]
```

### 3. Context Matching
Always connect research to Ahmed's ecosystem:
- If it's a Microsoft service → how does it connect to PersonalAI or SPO Assessment?
- If it's a Python library → could it improve the FastAPI backend?
- If it's an Azure feature → cost impact? Which subscription?
- If it's a trading concept → how to integrate into trading module?

### 4. Deep Dive on Request
If Ahmed says "go deeper" or "tell me more":
- Full technical breakdown
- Code examples in Python/PowerShell (Ahmed's languages)
- Architecture diagram (ASCII art)
- Pros/cons analysis
- Implementation plan with time estimate

## Key Rule
Research is ACTIONABLE, not academic. Every research output ends with "Here's what you could do with this" — specific to Ahmed's projects, not generic advice.
