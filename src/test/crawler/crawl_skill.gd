extends Skill

export var active := false
func _physics_process(delta: float) -> void:
	active = true
	if active:
		owner.move_strategy.current.stick()
	else:
		owner.move_strategy.current.no_stick()
