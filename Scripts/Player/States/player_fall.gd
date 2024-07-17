extends PlayerState
class_name PlayerFall

func enter() -> void:
	super()
	jump_buffer_timer = 0
	coyote_timer = 2#coyote_time
	
	
func process(delta):
	super(delta)
	
func process_physics(delta) -> void:
	
	if character.movement.wants_jump():
		jump_buffer_timer = jump_buffer_time
		if coyote_timer > 0:
			if previous_state.state_name == "run":
				transitioned.emit(self, 'jump')
			if previous_state.state_name == "slide":
				transitioned.emit(self,'wall_jump')
			
	jump_buffer_timer-=delta
	coyote_timer-=delta
	
	if character.is_on_floor():
		if jump_buffer_timer > 0:
			transitioned.emit(self, "jump")
		elif character.direction_input !=0:
			transitioned.emit(self, "run")
		else:
			transitioned.emit(self, "idle")
	
	if character.raycast.is_colliding() and character.direction_input != 0:
		transitioned.emit(self, "slide")
	
	if character.movement.wants_attack():
		transitioned.emit(self,'attack')
			
	character.velocity.y += gravity * delta
	var movement =  character.direction_input * character.speed 
	character.velocity.x = movement
	
	super(delta)
	#character.move_and_slide()
	
