extends Node2D
onready var cooldown: Timer = $cooldown
export var BULLET : PackedScene
onready var sight: Node2D = $sight

onready var alarmed_time: Timer = $alarmed_time
onready var light_2d: Light2D = $sight/Light2D


func _physics_process(delta: float) -> void:
	var target = Group.get_one("player")
	if !target:
		return
	var target_pos : Vector2 = target.global_position 
	
	
	if sight.can_see(target_pos):
		owner.global_rotation = target_pos.angle_to_point(global_position)
		light_2d.color = Color.red
		light_2d.energy = 16
		if cooldown.is_stopped():
			cooldown.start()
			yield(cooldown,"timeout")
			shoot()
		

func shoot():
	get_tree().reload_current_scene()
