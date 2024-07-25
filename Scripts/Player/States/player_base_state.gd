class_name PlayerState
extends State

var attack_buffer_time:float = .08
var attack_buffer_timer: float

func enter() -> void:
	#if previous_state:
		#print(previous_state.state_name, " -> ", state_name)
	change_animation(animation_name)

func exit() -> void:
	pass

func process(_delta:float) -> void:
	pass
	
func process_physics(_delta:float) -> void:
	if !(playback.get_current_node() in ["attack","up_attack","wall_slide","wall_jump"]):
		character.handle_flipping(character.direction_input)
	
	if !character.is_on_floor() and character.movement.wants_jump() and character.current_ability == "double_jump":
		transitioned.emit(self,"double_jump")
		
	if character.movement.wants_ability():
		
		match character.current_ability:
			"sprint":
				character.sprint_speed = character.sprint_speed_val
			"double_jump":
				transitioned.emit(self,"double_jump")
			"up_attack":
				if state_name != "up_attack":
					transitioned.emit(self,"up_attack")
			_:
				pass
		character.current_ability = ""
	character.move_and_slide()
