extends PlayerState
class_name PlayerSlide

@export var wall_slide_gravity : float = 180
@export var fall_delay:float=.2
var fall_timer:Timer

func enter() -> void:
	super() 
		
func process(delta) -> void:
	super(delta)
	if character.is_on_floor():
		if character.direction_input != 0:
			transitioned.emit(self, "run")
		else:
			transitioned.emit(self, "idle")
			
	elif !character.facing_raycast.is_colliding() or character.direction_input == 0:
		transitioned.emit(self, "fall")
		
	elif character.movement.wants_jump():
		transitioned.emit(self, "wall_jump")

func process_physics(delta) -> void:
	super(delta)
	character.velocity.y += wall_slide_gravity * delta
	character.velocity.y = min(character.velocity.y,wall_slide_gravity)
	
	

