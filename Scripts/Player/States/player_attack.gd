extends PlayerState
class_name PlayerAttack


func enter():
	super()
	if !character.sword_hit_something.is_connected(_recoil):
		character.sword_hit_something.connect(_recoil)
	attack_buffer_timer = 0
	if !character.animation_tree.animation_finished.is_connected(attack_finished):
		character.animation_tree.animation_finished.connect(attack_finished)
	
func process(delta) -> void:
	super(delta)
	if character.movement.wants_jump():
		if character.is_on_floor():
			transitioned.emit(self,"jump")
		elif character.can_double_jump and !(previous_state.state_name in ["double_jump", "wall_jump"]): # check if can double jump
			transitioned.emit(self,"double_jump")
		
	if character.movement.wants_attack():
		attack_buffer_timer = attack_buffer_time
		
	attack_buffer_timer -= delta
	
	
func process_physics(delta) -> void:
	super(delta)
	var movement =  character.direction_input * (character.speed + character.sprint_speed)
	character.velocity.x = movement
	
	if !character.is_on_floor():
		character.velocity.y += Global.GRAVITY * delta


func attack_finished(animation_finished) -> void:
	if (animation_finished == "attack"):
		if attack_buffer_timer > 0:
			transitioned.emit(self,"attack")
		elif character.is_on_floor():
			if character.direction_input != 0:
				transitioned.emit(self, "run")
			else:
				transitioned.emit(self, "idle")
		else:
			transitioned.emit(self,"fall")
			character.sprite.offset.x = 0
			
func _recoil():
	await get_tree().create_timer(.05).timeout
	transitioned.emit(self,"recoil")
