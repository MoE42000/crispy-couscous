extends AreaEffectComponent

func _changed_facing_direction(dir:float):
	if dir > 0:
		shape.position = shape.facing_right_pos
	else:
		shape.position = shape.facing_left_pos
