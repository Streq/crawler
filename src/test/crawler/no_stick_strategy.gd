extends State
func premove(delta):
#	root.velocity -= root.current_floor_normal*100.0
	root.velocity += root.gravity*delta
	
	pass
func move(delta):
	root.velocity = root.move_and_slide(root.velocity,Vector2.UP)
func postmove(delta):
	var r = root
	r.current_floor_normal = Vector2.UP
	r.fix_rotation_to_ground()
	
	r.is_on_wall = r.is_on_floor()
	
	var last_wall = r.world
	r.ground = null
	if r.get_slide_count():
		var collision = r.get_slide_collision(r.get_slide_count()-1)
		print(collision.normal)
		if collision.normal == Vector2.UP:
			last_wall = collision.collider
			r.ground = last_wall

	if last_wall != r.get_parent():
		r.call_deferred("reparent_to_wall",last_wall)


func stick():
	goto("stick")
func no_stick():
	return

func get_walk():
	return "walk"

func get_idle():
	return "idle"


func is_stick():
	return false
