extends State


onready var input : InputState = owner.get_node("%input_state")

func _physics_update(delta: float) -> void:
	if root.is_on_wall:
		var dir : Vector2 = input.dir
		if dir.dot(root.current_floor_normal)>0:
			dir -= dir.project(root.current_floor_normal)
#		print(dir,current_floor_normal)
		
		dir.x = sign(dir.x)
		dir.y = sign(dir.y)
		root.velocity = root.speed*dir
		root.stick_to_wall()
		root.set_facing_dir(dir.dot(-root.current_floor_normal.tangent()))


func update_rotation():
	pass

func stick_to_wall():
	pass
