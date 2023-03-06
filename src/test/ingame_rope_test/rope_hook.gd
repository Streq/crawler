extends Node2D


export var dude_path : NodePath

export var max_length := 100.0
var length := 100.0

onready var dude : KinematicBody2D = get_node(dude_path) if dude_path else null

export var disabled := false
onready var ray: RayCast2D = $RayCast2D

var landed := false

var pulling := false
var straighten := false
var target_pos := Vector2()
var cut := false


var hooked_on = null

func _ready() -> void:
	ray.add_exception(dude)

func _physics_process(delta: float) -> void:
	disabled = !Input.is_action_pressed("B") or !landed or cut #or dude.is_on_wall()
	pulling = false

	if disabled:
		return
	var pullable = hooked_on.is_in_group("pullable")
		
	if pullable:
		global_position = hooked_on.global_position
	
	
	var d : KinematicBody2D = dude
	var dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	target_pos = d.global_position + 3.0*dir.rotated(PI/2.0+d.global_position.angle_to_point(global_position))
	var dist = target_pos - global_position
	var dist_length = dist.length()
	
	
	if dist_length>=length and !is_zero_approx(length):
		
		if !hooked_on.is_in_group("pullable"):
		
			if d.velocity.dot(dist)>0.0:
				d.velocity -= d.velocity.project(dist)
			
			
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
#			if !hooked_on.test_move(hooked_on.global_transform,movement_delta):
			hooked_on.move_and_collide(movement_delta)
#			else:
#				cut = true
#				print("cut")
			pulling = true
			
			hooked_on.velocity += dist.normalized()*1000.0*delta
	pass
	
	if Input.is_action_pressed("C"):
		length = max(0,dude.global_position.distance_to(global_position)-max_length*delta)
		if pullable:
			hooked_on.velocity -= 1000.0*delta*dude.global_position.direction_to(self.global_position)
		else:
			dude.velocity += 1000.0*delta*dude.global_position.direction_to(self.global_position)
		
	update()
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("B"):
		cut = false
		var dist : Vector2 = dude.get_local_mouse_position().normalized()*max_length
		ray.cast_to = dist
		ray.global_position = dude.global_position
		ray.force_raycast_update()
		
		landed = ray.is_colliding()
		if landed:
			hooked_on = ray.get_collider()
			global_position = ray.get_collision_point()
		length = dude.global_position.distance_to(global_position)

func _draw() -> void:
	if !disabled:
		draw_line(Vector2(),to_local(target_pos),Color.aquamarine)
