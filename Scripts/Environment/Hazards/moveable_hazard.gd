@tool
extends CharacterBody2D
class_name BouncingHazard

@export var movement_type : MOVEMENT_TYPES = MOVEMENT_TYPES.Default :
	set(value):
		movement_type = value
		notify_property_list_changed()

enum MOVEMENT_TYPES {
	Default,
	Increasing,
	Discrete,
	Random,
}

var speed_change : float
var max_speed : float = 1000
var increase_type : INCREASE_TYPE = INCREASE_TYPE.Linear
enum INCREASE_TYPE {Linear,Multiplicative}
var change_on_bounce : bool = true :
	set(value):
		change_on_bounce = value
		notify_property_list_changed()
var change_time_rate : float
var speed_values : Array[float]
var speed_value_index : int = 0
var speed_range : Vector2

func _get_property_list() -> Array[Dictionary]:
	var properties : Array[Dictionary] = []
	match movement_type:
		MOVEMENT_TYPES.Increasing:
			properties.append({
				"name":"increase_type",
				"type":TYPE_INT,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"speed_change",
				"type":TYPE_FLOAT,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"max_speed",
				"type":TYPE_FLOAT,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"change_on_bounce",
				"type":TYPE_BOOL,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			if !change_on_bounce:
				properties.append({
					"name":"change_time_rate",
					"type":TYPE_FLOAT,
					"usage":PROPERTY_USAGE_DEFAULT,
					"hint":PROPERTY_HINT_ENUM,
					"hint_string":""
				})

		MOVEMENT_TYPES.Discrete:
			properties.append({
				"name":"speed_values",
				"type":TYPE_ARRAY,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"change_on_bounce",
				"type":TYPE_BOOL,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			if !change_on_bounce:
				properties.append({
					"name":"change_time_rate",
					"type":TYPE_FLOAT,
					"usage":PROPERTY_USAGE_DEFAULT,
					"hint":PROPERTY_HINT_ENUM,
					"hint_string":""
				})
			
		MOVEMENT_TYPES.Random:
			properties.append({
				"name":"speed_range",
				"type":TYPE_VECTOR2,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			properties.append({
				"name":"change_on_bounce",
				"type":TYPE_BOOL,
				"usage":PROPERTY_USAGE_DEFAULT,
				"hint":PROPERTY_HINT_ENUM,
				"hint_string":""
			})
			if !change_on_bounce:
				properties.append({
					"name":"change_time_rate",
					"type":TYPE_FLOAT,
					"usage":PROPERTY_USAGE_DEFAULT,
					"hint":PROPERTY_HINT_ENUM,
					"hint_string":""
				})
		_ :
			properties
	return properties

@export var initial_dir : Vector2 = Vector2.ZERO
@export var initial_speed : float = 50
@export var damage_ammount : float = 10

var speed : float
var speed_timer : Timer



@onready var hurt_area : Area2D = $HurtArea

func _ready():
	if !change_on_bounce:
		speed_timer = Timer.new()
		speed_timer.wait_time = change_time_rate
		add_child(speed_timer)
		speed_timer.timeout.connect(_on_speed_timer_timeout)
		speed_timer.start()
	
	
	velocity = initial_dir.normalized() * initial_speed
	hurt_area.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	# Move and check for collisions
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if change_on_bounce:
			update_speed()
		velocity = velocity.bounce(collision_info.get_normal())


func update_speed():
	match movement_type:
		MOVEMENT_TYPES.Increasing:
			speed = min(speed + speed_change, max_speed) if INCREASE_TYPE.Linear else min(speed * speed_change, max_speed)
			
		MOVEMENT_TYPES.Discrete:
			speed = speed_values[speed_value_index]
			speed_value_index = (speed_value_index + 1) % speed_values.size() 
			
		MOVEMENT_TYPES.Random:
			speed = randf_range(speed_range.x, speed_range.y)
		
		_:
			pass
	
	velocity = velocity.normalized() * speed
			
func _on_speed_timer_timeout():
	update_speed()
	
	
	
func _on_body_entered(body):
	if body is Player:
		body.health_component.damage(damage_ammount)
