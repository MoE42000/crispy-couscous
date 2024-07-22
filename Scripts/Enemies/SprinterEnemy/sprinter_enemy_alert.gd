extends State

@export
var start_pursue_time := .7
var start_pursue_timer :float

func enter() -> void:
	change_animation(animation_name)
	start_pursue_timer = start_pursue_time
	
func process(delta) -> void:
	start_pursue_timer -= delta
	if start_pursue_timer < 0:
		transitioned.emit(self, "pursue")
	


