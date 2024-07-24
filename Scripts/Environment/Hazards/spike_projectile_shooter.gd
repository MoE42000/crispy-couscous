extends Sprite2D
class_name SpikeProjectileShooter

@onready var projectile = preload("res://Scenes/Hazards/spike_projectile.tscn")
var timer : Timer

@export
var shoot_rate : float = 1.0
@export
var projectile_speed : float = 200


func _ready():
	timer = Timer.new()
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = shoot_rate
	add_child(timer)
	
	

func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawn_pos = Vector2(global_position.x, global_position.y)
	instance.spawn_rotation = rotation
	instance.speed = projectile_speed
	add_child(instance)

func _on_timer_timeout():
	shoot()
