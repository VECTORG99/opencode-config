---
name: game-developer
description: Use when building games, game systems, or interactive simulations. Covers Roblox (Luau), Godot (GDScript), Unity (C#), and general game loop/physics/ECS patterns. Invoke for combat systems, entity AI, procedural generation, save systems, and performance tuning.
license: MIT
compatibility: opencode
metadata:
  author: https://github.com/Jeffallan
  version: "1.1.0"
  domain: gamedev
  triggers: Roblox, Luau, Godot, GDScript, Unity, game loop, ECS, combat, AI, procedural, save system
  role: specialist
  scope: implementation
  output-format: code
  related-skills: typescript-pro, python-pro
---

# Game Developer

Game systems across engines: Roblox (Luau), Godot (GDScript), Unity (C#), and engine-agnostic patterns.

## When to Use

- Building combat, AI, procedural generation, or save systems
- Roblox: ModuleScripts, DataStores, RemoteEvents, Rojo
- Godot: nodes, signals, `_physics_process`, scene trees
- Unity: MonoBehaviours, ScriptableObjects, DOTS/ECS
- Engine-agnostic: game loop, fixed timestep, ECS, state machines

## Core Workflow

1. **Architecture** — separate logic from presentation; favor composition
2. **Game loop** — fixed timestep for physics, variable for render
3. **Entities** — ECS or component composition over deep inheritance
4. **State** — explicit state machines for AI and UI
5. **Persistence** — versioned save schema; never break old saves
6. **Performance** — profile early; batch draws, pool objects

## Constraints

### MUST DO

- Separate game logic from rendering/engine calls
- Use fixed timestep for deterministic physics
- Version save schemas and migrate old saves
- Pool frequently spawned/freed objects
- Use state machines for AI and UI flow

### MUST NOT DO

- Use deep inheritance hierarchies for entities
- Hardcode tuning values; expose them as data
- Block the main thread with long work
- Break save compatibility without a migration path
- Leave debug visuals in release builds

## Code Examples

### Roblox Luau: ModuleScript state machine

```lua
local StateMachine = {}
StateMachine.__index = StateMachine

function StateMachine.new(initial)
  return setmetatable({ state = initial, transitions = {} }, StateMachine)
end

function StateMachine:add(from, to, fn)
  self.transitions[from] = self.transitions[from] or {}
  self.transitions[from][to] = fn
end

function StateMachine:go(to)
  local fn = (self.transitions[self.state] or {})[to]
  if not fn then error(("no transition %s -> %s"):format(self.state, to)) end
  fn(self)
  self.state = to
end

return StateMachine
```

### Fixed timestep loop (engine-agnostic)

```python
import time

def run(target_fps: int = 60) -> None:
    fixed_dt = 1.0 / target_fps
    accumulator = 0.0
    last = time.monotonic()
    while True:
        now = time.monotonic()
        accumulator += now - last
        last = now
        while accumulator >= fixed_dt:
            physics_step(fixed_dt)
            accumulator -= fixed_dt
        render()
```

## Knowledge Reference

Roblox Luau, DataStore, Rojo; Godot 4, GDScript, signals; Unity, C#, MonoBehaviours, ScriptableObjects; game loop, fixed timestep, ECS, state machines, object pooling, save versioning