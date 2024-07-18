extends AreaEffectComponent

@export var sword_damage : int = 10

func _on_body_entered(body):
	if !(body is Player):
		Global.player.sword_hit_something.emit()
		for child in body.get_children():
			
			if child is HitBoxComponent:
				
				child.damage(sword_damage)
	
				
func _changed_facing_direction(dir:float):
	if dir > 0:
		shape.position = shape.facing_right_pos
	else:
		shape.position = shape.facing_left_pos
