extends PlayerState
class_name PlayerFall

var jump_buffer_time:float = .1
var coyote_time:float = .05

var jump_buffer_timer :float
var coyote_timer :float


func enter() -> void:
	super()
	character.falling.emit()
	jump_buffer_timer = 0
	coyote_timer = coyote_time
	
	
func process(delta) -> void:
	super(delta)
	if character.movement.wants_jump():
		if character.can_double_jump: #and !(previous_state.state_name in ["double_jump", "wall_jump"]): # check if can double jump
			transitioned.emit(self,"double_jump")
		else: 																# otherwise create jump buffer
			jump_buffer_timer = jump_buffer_time
		if coyote_timer > 0:
			if previous_state.state_name == "run":
				transitioned.emit(self, 'jump')
				
	jump_buffer_timer-=delta
	coyote_timer-=delta
	
	if character.is_on_floor():
		if jump_buffer_timer > 0:
			transitioned.emit(self, "jump")
		elif character.direction_input !=0:
			transitioned.emit(self, "run")
		else:
			transitioned.emit(self, "idle")
			
	if character.is_on_wall() and character.direction_input != 0:#character.facing_raycast.is_colliding() and character.direction_input != 0:
		if jump_buffer_timer > 0:
			transitioned.emit(self, "wall_jump")
		else:
			transitioned.emit(self, "slide")
	
	if character.movement.wants_attack():
		if character.movement.get_up_down_input() > 0:
			transitioned.emit(self,'down_attack')
		else:
			transitioned.emit(self,'attack')

	
func process_physics(delta) -> void:
	super(delta)
	character.velocity.y += Global.GRAVITY * delta
	var movement =  character.direction_input * (character.speed + character.sprint_speed)
	character.velocity.x = movement
