extends AreaEffectComponent
class_name SwingerEnemyAttackArea

@export var attack_damage : int = 10

func _on_body_entered(body):
	#if !(body is Player):
	if body is Player:
		for child in body.get_children():
			if child is HitBoxComponent:
				child.damage(attack_damage)
				

func _changed_facing_direction(dir:float):
	for shape in shapes:
		if dir > 0:
			shape.position = shape.facing_right_pos
		else:
			shape.position = shape.facing_left_pos
