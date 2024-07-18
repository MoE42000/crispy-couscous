extends PlayerState
class_name PlayerFall

func enter() -> void:
	super()
	jump_buffer_timer = 0
	coyote_timer = coyote_time
	
	
func process(delta) -> void:
	super(delta)
	if character.movement.wants_jump():
		jump_buffer_timer = jump_buffer_time
		if coyote_timer > 0:
			if previous_state.state_name == "run":
				transitioned.emit(self, 'jump')
				
	jump_buffer_timer-=delta
	coyote_timer-=delta
	
	if character.is_on_floor():
		if jump_buffer_timer > 0:
			transitioned.emit(self, "jump")
		elif character.direction_input !=0:
			transitioned.emit(self, "run")
		else:
			transitioned.emit(self, "idle")
			
	if character.facing_raycast.is_colliding() and character.direction_input != 0:
		if jump_buffer_timer > 0:
			transitioned.emit(self, "wall_jump")
		else:
			transitioned.emit(self, "slide")
	
	if character.movement.wants_attack():
		transitioned.emit(self,'attack')

	
func process_physics(delta) -> void:
	super(delta)
	character.velocity.y += Global.GRAVITY * delta
	var movement =  character.direction_input * character.speed 
	character.velocity.x = movement
