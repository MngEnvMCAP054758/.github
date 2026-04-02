---
name: training-pipeline
description: "Process PPT training data: extract content, render slides, analyze layouts, store in knowledge database."
---

# PPT Training Pipeline

## Trigger
"train on ppts", "start training", "process the training data", "add these to the knowledge base"

## Pipeline
1. List PPTs in training folder (typically `knowledge_extract/` or a specified path)
2. For each PPT:
   a. Extract text content from all slides
   b. Extract slide layouts, colors, fonts, image positions
   c. Render each slide to PNG (for visual analysis)
   d. Analyze layout patterns: spacing, visual density, color harmony
   e. Extract facts/data that can be verified against Microsoft docs
   f. Store extracted knowledge in knowledge.db
3. Track progress: `Processing X/N PPTs (Y slides total)`
4. Report summary: new entries added, total DB size, any extraction failures

## Progress Reporting
Update every 10 PPTs or 30 minutes:
```
📊 Training: 42/266 PPTs (16%)
📝 Slides processed: 1,247
💾 Knowledge entries: 3,891
⏱️ Speed: 5 PPTs/hour
⏳ ETA: ~45 hours remaining
```

## Error Handling
- Corrupted PPT: skip, log filename, continue
- Empty slides: skip silently
- Duplicate content: merge, don't duplicate entries
