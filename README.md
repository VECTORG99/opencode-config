# OpenCode Config

Configuración personal de OpenCode para desarrollo agentico profesional.

## Qué incluye

- A-Dev (`@adev`) y metodología SDD
- MCPs: Context7, GitHub, Playwright, Semgrep/Postgres desactivados por defecto
- Plugins: ponytail, forge, memory, safety, browser, skills, review helper, log sanitizer
- Agentes: `eyes`, `VEC`
- Skills: A-Dev, TDD, Caveman, Skill Creator
- Overrides por proyecto: Yap, DataGestor, krono, homedir

## Inventario importante

### Plugins globales

| Plugin | Estado | Uso |
|---|---:|---|
| ponytail | activo | Modo senior minimalista: YAGNI, stdlib first, cambios quirúrgicos |
| opencode-rules | activo | Reglas globales/proyecto |
| opencode-supermemory | activo | Memoria persistente explícita |
| opencode-antigravity-auth | activo | Auth auxiliar |
| opencode-agent-browser | activo | Automatización browser |
| opencode-skill-creator | activo | Crear/evaluar skills |
| opencode-nanobanana | activo | Generación/edición de imágenes |
| envsitter-guard | activo | Protección de `.env` y secretos |
| cc-safety-net | activo | Bloqueo de comandos destructivos |
| opencode-forge | activo | Planes, loops, compaction, worktree logging |
| opencode-mem | activo manual | Memoria local; auto-capture desactivado |
| opencode-notify | activo | Notificaciones |
| opencode-review-helper | activo | Orden de review e impacto |
| opencode-log-sanitizer | activo | Sanitización de logs |
| oh-my-opencode-slim | activo | Orquestación ligera de agentes |

### MCP servers

| MCP | Estado global | Uso |
|---|---:|---|
| context7 | enabled | Documentación actual de librerías |
| github | enabled | Repos, PRs, issues, code search; requiere `GITHUB_TOKEN` |
| playwright | enabled | Browser automation y E2E |
| semgrep | disabled | SAST/security scanning bajo demanda |
| postgres | disabled | DB read-only bajo demanda por proyecto |

### Skills

| Skill | Uso |
|---|---|
| `@adev` | A-Dev, SDD, baseline, evidencia, handoff |
| `tdd` | Red-green-refactor |
| `opencode-skill-creator` | Crear/evaluar/optimizar skills |
| `caveman*` | Respuestas comprimidas, review, commit, stats |
| `cavecrew` | Delegación comprimida a subagentes |

### Agentes globales

| Agente | Uso |
|---|---|
| `eyes` | OCR/screenshot/visión de pantalla |
| `VEC` | Guardia contra commits/pushes/borrados peligrosos |

### Metodologías configuradas

- **A-Dev**: baseline, iteraciones cortas, evidencia, decisión/handoff.
- **SDD**: Specify → Clarify → Plan → Implement → Validate → Evidence.
- **Multi-agent**: single agent → supervisor → orchestrator-workers → evaluator-optimizer → swarm solo si hace falta.
- **Security-driven development**: gates por riesgo, SAST, secrets, revisión humana en alto riesgo.
- **3-tier context**: hot context, warm memory, cold context vía MCP.

### Overrides por proyecto

| Proyecto | Override | Notas |
|---|---|---|
| Yap | `project-overrides/Yap/opencode.json` | ADEV + Semgrep enabled |
| DataGestor | `project-overrides/DataGestor/opencode.json` | ADEV + Semgrep enabled; Postgres no inventado |
| krono | `project-overrides/krono/opencode.json` | ADEV + Playwright enabled |
| homedir | `project-overrides/homedir/opencode.json` | ADEV + Semgrep enabled |

### Deliberadamente excluido

| Elemento | Motivo |
|---|---|
| tokens/auth/cache/logs | Seguridad |
| `node_modules` | Reproducible, pesado |
| `opencode-api-security-testing` | Fallaba al compilar |
| `opencode-worktree` | Paquete no cargaba |
| `opencode-snip` | Requería binario `snip` inexistente |
| Braintrust plugin | Falta API key |
| Postgres URLs inventadas | Evitar config falsa |

## Instalación

```bash
./install.sh
```

Luego reinicia OpenCode.

## Requisitos manuales

Fish:

```fish
set -Ux GITHUB_TOKEN "tu_token_de_github"
```

No guardes tokens en este repo.

## Estructura

```text
.config/opencode/        # config global
project-overrides/       # .opencode por proyecto
```

## Notas

- `semgrep` y `postgres` quedan desactivados globalmente.
- `opencode-mem` tiene auto-capture desactivado para evitar 401 sin API key.
- El path local de ponytail apunta a `/home/vector/.local/share/ponytail/...`.
