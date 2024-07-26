extends CharacterBody2D
class_name BouncingHazard

@export var dir : Vector2
@export var speed : float
@export var damage_ammount : float = 10

@onready var hurt_area : Area2D = $HurtArea

func _ready():
	# Initialize the velocity
	velocity = dir.normalized() * speed
	hurt_area.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	# Move and check for collisions
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())

func _on_body_entered(body):
	if body is Player:
		body.health_component.damage(damage_ammount)
