extends Area2D


func _on_body_entered(body:Node2D):
	if body.is_in_group("player"):
		LevelCircuit.next_level()

func _ready() -> void:
	connect("body_entered",self,"_on_body_entered")
