extends Area2D


func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
	connect("body_entered",self,"_on_area_entered")


func _on_area_entered(area):
	if area.is_in_group("player"):
		get_tree().reload_current_scene()
	else:
		area.queue_free()

func get_hit(bullet):
	bullet.queue_free()
