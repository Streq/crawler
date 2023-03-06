extends Node2D

onready var hook: Node2D = $"%hook"

func _physics_process(delta: float) -> void:
	if hook.get_parent() != self:
		pass
