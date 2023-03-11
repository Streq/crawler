extends Area2D


func _on_body_entered(body : Node):
	if body.is_in_group("player"):
		body.get_node("%rope").disabled = false
		queue_free()

func _ready() -> void:
	connect("body_entered",self,"_on_body_entered")
