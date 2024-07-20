extends State

func enter() -> void:
	print("attack")
	playback.travel("attack")
	character.velocity = Vector2(0,0) # stands still
	if !character.animation_tree.animation_finished.is_connected(attack_finished):
		character.animation_tree.animation_finished.connect(attack_finished)


func attack_finished(_animation):
	transitioned.emit("idle")
