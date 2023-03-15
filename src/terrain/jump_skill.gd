extends Area2D


func _on_body_entered(body : Node):
	if body.is_in_group("player"):
		var jump = body.get_node("%jump")
		jump.unlocked = true
		jump.speed = 200.0
		queue_free()

func _ready() -> void:
	connect("body_entered",self,"_on_body_entered")
