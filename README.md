# Hnqrstation

A mobile-first 3D open-world roleplay prototype built with Godot 4.7.

## Current prototype foundation

- World scale uses metres: 1 Godot unit = 1 metre.
- 100 m × 100 m test ground with matching collision.
- Procedural asphalt-like ground shader using inexpensive noise; no texture maps required.
- Mobile renderer, restrained environment lighting, and one directional shadow-casting light.
- Player collision and visual reference are both capsule-shaped: 1.8 m tall and 0.64 m wide.
- First-person camera at 1.62 m eye height; the player's capsule is excluded from the first-person camera render mask.
- Walk speed: 4.5 m/s; sprint: 7 m/s; jump velocity: 4.2 m/s.

## Controls

### Desktop
- W / A / S / D: Move
- Mouse: Look
- Shift: Sprint
- Space: Jump
- Escape: Release mouse
- Left click: Capture mouse again

### Android
- Left joystick: Move
- Swipe the right half of the screen: Look
- JUMP button: Jump

The mobile controls are created only when Godot reports a touchscreen device.

## Performance approach

The current ground shader is procedural and texture-free. The scene avoids expensive global illumination, volumetric fog, glow, and screen-space effects. It uses the Mobile renderer and a single directional light with bounded shadow distance. Visual quality and frame rate still need to be profiled on target Android devices.
