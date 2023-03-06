extends Node2D

onready var line: Line2D = $Line2D
onready var line2: Line2D = $Line2D2
func _physics_process(delta: float) -> void:
#	if !get_parent().can_jump:
#		hide()
#		return
	show()
	update_points()
	
	
	
func update_points():
	line.points[0] = Vector2()
	var shoot_range = get_parent().shoot_range
	var power = min(owner.input_state.aim_dist, shoot_range)
	
	var ratio = power/shoot_range
	if ratio <0.5:
		line.default_color = Color.green.linear_interpolate(Color.yellow,ratio*2)
	else:
		line.default_color = Color.yellow.linear_interpolate(Color.red,(ratio-0.5)*2)
	
	line.points[1] = owner.input_state.aim_dir*power
	line2.points[1] = owner.input_state.aim_dir*shoot_range
