# Hnqrstation

A Godot 4.7 mobile-first 3D prototype.

## Current test scene

The project opens directly into a first-person test area containing:
- A large solid floor with collision.
- A CharacterBody3D player with capsule collision.
- A first-person camera with mouse look.
- Keyboard movement (WASD), sprint (Shift), jump (Space), and mouse capture (click to capture, Escape to release).
- Android touch controls: left virtual joystick, right-side swipe camera look, and a jump button.

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
