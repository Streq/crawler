extends Node2D

export var angle := PI/4
export var distance := 100.0
onready var ray: RayCast2D = $"../ray"

func can_see(target_pos):
	var within_range = (
		global_position.distance_squared_to(target_pos)<distance*distance and
		abs(Math.angle_distance(target_pos.angle_to_point(global_position),global_rotation)) < angle
	)
	
	if !within_range:
		return false
	ray.cast_to = ray.to_local(target_pos)
	ray.force_raycast_update()
	return !ray.is_colliding()
	
	

func _draw():
	RenderUtils.draw_circle_slice_no_fill(self, Vector2(), distance, -angle, angle, Color.red)
