extends SceneTree

func _initialize() -> void:
	call_deferred("_run_smoke_test")


func _run_smoke_test() -> void:
	var packed_scene := load("res://scenes/main.tscn") as PackedScene
	if packed_scene == null:
		push_error("SMOKE TEST FAILED: scenes/main.tscn could not be loaded.")
		quit(1)
		return

	var main_scene := packed_scene.instantiate()
	if main_scene == null:
		push_error("SMOKE TEST FAILED: main scene could not be instantiated.")
		quit(1)
		return

	root.add_child(main_scene)
	await process_frame

	var player := main_scene.get_node_or_null("Player") as CharacterBody3D
	if player == null:
		push_error("SMOKE TEST FAILED: Player CharacterBody3D is missing.")
		quit(1)
		return

	var camera := player.get_node_or_null("Head/Camera3D") as Camera3D
	if camera == null:
		push_error("SMOKE TEST FAILED: Player camera is missing.")
		quit(1)
		return

	var floor := main_scene.get_node_or_null("Floor/FloorMesh") as MeshInstance3D
	if floor == null or floor.mesh == null:
		push_error("SMOKE TEST FAILED: Floor mesh is missing.")
		quit(1)
		return

	await physics_frame
	print("SMOKE TEST PASSED: main scene, player, camera, floor, and one physics frame.")
	quit(0)
