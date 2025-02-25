extends Sprite2D
class_name SpikeProjectileShooter

@onready var projectile = preload("res://Scenes/Hazards/spike_projectile.tscn")
var timer : Timer

@export
var shoot_rate : float = 1.0
@export 
var start_shooting_offset : float = 0
@export
var projectile_speed : float = 200
@export 
var projectile_damage : float = 5

@export 
var enabled : bool = true 

@onready 
var animation_player := $AnimationPlayer

func _ready():
	timer = Timer.new()
	
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = shoot_rate
	add_child(timer)
	await get_tree().create_timer(start_shooting_offset).timeout
	if enabled:
		shoot()
		timer.start()
	
	

func shoot():
	animation_player.play("shoot")
	await get_tree().create_timer(.5).timeout
	
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.projectile_damage = projectile_damage
	instance.spawn_pos = Vector2(global_position.x, global_position.y)
	instance.spawn_rotation = rotation
	instance.speed = projectile_speed
	
	add_child(instance)

func _on_timer_timeout():
	
	shoot()
