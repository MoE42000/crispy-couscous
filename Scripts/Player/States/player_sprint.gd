extends PlayerState
class_name PlayerSprint

@export var speed_increase : float = 1.5

func enter() -> void:
	super()

func process(delta) -> void:
	super(delta)
	if character.movement.wants_jump() and character.is_on_floor():
		transitioned.emit(self,"jump")

	elif character.movement.wants_attack() and character.is_on_floor():
		transitioned.emit(self, 'attack')
	elif character.direction_input == 0:
		if character.is_on_floor():
			transitioned.emit(self, 'idle')
		else:
			transitioned.emit(self, 'fall')
	elif not character.is_on_floor():
		transitioned.emit(self, 'fall')

func process_physics(delta) -> void:
	super(delta)
	character.velocity.y += Global.GRAVITY * delta
	var movement = character.direction_input * character.speed * speed_increase
	character.velocity.x = movement

