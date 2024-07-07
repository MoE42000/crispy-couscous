extends PlayerState
class_name PlayerJump

var wall_jump_pushback : float
var dir : float

func enter() -> void:
	super()
	dir = character.direction
	if character.movement.get_up_down_input() > 0:
		if !character.drop_through():
			jump()
	else:
		jump()
		
	
	
func jump():
	#TODO: Come up with personalized Jump func
	character.velocity.y = character.jump_force
	if previous_state is PlayerSlide:
		# Apply pushback in the opposite direction of the wall
		wall_jump_pushback = 200.0 # Example value, set this to your desired pushback forc e
		# Reverse direction if wall sliding
		character.velocity.x = wall_jump_pushback * -dir
	else:
		wall_jump_pushback = 0
	
	
	
func process_physics(delta):
	if  character.movement.wants_end_jump():
		character.velocity.y = 0
	else:
		character.velocity.y += gravity * delta
		
	if character.movement.wants_attack():
		transitioned.emit(self,'attack')
		
	wall_jump_pushback -= delta * wall_jump_pushback
	var movement = character.direction * character.speed
	if wall_jump_pushback > 0:
		movement += wall_jump_pushback * -dir
	character.velocity.x = movement
	
	
	if character.velocity.y > 0:
		transitioned.emit(self, "fall") 

	super(delta)
	#character.move_and_slide()

