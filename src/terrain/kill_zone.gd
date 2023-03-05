extends Area2D


func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
	connect("body_entered",self,"_on_area_entered")


func _on_area_entered(area):
	get_tree().reload_current_scene()
