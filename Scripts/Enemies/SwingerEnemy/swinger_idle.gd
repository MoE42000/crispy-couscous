extends State

func enter() -> void:
	change_animation()
	character.velocity = Vector2(0,0) # stands still
	await get_tree().create_timer(randf_range(.2,3)).timeout
	transitioned.emit(self,"wander")
		
func process(_delta) -> void:
	# chekc if player is in line of sight
	if abs(character.position.direction_to(Global.player.position).y) < .2 and character.position.distance_to(Global.player.position) < 80:
		#transitioned.emit(self,"alert")
		pass

func process_physics(delta):
	# Apply gravity
	character.velocity.y += Global.GRAVITY * delta
	character.move_and_slide()
