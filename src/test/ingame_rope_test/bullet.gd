extends Area2D

export var velocity := Vector2()

func _ready() -> void:
	connect("area_entered",self,"area_entered")
	connect("body_entered",self,"body_entered")


func area_entered(area):
	area.get_hit(self)
	pass

func body_entered(body):
	queue_free()
	pass

func _physics_process(delta: float) -> void:
	global_position+=velocity*delta
