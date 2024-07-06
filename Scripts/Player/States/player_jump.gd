extends PlayerState
class_name PlayerJump

@export var wall_jump_pushback : float

func enter() -> void:
	super()
	
	if character.movement.get_up_down_input() > 0:
		if !character.drop_through():
			jump()
	else:
		jump()
		
	
	
func jump():
	#TODO: Come up with personalized Jump func
	character.velocity.y = character.jump_force
	if previous_state is PlayerSlide:
		character.velocity.x = wall_jump_pushback * character.direction
	
	
	
func process_physics(delta):
	if  character.movement.wants_end_jump():
		character.velocity.y = 0
	else:
		character.velocity.y += gravity * delta
		
	if character.movement.wants_attack():
		transitioned.emit(self,'attack')

	var movement = character.direction * character.speed 
	character.velocity.x = movement
	
	
	if character.velocity.y > 0:
		transitioned.emit(self, "fall") 
	

	super(delta)
	#character.move_and_slide()

