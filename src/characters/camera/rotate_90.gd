extends Node

export var rotation_degrees := 0.0
export var max_rotation_degrees := 90.0
var initial_rotation_degrees := 0.0
export var loop_duration := 2.0
export var loop_boomerang := true
func _ready() -> void:
	initial_rotation_degrees = get_parent().rotation_degrees
	var tween = create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(self,"rotation_degrees", max_rotation_degrees, loop_duration)
	if loop_boomerang:
		tween.tween_property(self,"rotation_degrees", 0.0, loop_duration)
	else:
		tween.tween_callback(self,"set", ["rotation_degrees", 0.0])
	tween.set_loops()

func _physics_process(delta: float) -> void:
	get_parent().rotation_degrees = initial_rotation_degrees+rotation_degrees
