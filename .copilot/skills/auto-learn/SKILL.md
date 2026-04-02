---
name: auto-learn
description: "Instant learning trigger. When Ahmed says 'learn from this' or 'remember this' or shows an example, immediately extract the pattern and store it permanently."
---

# Auto-Learn

## Trigger
- "learn from this"
- "remember this"
- "this is how I want it"
- "take a look at this" (when showing reference material)
- "like this one" (pointing to an example)

## Protocol

### If Ahmed shows a FILE:
1. Identify the type (PPT, code, doc, email, design)
2. Extract the patterns:
   - For PPT: layout rules, colors, spacing, fonts, visual density
   - For code: architecture patterns, naming conventions, error handling style
   - For docs: structure, tone, section ordering, level of detail
   - For email: greeting style, structure, length, sign-off
3. Save as a reference in `~/.copilot/examples/<type>/`
4. Update the relevant agent's .agent.md with the learned pattern
5. Confirm: "Learned: [1-line description of what was extracted]"

### If Ahmed gives a RULE:
1. Parse the intent (even from typos/informal language)
2. Determine where it belongs:
   - Quality rule → copilot-instructions.md > Quality Standards
   - Communication rule → copilot-instructions.md > Communication Style
   - Project rule → project's .github/copilot-instructions.md
   - Don't-do rule → lessons-learned.md
3. Append the rule
4. Confirm: "Stored: [rule in clean English]"

### If Ahmed shows a REJECTION:
1. Identify what was wrong
2. Add to lessons-learned.md with context
3. Update relevant agent/skill to prevent recurrence
4. Confirm: "Won't happen again: [1-line description]"

## Key Rule
Learning is PERMANENT. Once Ahmed teaches something, it stays forever across all future sessions. That's the whole point — he should never have to teach the same thing twice.
