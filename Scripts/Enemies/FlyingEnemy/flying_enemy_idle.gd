extends State



func enter() -> void:
	character.velocity = Vector2(0,0) # stands still
		
func process(_delta) -> void:
	# chekc if player is in line of sight
	if abs(character.position.direction_to(Global.player.position).y) < .2 and character.position.distance_to(Global.player.position) < 35:
		transitioned.emit(self,"attack")

func process_physics(delta):
	character.move_and_slide()
