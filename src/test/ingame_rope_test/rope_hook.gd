extends Skill


export var dude_path : NodePath

export var max_length := 100.0
var length := 100.0

onready var dude : KinematicBody2D = get_node(dude_path) if dude_path else null



export var active := false
onready var ray: RayCast2D = $RayCast2D

var landed := false

var pulling := false
var straighten := false
var target_pos := Vector2()
var cut := false


var hooked_on = null
var hooked_on_point = Vector2()

onready var hooked_from = get_parent()
var hooked_from_point = Vector2()

	
func _ready() -> void:
	ray.add_exception(dude)

func _physics_process(delta: float) -> void:
	if !is_available():
		return
	active = !Input.is_action_pressed("B") or !landed or cut or !is_instance_valid(hooked_on)#or dude.is_on_wall()
	pulling = false
	update()
	if active:
		return
		
	var pullable = hooked_on.is_in_group("pullable")
		
#	if pullable:
#		global_position = hooked_on.to_global(hooked_on_point)
	
	
	var d : KinematicBody2D = dude
	var dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	hooked_from_point = dir.rotated(PI/2.0+get_hooked_from_global_position().angle_to_point(get_hooked_to_global_position()))*3.0
	
	var dist = get_hooked_from_global_position() - get_hooked_to_global_position()
	var dist_length = dist.length()
	
	
	if dist_length>=length and !is_zero_approx(length):
		
		if !hooked_on.is_in_group("pullable"):
		
			if d.velocity.dot(dist)>0.0:
				d.velocity -= d.velocity.project(dist)*1.1
				
			
			
			var movement_delta = dist*(1.0 - dist_length/length)
			if !d.test_move(d.global_transform,movement_delta):
				d.move_and_collide(movement_delta)
			else:
				cut = true
				print("cut")
			pulling = true
		else:
			
			
			if hooked_on.velocity.dot(dist)<0.0:
				hooked_on.velocity -= hooked_on.velocity.project(dist)
			
			var movement_delta = -dist*(1.0 - dist_length/length)
			if hooked_on.test_move(hooked_on.global_transform,movement_delta):
				if get_actual_length()>length+20.0:
					cut = true

#				hooked_on.move_and_collide(movement_delta)
#				pass
#			else:
#				cut = true
#				print("cut")
			pulling = true
			hooked_on.velocity += dist.normalized()*1000.0*delta
	pass
	
	if Input.is_action_pressed("C"):
		length = max(4.0,get_actual_length()-max_length*delta)
		if length>4.0:
			if pullable:
				hooked_on.velocity += 1000.0*delta*get_pull_direction()
			else:
				dude.velocity -= 1000.0*delta*get_pull_direction()
		

func _input(event: InputEvent) -> void:
	if !is_available():
		return
	if event.is_action_pressed("B"):
		cut = false
		var dist : Vector2 = dude.get_local_mouse_position().normalized()*max_length
		ray.cast_to = dist
		ray.global_position = get_hooked_from_global_position()
		ray.force_raycast_update()
		
		landed = ray.is_colliding() and !"no_grab" in ray.get_collider()
		if landed:
			hooked_on = ray.get_collider()
			hooked_on_point = hooked_on.to_local(ray.get_collision_point())
#			global_position = ray.get_collision_point()
			length = get_actual_length()

func _draw() -> void:
	if !active and is_instance_valid(hooked_on):
		draw_line(to_local(get_hooked_from_global_position()),to_local(get_hooked_to_global_position()),Color.aquamarine)


func get_actual_length():
	if !hooked_on:
		return 0.0
	return get_hooked_from_global_position().distance_to(get_hooked_to_global_position())


func get_hooked_from_global_position():
	return hooked_from.to_global(hooked_from_point)
func get_hooked_to_global_position():
	return hooked_on.to_global(hooked_on_point)

func get_pull_direction():
	return get_hooked_to_global_position().direction_to(get_hooked_from_global_position())

