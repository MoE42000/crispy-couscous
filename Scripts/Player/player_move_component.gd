extends MovementComponent

func get_movement_direction() -> float:
	return Input.get_axis('Left', 'Right')

# Return a boolean indicating if the character wants to jump
func wants_jump() -> bool:
	return Input.is_action_just_pressed('Jump')
	
func get_up_down_input() -> float:
	return Input.get_axis("Up", "Down")
	
func wants_end_jump() -> bool:
	return Input.is_action_just_released('Jump')
	
func wants_attack() -> bool:
	return Input.is_action_just_pressed('Attack')
	
func wants_dash() -> bool:
	return false
