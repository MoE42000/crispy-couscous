extends AreaEffectComponent

@export var sword_damage : int = 10

func _on_body_entered(body):
	if !(body is Player):
		for child in body.get_children():
			if child is HitBoxComponent:
				child.damage(sword_damage)
				
				
func _changed_facing_direction(facing_right:bool):
	if facing_right:
		shape.position = shape.facing_right_pos
	else:
		shape.position = shape.facing_left_pos
