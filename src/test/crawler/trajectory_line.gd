extends Line2D


func _process(delta: float) -> void:
	var parent = get_parent()
	if !("points" in parent) or !parent.points:
		return
	for i in min(points.size(),parent.points.size()):
#		print(points)
#		print(get_parent().points)
		if parent.points[i] is Vector2:
			points[i] = parent.points[i]
