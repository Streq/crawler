extends KinematicBody2D
signal pre_move(delta)
signal dead()
onready var input_state: Node = $"%input_state"

export var velocity := Vector2()
export var gravity := Vector2()

export var speed := 75.0

export var current_floor_normal := Vector2()
onready var corner_handler: Node2D = $"%corner_handler"
onready var pivot: Node2D = $"%pivot"

onready var world : Node2D = get_parent()

var ground = null

export (float, -1.0, 1.0, 2.0) var facing_dir := 1.0 setget set_facing_dir
var is_in_concave_corner
func set_facing_dir(val):
	if val:
		facing_dir = sign(val)
		if pivot:
			pivot.scale.x = facing_dir
var is_on_wall = false
func _physics_process(delta: float) -> void:
	velocity += gravity*delta
	if is_on_wall:
		var dir : Vector2 = input_state.dir
		if dir.dot(current_floor_normal)>0:
			dir -= dir.project(current_floor_normal)
#		print(dir,current_floor_normal)
		
		dir.x = sign(dir.x)
		dir.y = sign(dir.y)
		velocity = speed*dir-current_floor_normal*10.0
		set_facing_dir(dir.dot(-current_floor_normal.tangent()))
		pivot.global_rotation = (-current_floor_normal.tangent()).angle()
		
		if !is_in_concave_corner and corner_handler.is_in_corner():
			corner_handler.turn_corner()
			
	emit_signal("pre_move", delta)
	
	velocity = move_and_slide(velocity)
	is_on_wall = is_on_wall()
	current_floor_normal = Vector2()
	for i in get_slide_count():
		var collision := get_slide_collision(i)
		var normal := collision.normal
#		velocity -= velocity.project(normal)*2.0
		current_floor_normal += normal
	var last_wall = world
	ground = null
	if get_slide_count():
		last_wall = get_slide_collision(get_slide_count()-1).collider
		ground = last_wall

	is_in_concave_corner = current_floor_normal.x and current_floor_normal.y
	
	if last_wall != get_parent():
		call_deferred("reparent_to_wall",last_wall)
		

func reparent_to_wall(last_wall):
	if last_wall != get_parent():
		NodeUtils.reparent_keep_transform(self,last_wall)
		

func die():
	queue_free()
	emit_signal("dead")
