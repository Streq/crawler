extends CharacterState
onready var jump: Node2D = $"%jump"
onready var rope: Node2D = $"%rope"

func _enter(params):
	jump.disabled=false
	rope.disabled=false

func _physics_update(delta: float):
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
		
		
