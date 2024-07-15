extends PlayerState
class_name PlayerWallJump

func enter() -> void:
	super()
	character.velocity.x = character.direction * -230
	character.velocity.y = character.jump_force / 1.5


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
	#character.move_and_slide()
