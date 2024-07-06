extends StateMachine
class_name PlayerStateMachine

var direction : float

func _physics_process(delta) -> void:
	super(delta)
	direction = movement_component.get_movement_direction()
	
