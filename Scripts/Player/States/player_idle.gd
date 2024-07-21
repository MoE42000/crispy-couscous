extends PlayerState
class_name PlayerIdle

@export var friction : float = 25

func enter() -> void:
	super()
	
	
func process(delta) -> void:
	super(delta)
	if character.movement.wants_jump() and character.is_on_floor():
		if character.movement.get_up_down_input() > 0:
			if !character.drop_through():
				transitioned.emit(self,'jump')

		else:
			transitioned.emit(self, 'jump')
	if  character.direction_input:
		transitioned.emit(self, 'run')
	if character.movement.wants_attack():
		transitioned.emit(self,'attack')
	
func process_physics(delta) -> void:
	super(delta)
	if !character.is_on_floor():
		transitioned.emit(self,"fall")
	character.velocity.y += Global.GRAVITY * delta
	character.velocity = character.velocity.move_toward(Vector2.ZERO, friction)

