@tool
extends CharacterBody2D
class_name BouncingHazard

@export var initial_dir : Vector2 = Vector2.ZERO
@export var initial_speed : float = 50
@export var damage_ammount : float = 10

@export var speed_change_type : SPEED_CHANGE_TYPES = SPEED_CHANGE_TYPES.None :
	set(value):
		speed_change_type = value
		notify_property_list_changed()

enum SPEED_CHANGE_TYPES {
	None,
	Linear,
	Multiplicative,
	Discrete,
	Random,
}

var speed_change : float
var max_speed : float = 1000
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
	
	match speed_change_type:
		SPEED_CHANGE_TYPES.Linear:
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
		
		SPEED_CHANGE_TYPES.Multiplicative:
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

		SPEED_CHANGE_TYPES.Discrete:
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
			
		SPEED_CHANGE_TYPES.Random:
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

var speed : float
var speed_timer : Timer

@onready var hurt_area : Area2D = $HurtArea
@onready var sprite : Sprite2D = $Sprite2D

var tween : Tween 
	#var animation_length := .1
	#var landscape_mode:bool = (GameParameters.orientation == 0)
	#animation_tween.tween_property(sprite, "scale:x" if landscape_mode else "scale:y", 2.5, animation_length/2)
	#animation_tween.parallel().tween_property(sprite, "scale:y" if landscape_mode else "scale:x", .5, animation_length/2)


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
		tween = create_tween()
		var y_scale : float = (1 - .60 * abs(cos(collision_info.get_angle()))) * (1 + .30 * abs(sin(collision_info.get_angle())))
		var x_scale :float = (1 + .60 * abs(sin(collision_info.get_angle()))) * (1 + .30 * abs(cos(collision_info.get_angle())))
	
		tween.tween_property(sprite, "scale:x", x_scale,.1)
		tween.parallel().tween_property(sprite, "scale:y", y_scale, .1)
		
		tween.tween_property(sprite, "scale:x", 1,.1)
		tween.parallel().tween_property(sprite, "scale:y", 1, .1)
		
		if change_on_bounce:
			update_speed()
		velocity = velocity.bounce(collision_info.get_normal())


func update_speed():
	match speed_change_type:
		SPEED_CHANGE_TYPES.Linear:
			speed = min(speed + speed_change, max_speed)
			
		SPEED_CHANGE_TYPES.Multiplicative:
			speed = min(speed * speed_change, max_speed)
			
		SPEED_CHANGE_TYPES.Discrete:
			speed = speed_values[speed_value_index]
			speed_value_index = (speed_value_index + 1) % speed_values.size() 
			
		SPEED_CHANGE_TYPES.Random:
			speed = randf_range(speed_range.x, speed_range.y)
		_:
			pass
	
	velocity = velocity.normalized() * speed
			
func _on_speed_timer_timeout():
	update_speed()
	
	
func _on_body_entered(body):
	if body is Player:
		body.health_component.damage(damage_ammount)
