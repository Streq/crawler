extends Skill

export var speed = 100.0

export var shoot_range := 100.0


var estimated_power := 0.0
export var can_jump := false
export var air_jumps := 0
export var current_air_jumps := 0
export var jump_power_factor = PoolRealArray([1.0,1.0,1.0])

signal jump()


func is_available():
	return !disabled and unlocked

func jump():
	if !is_available(): 
		return
	owner.velocity = get_jump_velocity()
	owner.reparent_to_wall(owner.world)
	emit_signal("jump")

func process(delta):
	if !is_available():
		return
	can_jump = owner.is_on_wall() or current_air_jumps > 0
	if can_jump and owner.input_state.A.is_just_pressed():
		jump()
		if !owner.is_on_wall:
			current_air_jumps -= 1
		

func get_inertia():
	return owner.ground.perceived_velocity if owner.ground else Vector2()

func _physics_process(delta: float) -> void:
	if owner.is_on_wall():
		current_air_jumps = air_jumps

func get_power()->float:
	return min(owner.input_state.aim_dist,shoot_range)/shoot_range*jump_power_factor[air_jumps-current_air_jumps]

func get_jump_velocity()->float:
	return owner.input_state.aim_dir*speed * get_power() + get_inertia()
