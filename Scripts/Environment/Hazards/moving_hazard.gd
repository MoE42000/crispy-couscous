@tool
extends Sprite2D
class_name MovingHazard

@export var speed : float = 50
@export var damage_ammount : float = 10

@export var movement_type : MOVEMENT_TYPES = MOVEMENT_TYPES.None :
	set(value):
		movement_type = value
		notify_property_list_changed()

enum MOVEMENT_TYPES {
	None,
	Linear,
}

func _get_property_list() -> Array[Dictionary]:
	var properties : Array[Dictionary] = []
	
	match movement_type:
		MOVEMENT_TYPES.Linear:
			properties.append({
				"name":"positions",
				"type":TYPE_ARRAY,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"movement_durations",
				"type":TYPE_ARRAY,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"transition_name",
				"type":TRANSITION_TYPES,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"ease_name",
				"type":TYPE_STRING,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
		_ :
			properties

	return properties
	
enum TRANSITION_TYPES  { 
	LINEAR = 0,
	SINE = 1,
	QUINT = 2,
	QUART = 3,
	QUAD = 4,
	EXPO = 5,
	ELASTIC = 6,
	CUBIC = 7,
	CIRC = 8,
	BOUNCE = 9,
	BACK = 10
}
 
var transition_type = TRANSITION_TYPES.LINEAR

var positions: Array[Vector2]
var movement_durations: Array[float]
var movement_duration_index: int = 0
var transition_name: String 
var ease_name: String
var tween: Tween 

var initial_pos: Vector2

func _ready():
	initial_pos = position
	tween = get_tree().create_tween()
	tween.finished.connect(_on_tween_finished)
	start_animation()

func start_animation():
	movement_duration_index = 0
	animate_movements(positions)
	
	# boomerang
	var reverse_movements = positions.duplicate()
	reverse_movements.reverse()
	animate_movements(reverse_movements)

	tween.set_loops()

func animate_movements(positions: Array[Vector2]):
	for pos in positions.slice(1):
		var movement_speed = movement_durations[movement_duration_index]
		movement_duration_index = (movement_duration_index + 1) % movement_durations.size()
		# TODO: Add movement delay
		tween.tween_property(self, "position", pos, movement_speed).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)#.set_delay(movement_delay)

		position = pos  # Update the position immediately to chain the next tween properly

func _on_tween_finished():
	# Called when the tween is finished. This will be used to restart the animation if needed.
	pass
