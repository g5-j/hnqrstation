extends CanvasLayer
## Creates a virtual joystick, swipe-to-look area, and jump button on touch devices.

const JOYSTICK_SCRIPT := preload("res://scripts/virtual_joystick.gd")
const LOOK_AREA_SCRIPT := preload("res://scripts/touch_look_area.gd")

@export var player_path: NodePath = NodePath("../Player")


func _ready() -> void:
	if not DisplayServer.is_touchscreen_available():
		return

	var player := get_node_or_null(player_path)
	if player == null:
		push_warning("Touch controls could not find the player node.")
		return

	_create_look_area(player)
	_create_joystick(player)
	_create_jump_button(player)


func _create_look_area(player: Node) -> void:
	var look_area := Control.new()
	look_area.name = "LookArea"
	look_area.set_script(LOOK_AREA_SCRIPT)
	look_area.set("player", player)
	look_area.anchor_left = 0.5
	look_area.anchor_top = 0.0
	look_area.anchor_right = 1.0
	look_area.anchor_bottom = 1.0
	look_area.offset_left = 0.0
	look_area.offset_top = 0.0
	look_area.offset_right = 0.0
	look_area.offset_bottom = 0.0
	add_child(look_area)


func _create_joystick(player: Node) -> void:
	var joystick := Control.new()
	joystick.name = "MovementJoystick"
	joystick.set_script(JOYSTICK_SCRIPT)
	joystick.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	joystick.offset_left = 28.0
	joystick.offset_top = -208.0
	joystick.offset_right = 208.0
	joystick.offset_bottom = -28.0
	add_child(joystick)
	joystick.connect("value_changed", Callable(player, "set_mobile_move"))


func _create_jump_button(player: Node) -> void:
	var jump_button := Button.new()
	jump_button.name = "JumpButton"
	jump_button.text = "JUMP"
	jump_button.focus_mode = Control.FOCUS_NONE
	jump_button.custom_minimum_size = Vector2(100.0, 64.0)
	jump_button.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
	jump_button.offset_left = -132.0
	jump_button.offset_top = -112.0
	jump_button.offset_right = -28.0
	jump_button.offset_bottom = -28.0
	add_child(jump_button)
	jump_button.button_down.connect(Callable(player, "request_jump"))
