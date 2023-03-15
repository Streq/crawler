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
func premove(delta):
	if root.current_floor_normal and root.is_on_wall:
		root.velocity -= root.current_floor_normal*100.0
	else:
		root.velocity += root.gravity*delta
	
func move(delta):
	root.velocity = root.move_and_slide(root.velocity)
func postmove(delta):
	var r = root
	r.update_floor_normal()
	r.fix_rotation_to_ground()
	
	r.is_on_wall = r.is_on_wall()
	if r.is_on_wall and !r.is_in_concave_corner and r.corner_handler.is_in_corner():
		r.corner_handler.turn_corner()
		r.update_floor_normal()
		r.fix_rotation_to_ground()
	
	var last_wall = r.world
	r.ground = null
	if r.get_slide_count():
		last_wall = r.get_slide_collision(r.get_slide_count()-1).collider
		r.ground = last_wall

	r.is_in_concave_corner = r.current_floor_normal.x and r.current_floor_normal.y
	if last_wall != r.get_parent():
		r.call_deferred("reparent_to_wall",last_wall)


func stick():
	return
func no_stick():
	goto("no_stick")

func get_walk():
	return "crawl_walk"

func get_idle():
	return "crawl_idle"

func is_stick():
	return true
