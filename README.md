# Hnqrstation

A mobile-first 3D open-world roleplay prototype built with Godot 4.7.

## Rendering and lighting

- Godot Mobile renderer (Vulkan).
- GoyGI 3.2 real-time global illumination plugin for bounced light, sky contribution and colour bleeding.
- Low quality profile configured for entry-level mobile GPUs, including Mali-G52-class hardware.
- Automatic frame-budget control, near-only world cache and 15 Hz GI update target.
- Fast surface filtering, fast triplanar projection and normal maps disabled for the mobile baseline.
- GoyGI disables compute GI gracefully when a Vulkan RenderingDevice is unavailable; direct lighting remains active.
- Directional sun shadows enabled with a 35 m distance.
- Procedural sky and ambient environment lighting remain active.
- Native Godot materials remain the fallback path.

## World and controls

- World scale uses metres: 1 Godot unit = 1 metre.
- 100 m × 100 m test ground with matching collision.
- Asphalt ground uses a lightweight Godot StandardMaterial3D and a small texture.
- Uses Godot's default 3D physics backend for broad Android compatibility.
- Player collision and visual reference are capsule-shaped: 1.8 m tall and 0.64 m wide.
- First-person camera at 1.62 m eye height; the player's capsule is excluded from the first-person camera render mask.
- Walk speed: 4.5 m/s; sprint: 7 m/s; jump velocity: 4.2 m/s.

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

## GoyGI configuration

The GoyGI editor plugin and runtime autoload are enabled. Initial settings use the Low quality tier, fast surface filtering, disabled normal maps, fast triplanar projection, near-only cache and automatic frame-budget control. Adjust values under Project Settings > goygi/options only after testing on the target device.

GoyGI requires Vulkan and a RenderingDevice for compute-based global illumination. On devices or editor configurations without that support, it falls back to direct lighting rather than stopping the game.

## Validation

GitHub Actions imports the project with software Vulkan to compile GoyGI compute shaders, then runs a headless project smoke test. CI does not prove compatibility with the Android GPU driver; the final check must be performed on the target phone.
