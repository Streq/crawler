extends Camera2D


func _process(delta: float) -> void:
	var input = get_parent().input_state
	if input.D.is_pressed():
		offset = (get_viewport().get_mouse_position()-get_viewport().size/2.0)*2.0
	else:
		offset = Vector2()
