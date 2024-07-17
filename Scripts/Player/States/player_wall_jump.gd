extends PlayerState
class_name PlayerWallJump

@export var horizontal_force:int = -160
var no_reverse_jump:bool

func enter() -> void:
	super()
	no_reverse_jump = character.raycast.is_colliding()
	if !no_reverse_jump:
		character.flip_sprite()
	character.velocity.y = character.jump_force / 1.3

func exit() -> void:
	character.flip_sprite()
	
	
func process_physics(delta):
		
	character.velocity.x =  horizontal_force * character.facing_direction if no_reverse_jump else horizontal_force * -character.facing_direction
	if  character.movement.wants_end_jump():
		character.velocity.y = 0
	else:
		character.velocity.y += gravity * delta
		
	if character.movement.wants_attack():
		transitioned.emit(self,'attack')
	
	if character.velocity.y > 0:
		transitioned.emit(self, "fall") 
	

	super(delta)
