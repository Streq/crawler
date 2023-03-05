extends KinematicBody2D
signal in_water()
signal out_of_water()
signal in_air()
signal out_of_air()
signal dead()
signal revived()
signal dying()

signal premove
signal postmove

onready var animation_player: AnimationPlayer = $animation_player
onready var state_machine: Node = $state_machine
onready var pivot: Node2D = $pivot
onready var input_state: Node = $input_state

export var velocity := Vector2()

export var speed = 75.0

export var jump_speed = 100.0

export var gravity = Vector2()
#export var water_gravity := -30.0
#export var air_gravity := 100.0

export var damping := 0.0
export var water_damping := 1.0
export var air_damping := 0.0

export var max_fall_speed := 100.0

var previous_velocity := Vector2()

export var horizontal_acceleration := 500.0
export var horizontal_air_acceleration := 200.0
export var horizontal_decceleration := 500.0
export var horizontal_air_decceleration := 10.0
export var swim_speed := 30.0
export var swim_acceleration := 300.0

export var team := 0

export (float, -1.0, 1.0, 2.0) var facing_dir := 1.0 setget set_facing_dir


var in_water := false setget set_in_water
var in_air := false setget set_in_air

var dead = false

func set_in_water(val):
	if val == in_water:
		return
	in_water = val
	if in_water:
		emit_signal("in_water")
	else:
		emit_signal("out_of_water")
func set_in_air(val):
	if val == in_air:
		return
	in_air = val
	if in_water:
		emit_signal("in_air")
	else:
		emit_signal("out_of_air")


func set_facing_dir(val):
	val = sign(val)
	if val == 0.0 or facing_dir == val:
		return
	facing_dir = val

	if !is_inside_tree():
		return
	pivot.scale.x = abs(pivot.scale.x)*facing_dir

func _ready() -> void:
	state_machine.initialize()

func _physics_process(delta: float) -> void:
	previous_velocity = velocity
	emit_signal("premove")
	velocity = move_and_slide(velocity)
	emit_signal("postmove")
	
#	var _gravity = water_gravity if in_water else air_gravity if in_air else gravity
	
	velocity += gravity*delta
#	var _damping = water_damping if in_water else air_damping if in_air else damping
	velocity *= 1-delta*damping
	
	state_machine.physics_update(delta)
	animation_player.advance(delta)
	
	if dead:
		die()

func die():
	if state_machine.current.is_dead_state:
		return
	dead = true
	state_machine._change_state("air_dead")
	emit_signal("dying")
	emit_signal("dead")

func revive():
	dead = false
	emit_signal("revived")
	state_machine._change_state("idle")
