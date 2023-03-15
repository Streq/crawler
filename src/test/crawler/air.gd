extends CharacterState
onready var jump: Node2D = $"%jump"
onready var rope: Node2D = $"%rope"

func _enter(params):
	jump.disabled=false
	rope.disabled=false

func _physics_update(delta: float):
	if root.is_on_wall:
		goto("crawl_idle")
		return
	root.pivot.global_rotation = 0
	root.set_facing_dir(root.velocity.x)
