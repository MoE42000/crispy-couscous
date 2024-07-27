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
				"name":"movements",
				"type":TYPE_ARRAY,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"movement_speed_values",
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

var movements : Array[Vector2]
var movement_speed_values : Array[float]
var speed_value_index : int = 0
var transition_name : String 
var ease_name : String
var tween : Tween 

func _ready():
	tween = get_tree().create_tween()
	for movement in movements:
		var movement_speed = movement_speed_values[speed_value_index]
		speed_value_index = (speed_value_index + 1) % movement_speed_values.size() 
		var new_pos = Vector2(position.x + movement.x, position.y + movement.y)
		tween.tween_property(self,"position", new_pos, movement_speed)
	
