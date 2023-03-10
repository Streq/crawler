extends Node2D

export var perceived_velocity := Vector2()
onready var last_position := global_position
func _physics_process(delta: float) -> void:
	perceived_velocity = (global_position-last_position)/delta
	last_position = global_position
	
