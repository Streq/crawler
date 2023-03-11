extends Node

#func _unhandled_input(event: InputEvent) -> void:
#	if "input_state" in get_parent():
#		var state = get_parent().input_state
#		if event.is_action("A"):
#			state.A.pressed = event.is_pressed()
#		if event.is_action("B"):
#			state.B.pressed = event.is_pressed()

func _physics_process(delta: float) -> void:
	var dist_to_mouse = get_parent().get_global_mouse_position()-get_parent().global_position
	var state = get_parent().input_state
	state.aim_dir = dist_to_mouse.limit_length()
	state.aim_dist = dist_to_mouse.length()
	state.dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	state.A.pressed = Input.is_action_pressed("A")
	state.B.pressed = Input.is_action_pressed("B")
