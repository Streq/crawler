extends KinematicBody2D


export var velocity := Vector2()
export var gravity := Vector2()
export var previous_velocity := Vector2()

func _physics_process(delta: float) -> void:
	velocity += gravity*delta
	previous_velocity = velocity
	velocity = move_and_slide(velocity)
	
	if get_slide_count() > 0 and previous_velocity.distance_to(velocity)>100.0:
		die()
	
	if is_on_wall():
		velocity*=(1.0-delta*5.0)
	


func die():
	queue_free()
