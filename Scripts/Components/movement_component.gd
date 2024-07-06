extends Node
class_name MovementComponent

func get_movement_direction() -> float:
	return 0

# Return a boolean indicating if the character wants to jump
func wants_jump() -> bool:
	return false
	
func wants_attack() -> bool:
	return false
	
func wants_dash() -> bool:
	return false
