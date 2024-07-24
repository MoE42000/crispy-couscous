extends Area2D
class_name SpikeProjectile

var speed: float
var dir: float
var spawn_pos: Vector2
var spawn_rotation: float

var _travelled_distance : float
var _max_range : float = 1000

func _ready():
	global_position = spawn_pos
	global_rotation = spawn_rotation
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	var distance := -speed * delta
	var motion := transform.x * -speed * delta
	
	position += motion
	_travelled_distance += distance
	
func _process(_delta):
	if _travelled_distance > _max_range:
		queue_free()
		
func _on_body_entered(body):
	for child in body.get_children():
		if child is HealthComponent:
			child.damage(5)
	queue_free()
