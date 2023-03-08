extends Node2D

export var speed = 100.0

export var shoot_range := 100.0


var estimated_power := 0.0
export var can_jump := false

signal jump()
func jump():
	var power := 0.0
	power = min(owner.input_state.aim_dist,shoot_range)/shoot_range
	owner.velocity = owner.input_state.aim_dir*speed * power
	emit_signal("jump")
func process(delta):
	can_jump = owner.is_on_wall()
	if can_jump and owner.input_state.A.is_just_pressed():
		jump()

func _physics_process(delta: float) -> void:
	estimated_power = min(owner.input_state.aim_dist,shoot_range)/shoot_range
