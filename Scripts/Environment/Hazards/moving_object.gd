@tool
extends Node2D
class_name MoveableObject



@export var movement_type : MOVEMENT_TYPES = MOVEMENT_TYPES.None :
	set(value):
		movement_type = value
		notify_property_list_changed()

enum MOVEMENT_TYPES {
	None,
	Linear,
	Circular
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
				"hint_string":""
			})
			
		MOVEMENT_TYPES.Circular:
			properties.append({
				"name":"initial_position",
				"type":TYPE_VECTOR2,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"radius",
				"type":TYPE_FLOAT,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"speed",
				"type":TYPE_FLOAT,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"rotation_delay",
				"type":TYPE_FLOAT,
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


# LINEAR MOVEMENT
var movements_duration: float
var positions: Array[Vector2]
var position_delays : Array[float]

var transition_name: String 
var ease_name: String
var tween: Tween 

# CIRCULAR MOVEMENT
var d : float = 0
var radius : float 
var speed : float
var initial_position: Vector2
var rotation_delay : float
var rotation_delay_timer: Timer

func _ready():
	#initial_pos = position
	match movement_type:
		
		MOVEMENT_TYPES.Linear:
			tween = get_tree().create_tween()
			tween.finished.connect(_on_tween_finished)
			start_animation()
		MOVEMENT_TYPES.Circular:
			if rotation_delay > 0:
				rotation_delay_timer = Timer.new()
				rotation_delay_timer.one_shot = true
				print("added tiemr")
				add_child(rotation_delay_timer)
				print(rotation_delay_timer)
				rotation_delay_timer.timeout.connect(_on_rotation_delay_timeout)
		_:
			pass
			
func _process(delta):
	match movement_type:
		MOVEMENT_TYPES.Circular:
			circular_movement(delta)
		
		_:
			pass

func start_animation():
	animate_movements(positions.slice(1), position_delays)
	
	# boomerang
	var reverse_movements = positions.duplicate()
	var reverse_delays = position_delays.duplicate()
	reverse_movements.reverse()
	reverse_delays.reverse()
	animate_movements(reverse_movements.slice(1),reverse_delays)

	tween.set_loops(150)

func animate_movements(positions: Array[Vector2], delays: Array[float]):
	var position_delays_index: int = 0
	for pos in positions:
		var delay = delays[position_delays_index]
		position_delays_index = (position_delays_index + 1) % delays.size()
		tween.tween_property(self, "position", pos, movements_duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO).set_delay(delay)

		position = pos  # Update the position immediately to chain the next tween properly

func _on_tween_finished():
	start_animation()



func circular_movement1(delta):
	d += delta
	position = Vector2(
		sin(d * speed) * radius,
		cos(d * speed) * radius
	)  + initial_position
	
func circular_movement(delta):
	if rotation_delay > 0:
		if rotation_delay_timer.is_stopped():
			d += delta
			position = Vector2(
				sin(d * speed) * radius,
				cos(d * speed) * radius
			)  + initial_position
		
		# Check if a full rotation has been completed
			if d >= TAU / speed:
				d -= TAU / speed  # Reset d for the next full rotation
				rotation_delay_timer.start(rotation_delay)
	else:
		d += delta
		position = Vector2(
			sin(d * speed) * radius,
			cos(d * speed) * radius
		)  + initial_position

func _on_rotation_delay_timeout():
	pass
