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
		
	
	
func jump() -> void:
	#TODO: Come up with personalized Jump func
	character.velocity.y = character.jump_force

	
func process(delta) -> void:
	super(delta)
	if  character.movement.wants_end_jump():
		character.velocity.y = 0
	else:
		character.velocity.y += gravity * delta
		
	if character.movement.wants_attack():
		transitioned.emit(self,'attack')
		
	if character.velocity.y > 0:
		transitioned.emit(self, "fall") 
	
func process_physics(delta) -> void:
	super(delta)
	var movement = character.direction_input * character.speed 
	character.velocity.x = movement

	


