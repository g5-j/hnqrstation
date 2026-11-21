extends Control
## Small on-screen analog stick used by the Android touch interface.

signal value_changed(value: Vector2)

var _finger_index: int = -1
var _value: Vector2 = Vector2.ZERO


func _ready() -> void:
	custom_minimum_size = Vector2(180.0, 180.0)
	mouse_filter = Control.MOUSE_FILTER_STOP
	queue_redraw()


func _draw() -> void:
	var center := size * 0.5
	var base_radius := minf(size.x, size.y) * 0.39
	var knob_radius := base_radius * 0.43

	draw_circle(center, base_radius, Color(0.04, 0.07, 0.1, 0.38))
	draw_arc(center, base_radius, 0.0, TAU, 48, Color(0.85, 0.91, 1.0, 0.48), 3.0)
	draw_circle(center + _value * base_radius * 0.68, knob_radius, Color(0.72, 0.84, 0.96, 0.72))


func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and _finger_index == -1:
			_finger_index = event.index
			_update_value(event.position)
		elif not event.pressed and event.index == _finger_index:
			_finger_index = -1
			_value = Vector2.ZERO
			value_changed.emit(_value)
			queue_redraw()

	elif event is InputEventScreenDrag and event.index == _finger_index:
		_update_value(event.position)


func _update_value(position: Vector2) -> void:
	var center := size * 0.5
	var radius := minf(size.x, size.y) * 0.39
	var offset := position - center
	_value = offset.limit_length(radius) / radius
	value_changed.emit(_value)
	queue_redraw()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		queue_redraw()
