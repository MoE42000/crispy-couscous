extends State

func enter() -> void:
	change_animation(animation_name)
	character.velocity = Vector2(0,0) # stands still
	
func process(_delta) -> void:
	# chekc if player is in line of sight
	if abs(character.position.direction_to(Global.player.position).y) < .2 and character.position.distance_to(Global.player.position) < character.detection_distance:
		transitioned.emit(self,"alert")
	
	
func process_physics(delta) -> void:
	
	character.move_and_slide()
	character.velocity.y += Global.GRAVITY * delta
	
