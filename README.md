# Hnqrstation

A mobile-first 3D open-world roleplay prototype built with Godot 4.7.

## Current prototype foundation

- World scale uses metres: 1 Godot unit = 1 metre.
- 100 m × 100 m test ground with matching collision.
- Asphalt ground uses a lightweight Godot StandardMaterial3D and a small texture.
- Mobile renderer with a procedural sky and ambient environment lighting.
- Real-time directional shadows are disabled in this stability-focused mobile baseline.
- Uses Godot's default 3D physics backend for broad Android compatibility.
- Player collision and visual reference are capsule-shaped: 1.8 m tall and 0.64 m wide.
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

## Performance and validation

The baseline avoids custom shaders, real-time shadows, global illumination, volumetric fog, glow, and screen-space effects. It uses the Mobile renderer and a single textured ground material to reduce GPU workload on entry-level Android devices.

The GitHub Actions workflow imports project resources, checks the main scene and scripts, and runs a headless scene smoke test. A successful desktop headless test does not replace testing on the target Android GPU.
