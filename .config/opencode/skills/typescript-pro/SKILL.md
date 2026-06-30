---
name: typescript-pro
description: Use when building TypeScript 5.x applications needing strict typing, modern module resolution, async patterns, or Deno/Bun runtime targets. Invoke for generics, mapped types, Zod schemas, tsconfig tuning, and vitest tests.
license: MIT
compatibility: opencode
metadata:
  author: https://github.com/Jeffallan
  version: "1.1.0"
  domain: language
  triggers: TypeScript, tsconfig, generics, Zod, vitest, Node, Deno, Bun, strict mode
  role: specialist
  scope: implementation
  output-format: code
  related-skills: python-pro, fastapi-expert
---

# TypeScript Pro

Strict-mode TypeScript 5.x with runtime validation, modern tooling, and precise types.

## When to Use

- Writing strict-typed TypeScript (frontend or backend)
- Designing generics, mapped types, conditional types
- Validating runtime data with Zod
- Tuning `tsconfig` for Node/Deno/Bun
- Setting up vitest with type-aware tests

## Core Workflow

1. **tsconfig** — `strict: true`, `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes`
2. **Design types** — model domain with unions; avoid `any`
3. **Runtime validation** — Zod schemas at boundaries
4. **Implement** — async with proper `Promise` typing, no floating promises
5. **Test** — vitest, type-aware where useful
6. **Validate** — `tsc --noEmit`, `eslint`, tests green

## Constraints

### MUST DO

- Enable `strict: true` and `noUncheckedIndexedAccess`
- Validate external data at boundaries with Zod
- Use `unknown` over `any` for untrusted input
- Handle `Promise` rejections; no floating promises
- Prefer discriminated unions over optional boolean flags

### MUST NOT DO

- Use `any` in public APIs
- Use `as` casts to silence the compiler; fix the type
- Leave `strict` off to make code compile
- Ignore `noUncheckedIndexedAccess` warnings
- Mix CommonJS and ESM without a module plan

## Code Examples

### Discriminated union

```typescript
type Result<T> =
  | { ok: true; value: T }
  | { ok: false; error: string };

function divide(a: number, b: number): Result<number> {
  if (b === 0) return { ok: false, error: "divide by zero" };
  return { ok: true, value: a / b };
}
```

### Zod boundary validation

```typescript
import { z } from "zod";

const UserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(1).max(100),
});

type User = z.infer<typeof UserSchema>;

function parseUser(input: unknown): User {
  return UserSchema.parse(input);
}
```

### tsconfig (strict)

```jsonc
{
  "compilerOptions": {
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,
    "module": "nodenext",
    "moduleResolution": "nodenext",
    "noEmit": true
  }
}
```

## Knowledge Reference

TypeScript 5.x, tsconfig, Zod, vitest, Node, Deno, Bun, ESLint, mapped types, conditional types, discriminated unions