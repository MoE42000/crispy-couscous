extends PlayerState
class_name PlayerWallJump

func enter() -> void:
	super()
	var horizontal_force = -160
	character.velocity.x = character.direction * horizontal_force if character.raycast.is_colliding() else -character.direction * horizontal_force
	character.velocity.y = character.jump_force / 1.3
	
	if previous_state.state_name == "fall":
		character.sprite.flip_h = !character.sprite.flip_h

func process_physics(delta):
	if  character.movement.wants_end_jump():
		character.velocity.y = 0
	else:
		character.velocity.y += gravity * delta
		
	if character.movement.wants_attack():
		transitioned.emit(self,'attack')

	#var movement = character.direction * character.speed 
	#character.velocity.x = movement
	
	
	if character.velocity.y > 0:
		transitioned.emit(self, "fall") 
	

	super(delta)
