extends CharacterBody2D
class_name BaseEnemy

@export 
var health_component : HealthComponent
@export 
var hit_box_component : HitBoxComponent
@export 
var sprite : Sprite2D
@export 
var sm : StateMachine

@export var enemy_strength : float = 5

func _ready():
	health_component.health_depleted.connect(_enemy_died)
	health_component.health_changed.connect(_enemy_health_changed)
	hit_box_component.body_entered.connect(_on_body_entered)
	hit_box_component.body_exited.connect(_on_body_exited)

func _enemy_died():
	queue_free()
	
func _enemy_health_changed():
	pass
	
func _on_body_entered(body):
	pass

func _on_body_exited(body):
	pass
