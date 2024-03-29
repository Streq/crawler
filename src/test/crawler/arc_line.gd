extends Node2D

export var point_count := 100
export var texture : Texture
export var disabled := false

var points := []


func _physics_process(delta: float) -> void:
	if !get_parent().can_jump:
		modulate.a = 0.25
	else:
		modulate.a = 1.0
	show()
	update_points()

func _ready() -> void:
	points.resize(point_count)

func update_points():
	var speed : float = get_parent().speed*get_parent().get_power()
	var wearer = get_wearer()
	var gravity : Vector2 = wearer.gravity
	var delta = 1.0/Engine.iterations_per_second
	var ground = wearer.ground
	var ground_velocity = ground.perceived_velocity if ground else Vector2()
	
	var velocity : Vector2 =get_parent().get_jump_velocity()
	var current_estimated_point := Vector2()
	
	var params = Physics2DShapeQueryParameters.new()
	params.collision_layer = 1
	params.shape_rid = wearer.shape_owner_get_shape(0,0).get_rid()
	params.collide_with_areas = true
	var done = false
	for i in point_count:
		if !done:
			params.transform = Transform2D(0, current_estimated_point+global_position)
			params.motion = velocity*delta
			
			if get_world_2d().direct_space_state.intersect_shape(params):
				done = true
	
			current_estimated_point += velocity*delta
			
			velocity += gravity*delta
	
		points[i] = current_estimated_point
	
	Gradient.new()

	
	
func get_wearer():
	return owner.get_wearer()
