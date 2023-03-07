extends Node2D
onready var cooldown: Timer = $cooldown
export var BULLET : PackedScene
onready var sight: Node2D = $sight

onready var alarmed_time: Timer = $alarmed_time


func _physics_process(delta: float) -> void:
	var target = Group.get_one("player")
	if !target:
		return
	var target_pos : Vector2 = target.global_position 
	
	
	if sight.can_see(target_pos):
		if alarmed_time.is_stopped():
			cooldown.start()
		alarmed_time.start()
		global_rotation = target_pos.angle_to_point(global_position)
		if cooldown.is_stopped():
			shoot()
			cooldown.start()


func shoot():
	var bullet = BULLET.instance()
	owner.get_parent().add_child(bullet)
	bullet.global_transform = global_transform
	bullet.velocity = Vector2.RIGHT.rotated(global_rotation)*200.0
