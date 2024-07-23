extends PlayerState
class_name PlayerDoubleJump


@export var double_jump_force : float = 300

func enter() -> void:
	super()
	character.velocity.y = -double_jump_force
	character.can_double_jump = false

	
func process(delta) -> void:
	super(delta)
		
	if character.movement.wants_attack():
		transitioned.emit(self,'attack')
		
	if character.velocity.y > 0:
		transitioned.emit(self, "fall") 
	
func process_physics(delta) -> void:
	super(delta)
	#if  #character.movement.wants_end_jump():
		#character.velocity.y = 0
	#else:
	character.velocity.y += Global.GRAVITY * delta
		
	var movement = character.direction_input * (character.speed + character.sprint_speed)
	character.velocity.x = movement

	
