extends PlayerState
class_name PlayerRun

func enter() -> void:
	super()

func process(delta):
	super(delta)
	if character.movement.wants_jump() and character.is_on_floor():
		transitioned.emit(self,"jump")
		#if !(character.movement.get_up_down_input() > 0):
			#	transitioned.emit(self, 'jump')
		#else:
			#character.drop_through()
			#transitioned.emit(self, 'fall')
	elif character.movement.wants_attack() and character.is_on_floor():
		transitioned.emit(self, 'attack')
	elif character.direction == 0:
		if character.is_on_floor():
			transitioned.emit(self, 'idle')
		else:
			transitioned.emit(self, 'fall')
	elif not character.is_on_floor():
		transitioned.emit(self, 'fall')

func process_physics(delta):
	
	character.velocity.y += gravity * delta
	var movement = character.direction * character.speed
	character.velocity.x = movement
	
	super(delta)
	#character.move_and_slide()
