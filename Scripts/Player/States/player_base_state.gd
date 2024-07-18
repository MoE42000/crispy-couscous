class_name PlayerState
extends State

@export var animation_name : String

var attack_buffer_time:float = .08
var attack_buffer_timer: float

func enter() -> void:
	if playback.get_current_node() != animation_name:
		playback.travel(animation_name)
	else:
		playback.start(animation_name)

func exit() -> void:
	pass

func process(_delta:float) -> void:
	pass
	
func process_physics(_delta:float) -> void:
	if !(playback.get_current_node() in ["attack","wall_slide","wall_jump"]):
		character.handle_flipping(character.direction_input)

	character.move_and_slide()
