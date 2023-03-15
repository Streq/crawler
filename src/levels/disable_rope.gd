extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	yield(get_parent(),"ready")
	get_parent().get_node("%rope").unlocked = false
