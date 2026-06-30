---
name: fastapi-expert
description: Use when building FastAPI applications with async endpoints, Pydantic v2 models, dependency injection, background tasks, or JWT auth. Invoke for OpenAPI docs, middleware, testing with httpx, and production deployment patterns.
license: MIT
compatibility: opencode
metadata:
  author: https://github.com/Jeffallan
  version: "1.1.0"
  domain: framework
  triggers: FastAPI, ASGI, uvicorn, Pydantic, dependency injection, OpenAPI, async web
  role: specialist
  scope: implementation
  output-format: code
  related-skills: python-pro, security-auditor, sql-pro
---

# FastAPI Expert

Production FastAPI specialist: async endpoints, Pydantic v2, dependency injection, testing, deployment.

## When to Use

- Building async REST APIs with FastAPI
- Designing Pydantic v2 request/response models
- Implementing dependency injection for auth, DB, config
- Testing with httpx and pytest-asyncio
- Deploying with uvicorn/gunicorn workers

## Core Workflow

1. **Design schemas** — Pydantic v2 models with strict validation
2. **Implement endpoints** — async routers with proper status codes and responses
3. **Wire dependencies** — auth, DB sessions, rate limiting via `Depends`
4. **Test** — httpx AsyncClient + pytest-asyncio for endpoint coverage
5. **Document** — OpenAPI auto-generated; enrich with descriptions and examples
6. **Validate** — `mypy --strict`, `ruff`, tests green

## Constraints

### MUST DO

- Use `async def` for endpoints doing I/O
- Pydantic v2 models with `model_config = ConfigDict(extra="forbid")`
- Dependency injection for shared resources (DB, auth, settings)
- Type hints on all handlers and dependencies
- Background tasks for fire-and-forget work
- Proper HTTP status codes (201 for create, 204 for delete)
- Security schemes via `HTTPBearer`, `OAuth2PasswordBearer`

### MUST NOT DO

- Use `def` where `async def` is needed (blocks the event loop)
- Mutate Pydantic models in place; re-validate instead
- Hardcode DB URLs or secrets; use `pydantic-settings`
- Catch `Exception` broadly in endpoints; use specific handlers
- Return raw dicts; return typed models

## Code Examples

### Async endpoint with DI

```python
from fastapi import APIRouter, Depends, HTTPException, status
from .models import User, UserCreate
from .deps import get_user_service, UserService

router = APIRouter(prefix="/users", tags=["users"])

@router.post("", response_model=User, status_code=status.HTTP_201_CREATED)
async def create_user(
    payload: UserCreate,
    service: UserService = Depends(get_user_service),
) -> User:
    return await service.create(payload)
```

### Pydantic v2 model

```python
from pydantic import BaseModel, ConfigDict, Field

class UserCreate(BaseModel):
    model_config = ConfigDict(extra="forbid")
    email: str = Field(..., pattern=r"^[^@]+@[^@]+\.[^@]+$")
    name: str = Field(..., min_length=1, max_length=100)
```

### Test with httpx

```python
import pytest
from httpx import ASGITransport, AsyncClient
from myapp.main import app

@pytest.mark.asyncio
async def test_create_user() -> None:
    async with AsyncClient(transport=ASGITransport(app=app), base_url="http://test") as client:
        r = await client.post("/users", json={"email": "a@b.com", "name": "Ana"})
        assert r.status_code == 201
        assert r.json()["email"] == "a@b.com"
```

## Knowledge Reference

FastAPI, Pydantic v2, uvicorn, gunicorn, httpx, pytest-asyncio, pydantic-settings, OpenAPI, Starlette, anyio