---
name: desktop-control
description: Computer Use for Linux desktop via computer-use-linux MCP server. Use when the task requires seeing the screen, clicking UI elements, typing into windows, listing/focusing windows, or automating desktop workflows on Hyprland/Wayland. Integrates with hyprctl, grim, ydotool.
---

# Desktop Control (computer-use-linux)

Controla el escritorio Linux real desde OpenCode usando los MCP tools de `computer-use-linux`.

## Herramientas disponibles

Todas vía MCP server `computer-use-linux`:

| Herramienta | Para qué sirve |
|---|---|
| `screenshot` | Capturar pantalla completa o ventana. Retorna PNG/JPEG + metadata de coordenadas |
| `list_windows` | Listar ventanas abiertas con título, app_id, wm_class, bounds |
| `focused_window` | Ventana con foco actual |
| `activate_window` | Enfocar ventana por window_id, pid, app_id, wm_class, title |
| `click` | Click por coordenadas, índice de elemento, o selector semántico |
| `type_text` | Escribir texto en la ventana enfocada |
| `press_key` | Presionar teclas/chords (enter, ctrl+c, alt+tab, super, etc.) |
| `scroll` | Scroll vertical en posición |
| `drag` | Arrastrar de coordenada A a B |
| `get_app_state` | Screenshot + accessibility tree de una app específica |
| `doctor` | Diagnóstico del sistema (usar antes de empezar) |
| `list_apps` | Apps visibles vía AT-SPI |

## Flujo de trabajo

1. **Diagnóstico inicial** — llama `doctor` para verificar que todo está verde
2. **Entender el estado** — `screenshot` para ver la pantalla (pide al usuario que posicione las ventanas si es necesario)
3. **Interpretar** — analiza el screenshot con tu modelo de visión, identifica coordenadas/elementos
4. **Actuar** — usa `click` (coordenadas), `type_text`, `press_key`, o `activate_window`
5. **Verificar** — toma otro screenshot y confirma que el estado es el esperado
6. **Iterar** — si falló, ajusta coordenadas y reintenta

## Safety rules (MUST DO)

### MUST DO
- Siempre llamar `doctor` al inicio de la sesión para verificar conectividad
- Antes de click/type, tomar screenshot y analizar dónde está el elemento objetivo
- Verificar con screenshot después de cada acción mutante
- Usar `list_windows` para identificar ventanas antes de `activate_window`
- Si `screenshot` retorna imagen negra en multi-monitor, usar `get_app_state` con `include_screenshot: false`

### MUST NOT DO
- No escribir contraseñas, tokens, secrets via `type_text`
- No hacer click en coordenadas sin ver el screenshot primero
- No ejecutar acciones destructivas (rm, delete, sudo) vía `press_key`
- No asumir coordenadas fijas entre sesiones — el layout de ventanas cambia

## Manejo de scaling (HiDPI)

Hyprland usa escala fraccional. Al interpretar coordenadas del screenshot:
- Usar el `scale` del metadata que retorna `screenshot` para convertir píxeles de imagen a coordenadas de escritorio
- Ejemplo: screenshot 960x540 con scale=2 → escritorio 1920x1080 → coordenada click real = screenshot_x * 2

## Compatibilidad

- **Hyprland**: window targeting vía `hyprctl` (nativo, funciona)
- **KDE/KWin**: window targeting vía KWin scripting
- **GNOME**: requiere GNOME Shell extension instalada
- **Wayland general**: screenshots vía portal, input vía portal o ydotool

## Troubleshooting común

```text
Problema: doctor muestra input.ydotool_socket: false
→ systemctl --user enable --now ydotoald

Problema: screenshot retorna negro
→ Usar get_app_state con include_screenshot: false (AT-SPI tree)
```

## Referencias

- Repo: https://github.com/agent-sh/computer-use-linux
- MCP tools: screenshot, list_windows, click, type_text, press_key, scroll, drag, activate_window, get_app_state, doctor
- Input fallback: ydotool via ydotoald (/dev/uinput)
- Screenshot: grim (wlroots) o portal (xdg-desktop-portal)
