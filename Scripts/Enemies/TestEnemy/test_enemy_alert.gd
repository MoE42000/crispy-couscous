extends State

var start_pursue_timer :float = .7

func enter() -> void:
	character.modulate = Color("red") # SOME VISUAL EFFECT

func exit() -> void:
	character.modulate = Color(1,1,1)
	
func process(delta) -> void:
	start_pursue_timer -= delta
	if start_pursue_timer < 0:
		transitioned.emit(self, "pursue")
	


