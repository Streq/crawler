extends State
class_name CharacterState

export var animation := ""
export var change_on_animation_finish := true
export var on_finish_goto_state := ""

export var is_dead_state := false

onready var input : InputState = owner.get_node("%input_state")
onready var animation_player : AnimationPlayer = owner.get_node("%animation_player")

func enter(params):
	if(name == "concave_corner"):
		breakpoint
	animation_player.play("RESET")
	animation_player.advance(0.0)
	animation_player.play(animation)
	animation_player.advance(0.0)
	animation_player.connect("animation_finished", self, "_on_animation_finished")
	.enter(params)

func exit():
	animation_player.disconnect("animation_finished", self, "_on_animation_finished")
	.exit()


func _on_animation_finished(name):
	if change_on_animation_finish and on_finish_goto_state:
		goto(on_finish_goto_state)
