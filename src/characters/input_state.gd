extends Node
class_name InputState

var A := ButtonState.new()
var B := ButtonState.new()
var C := ButtonState.new()
var D := ButtonState.new()
var dir := Vector2() setget set_dir
var aim_dir := Vector2() setget set_aim_dir
var aim_dist := 1.0


func set_dir(val:Vector2):
	dir = val.limit_length()
	
func set_aim_dir(val:Vector2):
	aim_dir = val.limit_length()

func _physics_process(delta: float) -> void:
	A.stale()
	B.stale()
	C.stale()
	D.stale()

func clear():
	A.stale()
	B.stale()
	C.stale()
	D.stale()
	dir = Vector2()
	aim_dir = Vector2()
