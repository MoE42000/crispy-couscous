extends State

var dir : int

func enter() -> void :
	dir = 1 if (character.position.x - Global.player.position.x) < 0 else -1
	
	
func process(_delta):
	if character.is_on_wall() or character.position.distance_to(Global.player.position) > 160:
		transitioned.emit(self,"idle")

func process_physics(delta):
	character.move_and_slide()
	character.velocity.x = 80 * dir
	character.velocity.y += Global.GRAVITY * delta
