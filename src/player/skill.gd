extends Node2D
class_name Skill

export var disabled := false setget set_disabled
export var unlocked := true setget set_unlocked

func set_disabled(val):
	disabled = val
	update_availability()
func set_unlocked(val):
	unlocked = val
	update_availability()
func update_availability():
	var available = is_available()
	visible = available
	set_physics_process(available)
	set_process(available)
	set_process_input(available)
	set_process_unhandled_input(available)
	set_process_unhandled_key_input(available)
	set_process_internal(available)
	set_physics_process_internal(available)


func is_available():
	return !disabled and unlocked
func get_wearer():
	return owner
