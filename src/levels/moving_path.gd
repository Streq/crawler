extends PathFollow2D

export var speed := 100.0

func _physics_process(delta: float) -> void:
	offset+=speed*delta
