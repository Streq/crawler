extends Node
export var trigger := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !trigger:
		return
	yield(get_parent(),"ready")
	get_parent().get_node("%jump").unlocked = false
#	get_parent().get_node("%jump").shoot_range = 50.0
