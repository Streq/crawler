extends CharacterState
onready var jump: Node2D = $"%jump"
onready var rope: Node2D = $"%rope"

func _enter(params):
	jump.disabled=false
	rope.disabled=false

func _physics_update(delta: float):
	pass
