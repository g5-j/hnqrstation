extends CharacterBody3D
## First-person controller. World distances and speeds are measured in metres and m/s.

@export_category("Movement (metres per second)")
@export var walk_speed: float = 4.5
@export var sprint_speed: float = 7.0
@export var jump_velocity: float = 4.2
@export var ground_acceleration: float = 18.0
@export var air_acceleration: float = 5.0

@export_category("Camera")
@export_range(0.0005, 0.01, 0.0001) var mouse_sensitivity: float = 0.0022
@export_range(60.0, 100.0, 1.0) var camera_fov: float = 80.0
@export_range(1.4, 1.8, 0.01) var eye_height: float = 1.62

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D

var _pitch: float = 0.0
var _gravity: float = float(ProjectSettings.get_setting("physics/3d/default_gravity"))
var _mobile_move: Vector2 = Vector2.ZERO
var _jump_requested: bool = false


func _ready() -> void:
	camera.fov = camera_fov
	head.position.y = eye_height
	floor_snap_length = 0.25
	if not DisplayServer.is_touchscreen_available():
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not DisplayServer.is_touchscreen_available():
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		add_look_input(event.relative)

	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif event.keycode == KEY_SPACE:
			request_jump()


func _physics_process(delta: float) -> void:
	var input_vector := _get_keyboard_movement()
	if _mobile_move.length_squared() > 0.001:
		input_vector = _mobile_move

	input_vector = input_vector.limit_length(1.0)
	var local_direction := Vector3(input_vector.x, 0.0, input_vector.y)
	var move_direction := (transform.basis * local_direction).normalized()

	var current_speed := sprint_speed if Input.is_key_pressed(KEY_SHIFT) else walk_speed
	var acceleration := ground_acceleration if is_on_floor() else air_acceleration

	velocity.x = move_toward(velocity.x, move_direction.x * current_speed, acceleration * delta)
	velocity.z = move_toward(velocity.z, move_direction.z * current_speed, acceleration * delta)

	if not is_on_floor():
		velocity.y -= _gravity * delta
	elif velocity.y < 0.0:
		velocity.y = 0.0

	if _jump_requested:
		if is_on_floor():
			velocity.y = jump_velocity
		_jump_requested = false

	move_and_slide()


func _get_keyboard_movement() -> Vector2:
	var direction := Vector2.ZERO

	if Input.is_key_pressed(KEY_A):
		direction.x -= 1.0
	if Input.is_key_pressed(KEY_D):
		direction.x += 1.0
	if Input.is_key_pressed(KEY_W):
		direction.y -= 1.0
	if Input.is_key_pressed(KEY_S):
		direction.y += 1.0

	return direction.normalized()


func add_look_input(relative: Vector2) -> void:
	rotate_y(-relative.x * mouse_sensitivity)
	_pitch = clampf(
		_pitch - relative.y * mouse_sensitivity,
		deg_to_rad(-85.0),
		deg_to_rad(85.0)
	)
	head.rotation.x = _pitch


func set_mobile_move(value: Vector2) -> void:
	_mobile_move = value


func request_jump() -> void:
	_jump_requested = true
