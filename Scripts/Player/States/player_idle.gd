extends PlayerState
class_name PlayerIdle

func enter() -> void:
	super()
	character.velocity = Vector2(0,0) # stands still
	
func process(delta) -> void:
	super(delta)
	if character.movement.wants_jump() and character.is_on_floor():
		if character.movement.get_up_down_input() > 0:
			if !character.drop_through():
				transitioned.emit(self,'jump')

		else:
			transitioned.emit(self, 'jump')
	if  character.direction:
		transitioned.emit(self, 'run')
	if character.movement.wants_attack():
		transitioned.emit(self,'attack')
	
func process_physics(delta):
	
	if !character.is_on_floor():
		transitioned.emit(self,"fall")
	character.velocity.y += gravity * delta
	
	super(delta)
	#character.move_and_slide()
	
