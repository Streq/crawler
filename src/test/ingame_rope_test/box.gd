extends KinematicBody2D


export var velocity := Vector2()
export var gravity := Vector2()


func _physics_process(delta: float) -> void:
	velocity += gravity*delta
	velocity = move_and_slide(velocity)
	if is_on_wall():
		velocity*=(1.0-delta*5.0)
