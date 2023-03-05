extends Node2D

export var speed = 100.0

export var shoot_range := 100.0

onready var arc_line: Node2D = $arc_line

var estimated_power := 0.0
export var can_jump := false


func jump():
	var power := 0.0
	power = min(owner.input_state.aim_dist,shoot_range)/shoot_range
	owner.velocity = owner.input_state.aim_dir*speed * power
#	NodeUtils.reparent_keep_transform(arc_line,owner.get_parent())
func process(delta):
#	if owner.input_state.A.is_just_pressed() and owner.is_on_wall():
	can_jump = owner.is_on_wall()
#	can_jump = true
	if can_jump and owner.input_state.A.is_just_pressed():
		jump()

func _physics_process(delta: float) -> void:
#	if owner.is_on_wall() and arc_line.get_parent()!=self:
#		NodeUtils.reparent_keep_transform(arc_line, self)
	if can_jump:
		estimated_power = min(owner.input_state.aim_dist,shoot_range)/shoot_range
