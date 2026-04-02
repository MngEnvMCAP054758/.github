---
name: knowledge-watcher
description: "Auto-detect new PPTs in training folder, extract knowledge, update database."
---

# Knowledge Pipeline Watcher

## Trigger
"check for new training data", "update knowledge base", or when Ahmed says "I added more PPTs"

## Protocol
1. Scan training folder for files not yet in knowledge.db
2. For each new file:
   a. Extract content (text, layouts, images, metadata)
   b. Store in knowledge.db with source file reference
   c. Log: filename, slide count, entries extracted
3. Report:
   ```
   📚 Knowledge Update
   Found: 12 new PPTs
   Extracted: 347 new entries
   Database: 4,238 total entries
   Topics: Entra ID (89), MFA (45), Teams (23), ...
   ```

## Sources
- Primary: `knowledge_extract/` in PersonalAI project
- Secondary: `C:\Users\v-amera\Downloads\the training\` (Ahmed's training dump)
- Tertiary: any path Ahmed specifies
