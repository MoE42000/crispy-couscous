extends State

func enter() -> void:
	change_animation()
	character.velocity = Vector2(0,0) # stands still
	var animation_tree = get_parent().animation_tree
	if !animation_tree.animation_finished.is_connected(attack_finished):
		animation_tree.animation_finished.connect(attack_finished)


func attack_finished(_animation):
	transitioned.emit("idle")
