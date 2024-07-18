extends PlayerState
class_name PlayerAttack

# Called when the node enters the scene tree for the first time.
func enter():
	super()
	attack_buffer_timer = 0
	if !character.animation_tree.animation_finished.is_connected(attack_finished):
		character.animation_tree.animation_finished.connect(attack_finished)
	
func process(delta) -> void:
	super(delta)
	if character.movement.wants_jump() and character.is_on_floor():
		transitioned.emit(self,"jump")
	if character.movement.wants_attack():
		attack_buffer_timer = attack_buffer_time
		
	attack_buffer_timer -= delta
	
	
	
func process_physics(delta) -> void:
	super(delta)
	var movement =  character.direction_input * character.speed 
	character.velocity.x = movement
	
	if !character.is_on_floor():
		character.velocity.y += gravity * delta


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
