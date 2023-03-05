extends Node2D

onready var line: Line2D = $Line2D
func _physics_process(delta: float) -> void:
	if !get_parent().can_jump:
		hide()
		return
	show()
	update_points()
	
	
	
func update_points():
	line.points[0] = Vector2()
	var shoot_range = get_parent().shoot_range
	var power = min(owner.input_state.aim_dist, shoot_range)
	
	line.default_color = Color.green.linear_interpolate(Color.red,power/shoot_range)
	
	line.points[1] = owner.input_state.aim_dir*power
