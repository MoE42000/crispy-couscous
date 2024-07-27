extends State


var dir : int

func enter() -> void :
	change_animation(animation_name)
	dir = 1 if (character.position.x - Global.player.position.x) < 0 else -1
	
	
func process(_delta):
	if character.position.distance_to(Global.player.position) < 50 and round(character.position.direction_to(Global.player.position).x) == dir:
		playback.travel("run_attack")
	else:
		playback.travel("run")
	
	if character.is_on_wall() or character.position.distance_to(Global.player.position) > 160:
		transitioned.emit(self,"idle")

func process_physics(delta):
	character.move_and_slide()
	character.velocity.x = character.speed * dir
	character.velocity.y += Global.GRAVITY * delta
