class_name PlayerState
extends State

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var animation_name : String

var jump_buffer_time:float = .2
var coyote_time:float = .5
var attack_buffer_time:float = .1

var jump_buffer_timer :float
var coyote_timer :float
var attack_buffer_timer: float

func enter() -> void:
	if playback.get_current_node() != animation_name:
		playback.travel(animation_name)
	else:
		playback.start(animation_name)

func exit() -> void:
	pass

func process(_delta:float) -> void:
	pass
	
func process_physics(_delta:float) -> void:
	if playback.get_current_node() != "attack":
		if character.direction < 0:
			character.sprite.flip_h = true
			
		elif character.direction > 0:
			character.sprite.flip_h  = false
			
	character.changed_facing_direction.emit(!character.sprite.flip_h)
	character.move_and_slide()
