# OpenCode Config

Configuración personal de OpenCode para desarrollo agentico profesional.

## Qué incluye

- A-Dev (`@adev`) y metodología SDD
- MCPs: Context7, GitHub, Playwright, Semgrep/Postgres desactivados por defecto
- Plugins: ponytail, forge, memory, safety, browser, skills, review helper, log sanitizer
- Agentes: `eyes`, `VEC`
- Skills: A-Dev, TDD, Caveman, Skill Creator
- Overrides por proyecto: Yap, DataGestor, krono, homedir

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
