extends AreaEffectComponent
class_name PlayerSwordArea

@export var sword_damage : int = 10
var hit_particles = preload("res://Scenes/Juice/hit_particles.tscn")

func _on_body_entered(body):
	
	if body != get_parent():
		
		for child in body.get_children():
			
			if child is HitBoxComponent:
				var instance = hit_particles.instantiate()
				add_child(instance)
				instance.global_position = child.global_position
				child.damage(sword_damage)
				Global.player.sword_hit_something.emit()
	
				
func _changed_facing_direction(dir:float):
	for shape in shapes:
		if dir > 0:
			shape.position = shape.facing_right_pos
		else:
			shape.position = shape.facing_left_pos
