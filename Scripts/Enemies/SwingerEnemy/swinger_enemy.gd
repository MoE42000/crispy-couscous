extends BaseEnemy
class_name SwingerEnemy

@onready var edge_checking_raycast := $EdgeChecker

func flip_sprite():
	super()
	if facing_direction < 0:
		edge_checking_raycast.target_position = edge_checking_raycast.facing_left_pos
		sprite.offset.x = 0
	else:
		edge_checking_raycast.target_position = edge_checking_raycast.facing_right_pos
		sprite.offset.x = 20
