extends Node2D

export var use_owner_angle := true
export var angle_degrees := 360

func _draw():
	var center = Vector2.ZERO
	var vista = get_parent().get_parent()
	get_parent().size.x = vista.radius*2
	get_parent().size.y = vista.radius*2
	
	if use_owner_angle:
		var half_vision_angle = vista.angle_degrees
		RenderUtils.draw_circle_slice(self, center, vista.radius, -half_vision_angle, half_vision_angle, Color.white)
	else:
		var half_vision_angle = angle_degrees
		RenderUtils.draw_circle_slice(self, center, vista.radius, -half_vision_angle, half_vision_angle, Color.white)
	
