extends State

func enter() -> void:
	character.velocity = Vector2(0,0) # stands still
	
func process(delta) -> void:
	# chekc if player is in line of sight
	if abs(character.position.direction_to(Global.player.position).y) < .2 and character.position.distance_to(Global.player.position) < 80:
		transitioned.emit(self,"alert")
	
	
func process_physics(delta) -> void:
	character.move_and_slide()
	character.velocity.y += Global.GRAVITY * delta
	
