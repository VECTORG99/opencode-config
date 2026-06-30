---
name: security-auditor
description: Use when auditing code for vulnerabilities across OWASP, CWE, and common security anti-patterns. Invoke for threat modeling, input validation review, auth/session analysis, crypto misuse, and SSRF/XSS/SQLi detection.
license: MIT
compatibility: opencode
metadata:
  author: https://github.com/Jeffallan
  version: "1.1.0"
  domain: security
  triggers: security audit, vulnerability, OWASP, CWE, threat model, pentest review, SAST, secure code
  role: auditor
  scope: review
  output-format: report
  related-skills: secure-code-guardian, python-pro, fastapi-expert
---

# Security Auditor

Static review and threat modeling for code that will face real adversaries.

## When to Use

- Auditing a module before release
- Reviewing an auth, payment, or data-access change
- Building a threat model for a new service
- Triaging SAST output (Semgrep, CodeQL, Bandit)

## Core Workflow

1. **Identify trust boundaries** — network, process, user roles
2. **Map data flows** — input sources, sinks, privileged operations
3. **Check OWASP categories** — injection, broken auth, SSRF, XSS, crypto
4. **Review secrets handling** — env vars, logs, error messages
5. **Threat model** — STRIDE per component
6. **Report** — severity (Critical/High/Medium/Low), exploitability, fix

## Constraints

### MUST DO

- Map trust boundaries before reviewing code line-by-line
- Check every input-derived string that reaches a sink
- Verify authz on every privileged endpoint, not just authn
- Report severity with exploitability and a concrete fix
- Prefer deterministic findings over speculative ones

### MUST NOT DO

- Report style issues as security findings
- Suggest security-through-obscurity as a fix
- Ignore compensating controls already in place
- Recommend custom crypto; use stdlib/vetted libs
- Skip logging/auditing implications of a fix

## Output Template

```
## Security Audit Report

### Critical
- [CWE-89] SQL injection in `search.py:42` via unsanitized `q` param.
  Exploit: `?q=' OR 1=1--`. Fix: use parameterized query.

### High
- [CWE-89] ...

### Medium
- ...

### Low / Informational
- ...

### Threat Model (STRIDE)
- Spoofing: ...
- Tampering: ...
- Repudiation: ...
- Info Disclosure: ...
- DoS: ...
- Elevation: ...
```

## Knowledge Reference

OWASP Top 10, CWE, STRIDE, Semgrep, CodeQL, Bandit, pip-audit, npm audit, trivy, Burp, ZAP