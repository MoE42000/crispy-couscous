extends PlayerState
class_name PlayerWallJump

@export var horizontal_force:int = 170
@export var vertical_force = 180

func enter() -> void:
	super()
	character.velocity.y = -vertical_force


func exit() -> void:
	character.flip_sprite()
	
func process(delta) -> void:
	super(delta)
	if character.movement.wants_attack():
		transitioned.emit(self,'attack')
	
	if character.velocity.y > 0:
		transitioned.emit(self, "fall") 
	
	
func process_physics(delta)-> void:
	super(delta)
	character.velocity.x =  -horizontal_force * character.facing_direction 
	if  character.movement.wants_end_jump():
		character.velocity.y = 0
	else:
		character.velocity.y += Global.GRAVITY * delta
