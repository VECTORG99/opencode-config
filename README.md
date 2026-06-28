# OpenCode Config

Configuración personal de OpenCode para desarrollo agentico profesional.

## Qué incluye

- A-Dev (`@adev`) y metodología SDD
- MCPs: Context7, GitHub, Playwright, Semgrep/Postgres desactivados por defecto
- Plugins: ponytail, forge, memory, safety, browser, skills, review helper, log sanitizer
- Agentes: `eyes`, `VEC`
- Skills: A-Dev, TDD, Caveman, Skill Creator
- Overrides de ejemplo por tipo de proyecto: Python agent, data app, full-stack web, A-Dev project

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
| Python agent | `examples/project-overrides/python-agent/opencode.json` | ADEV + Semgrep enabled |
| Data app | `examples/project-overrides/data-app/opencode.json` | ADEV + Semgrep enabled; Postgres disabled by default |
| Full-stack web | `examples/project-overrides/fullstack-web/opencode.json` | ADEV + Playwright enabled |
| A-Dev project | `examples/project-overrides/adev-project/opencode.json` | ADEV + Semgrep enabled |

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

### Secretos / variables de entorno

Este repo **no incluye secretos**. Cada usuario debe configurar sus propios tokens localmente.

| Variable | Obligatoria | Para qué sirve | Cómo obtenerla |
|---|---:|---|---|
| `GITHUB_TOKEN` | Sí, si usarás GitHub MCP | Permite a OpenCode leer repos, issues, PRs y code search vía GitHub MCP | GitHub → Settings → Developer settings → Personal access tokens |
| `OPENAI_API_KEY` | No | Solo si reactivas `opencode-mem` auto-capture con OpenAI | OpenAI dashboard |
| `ANTHROPIC_API_KEY` | No | Solo si reactivas `opencode-mem` auto-capture con Anthropic | Anthropic console |
| `GROQ_API_KEY` | No | Alternativa barata para auto-capture si configuras Groq | Groq console |
| `POSTGRES_URL` | No | Solo si habilitas MCP Postgres para un proyecto | Tu DB local/remota |
| `SEMGREP_APP_TOKEN` | No | Solo si usas Semgrep Cloud; local Docker no lo requiere | Semgrep dashboard |

### GitHub MCP recomendado

Permisos mínimos sugeridos para token clásico:

- `repo` si quieres trabajar con repos privados
- `read:org` si necesitas orgs privadas
- `workflow` solo si vas a tocar GitHub Actions

En Fish:

```fish
set -Ux GITHUB_TOKEN "tu_token_de_github"
```

Verificar sin imprimir el token:

```fish
test -n "$GITHUB_TOKEN"; and echo set; or echo missing
gh auth status
```

Si prefieres usar GitHub CLI:

```fish
gh auth login
set -Ux GITHUB_TOKEN (gh auth token)
```

### Postgres MCP opcional

El MCP Postgres viene desactivado por defecto para no romper instalaciones.

Para activarlo en un proyecto, crea `.opencode/opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "postgres": {
      "type": "local",
      "command": [
        "npx",
        "-y",
        "@modelcontextprotocol/server-postgres",
        "postgresql://readonly_user:REPLACE_ME@localhost:5432/db"
      ],
      "enabled": true
    }
  }
}
```

Mejor práctica: usar un usuario **read-only**.

### opencode-mem auto-capture opcional

`opencode-mem` queda instalado, pero `autoCaptureEnabled` está en `false` para evitar errores 401.

Para activarlo, edita:

```text
~/.config/opencode/opencode-mem.jsonc
```

Y configura provider/model/API key. Ejemplo con variable de entorno:

```jsonc
"autoCaptureEnabled": true,
"memoryProvider": "openai-chat",
"memoryModel": "gpt-4o-mini",
"memoryApiUrl": "https://api.openai.com/v1",
"memoryApiKey": "env://OPENAI_API_KEY"
```

En Fish:

```fish
set -Ux OPENAI_API_KEY "tu_api_key"
```

No guardes tokens en este repo.

## Estructura

```text
.config/opencode/            # config global portable
examples/project-overrides/   # overrides de ejemplo por tipo de proyecto
```

## Notas

- `semgrep` y `postgres` quedan desactivados globalmente.
- `opencode-mem` tiene auto-capture desactivado para evitar 401 sin API key.
- `install.sh` clona Ponytail y A-Dev en `$HOME/.local/share/` si faltan.
- `install.sh` reemplaza `__HOME__` por tu `$HOME` real en `opencode.json`.

## Fuentes y créditos

Esta configuración junta trabajo propio con herramientas/skills de terceros. Revisa también [`THIRD_PARTY_NOTICES.md`](./THIRD_PARTY_NOTICES.md).

| Componente | Fuente |
|---|---|
| A-Dev / `@adev` | https://github.com/scanalesespinoza/adev |
| Ponytail | https://github.com/DietrichGebert/ponytail |
| Caveman | https://github.com/JuliusBrussee/caveman |
| Defending Code Reference Harness | https://github.com/anthropics/defending-code-reference-harness |
| Context7 MCP | https://github.com/upstash/context7 |
| GitHub MCP Server | https://github.com/github/github-mcp-server |
| Playwright MCP | https://github.com/microsoft/playwright-mcp |
| MCP reference servers | https://github.com/modelcontextprotocol/servers |

Los paquetes npm configurados se instalan bajo sus propias licencias desde npm/OpenCode al iniciar o ejecutar OpenCode. Este repo no incluye tokens, credenciales ni datos privados.
