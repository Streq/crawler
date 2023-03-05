extends Node2D
onready var no_more_floor_detect: RayCast2D = $"%no_more_floor_detect"
onready var corner_detect: RayCast2D = $"%corner_detect"

onready var pivot: Node2D = $"%pivot"

export var alpha_x := 6.0
export var alpha_y := 1.0

func is_in_corner():
	no_more_floor_detect.force_raycast_update()
	if !no_more_floor_detect.is_colliding():
		corner_detect.force_raycast_update()
		return corner_detect.is_colliding()
	return false


func turn_corner():
	var collision_normal = corner_detect.get_collision_normal()
	var collision_point = corner_detect.get_collision_point()
	
	var r : RayCast2D = corner_detect
	
	var rotation = pivot.global_rotation
	
	var pivot_xform : Transform2D = pivot.transform
	
	var global_position_rotated = pivot_xform.xform_inv(owner.global_position)
	var collision_point_rotated = pivot_xform.xform_inv(collision_point)
	
	var alpha := Vector2()
	alpha.y = global_position_rotated.y+alpha_y
	alpha.x = collision_point_rotated.x+alpha_x
	owner.global_position = pivot_xform.xform(alpha)

	pivot.global_rotation = PI/2 + collision_normal.angle()
	owner.velocity = pivot.transform.xform(Vector2.DOWN)*1000.0
