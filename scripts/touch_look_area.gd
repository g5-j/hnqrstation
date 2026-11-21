extends Control
## Converts right-side screen drags into first-person camera movement.

var player: Node


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP


func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenDrag and is_instance_valid(player):
		player.call("add_look_input", event.relative)
