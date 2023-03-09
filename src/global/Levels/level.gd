extends Node

export var scene : PackedScene


func _ready() -> void:
	if !scene:
		scene = load("res://src/levels/"+name+".tscn")
