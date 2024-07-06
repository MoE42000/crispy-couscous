extends PlayerState
class_name PlayerSlide

@export var wall_slide_gravity : float

func enter() -> void:
	pass # Replace with function body.

func exit() -> void:
	pass

func process_physics(delta) -> void:
	
	if character.is_on_floor():
		if character.direction != 0:
			transitioned.emit(self, "run")
		else:
			transitioned.emit(self, "idle")
			
	elif !character.raycast.is_colliding() or character.direction == 0:
		
		transitioned.emit(self, "fall")
		
	elif character.movement.wants_jump():
		transitioned.emit(self, "jump")
	
	character.velocity.y += wall_slide_gravity * delta
	character.velocity.y = min(character.velocity.y,wall_slide_gravity)
	super(delta)
	
	
