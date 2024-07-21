extends State

var start_pursue_time := .7
var start_pursue_timer :float

func enter() -> void:
	start_pursue_timer = start_pursue_time
	character.sprite.modulate = Color("red") # SOME VISUAL EFFECT

func exit() -> void:
	character.sprite.modulate = Color(1,1,1)
	
func process(delta) -> void:
	start_pursue_timer -= delta
	if start_pursue_timer < 0:
		transitioned.emit(self, "pursue")
	


