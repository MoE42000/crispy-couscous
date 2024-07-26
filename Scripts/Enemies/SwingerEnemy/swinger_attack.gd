extends State

func enter() -> void:
	
	character.handle_flipping(character.position.direction_to(Global.player.position).x)
		
	character.velocity = Vector2(0,0) # stands still
	var animation_tree = get_parent().animation_tree
	if !animation_tree.animation_finished.is_connected(attack_finished):
		animation_tree.animation_finished.connect(attack_finished)
	#await get_tree().create_timer(.1).timeout
	change_animation(animation_name)


func attack_finished(_animation):
	transitioned.emit(self,"idle")
