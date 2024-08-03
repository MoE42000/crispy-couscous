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
				"nt_string":""
			})
			properties.append({
				"name":"movements_duration",
				"type":TYPE_FLOAT,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"position_delays",
				"type":TYPE_ARRAY,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"nt_string":""
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

var movements_duration: float
var positions: Array[Vector2]
var position_delays : Array[float]

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
	animate_movements(positions.slice(1), position_delays)
	
	# boomerang
	var reverse_movements = positions.duplicate()
	var reverse_delays = position_delays.duplicate()
	reverse_movements.reverse()
	reverse_delays.reverse()
	animate_movements(reverse_movements.slice(1),reverse_delays)

	tween.set_loops()

func animate_movements(positions: Array[Vector2], delays: Array[float]):
	var position_delays_index: int = 0
	for pos in positions:
		var delay = delays[position_delays_index]
		position_delays_index = (position_delays_index + 1) % delays.size()
		# TODO: Add movement delay
		tween.tween_property(self, "position", pos, movements_duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO).set_delay(delay)

		position = pos  # Update the position immediately to chain the next tween properly

func _on_tween_finished():
	# Called when the tween is finished. This will be used to restart the animation if needed.
	pass
