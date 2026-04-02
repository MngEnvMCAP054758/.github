# Code Pattern Reference

## PersonalAI FastAPI Patterns
Based on 43+ endpoints in the PersonalAI codebase.

### Endpoint Pattern
```python
@app.post("/api/{module}/{action}")
async def endpoint_name(request: Request):
    try:
        data = await request.json()
        # Validate required fields
        if "field" not in data:
            return JSONResponse(status_code=400, content={"error": "field required"})
        # Process
        result = await process_function(data)
        return JSONResponse(content={"status": "success", "data": result})
    except Exception as e:
        logger.error(f"Error in endpoint_name: {e}")
        return JSONResponse(status_code=500, content={"error": str(e)})
```

### Error Handling Pattern
- Always catch exceptions at endpoint level
- Log with context: what endpoint, what input, what error
- Return structured JSON errors, never bare strings
- Don't crash the app — return 500 with useful error message

### Azure OpenAI Call Pattern
```python
response = await client.chat.completions.create(
    model="gpt-4o",
    messages=messages,
    temperature=0.7,
    max_tokens=4096
)
```

### Deployment Pattern
1. Local change → test locally → deploy.ps1 → health check → endpoint test
2. Never deploy without testing at least /health and one business endpoint
3. Check response times: /health < 200ms, /api/chat < 2000ms
