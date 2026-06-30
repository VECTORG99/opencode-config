---
name: playwright-expert
description: Use when writing Playwright tests (Python or TS), browser automation scripts, E2E suites, or scraping with JS rendering. Invoke for locators, fixtures, network mocking, traces, and CI integration.
license: MIT
compatibility: opencode
metadata:
  author: https://github.com/Jeffallan
  version: "1.1.0"
  domain: testing
  triggers: Playwright, E2E testing, browser automation, screenshots, traces, web scraping JS
  role: specialist
  scope: implementation
  output-format: code
  related-skills: python-pro, typescript-pro
---

# Playwright Expert

Reliable browser automation and E2E tests with Playwright.

## When to Use

- Writing E2E tests for a web app
- Automating a browser flow (login, upload, scrape JS-rendered page)
- Debugging flaky tests with traces and screenshots
- Wiring Playwright into CI

## Core Workflow

1. **Locators** — prefer `getByRole`, `getByLabel`; avoid brittle CSS
2. **Fixtures** — reuse authenticated browser contexts
3. **Assertions** — web-first (`expect(locator).to_be_visible()`)
4. **Network** — mock APIs with `route()` for deterministic tests
5. **Debug** — `--trace on`, screenshots, video
6. **CI** — headless, sharded, retries on failure

## Constraints

### MUST DO

- Use web-first assertions; let Playwright wait automatically
- Use `getByRole`/`getByLabel` over CSS selectors
- Isolate state per test via fresh contexts
- Mock external APIs for deterministic CI
- Capture traces for failing tests

### MUST NOT DO

- Use `time.sleep()`; use `expect` auto-waiting
- Share state between tests without a fixture
- Hardcode base URLs; use config
- Ignore mobile/viewport coverage if the product supports it
- Leave `headless=False` in CI

## Code Examples

### Python async test

```python
import pytest
from playwright.async_api import async_playwright

@pytest.mark.asyncio
async def test_login() -> None:
    async with async_playwright() as p:
        browser = await p.chromium.launch()
        page = await browser.new_page()
        await page.goto("https://app.test/login")
        await page.get_by_label("Email").fill("a@b.com")
        await page.get_by_label("Password").fill("secret")
        await page.get_by_role("button", name="Sign in").click()
        await page.get_by_text("Welcome").wait_for()
        await browser.close()
```

### Network mock

```python
await page.route("**/api/user", lambda r: r.fulfill(
    status=200, json={"id": 1, "name": "Ana"}
))
```

## Knowledge Reference

Playwright (Python/TS), pytest-playwright, locators, fixtures, `route()`, traces, HAR, sharding, retries, GitHub Actions matrix