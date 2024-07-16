extends CharacterBody2D
class_name BaseEnemy

@export 
var movement : MovementComponent
@export 
var health_component : HealthComponent
@export 
var hit_box_component : HitBoxComponent
@export 
var sprite : Sprite2D
@export 
var sm : StateMachine

func _ready():
	health_component.health_depleted.connect(enemy_died)
	health_component.health_changed.connect(enemy_hurt)
	hit_box_component.body_entered.connect(_on_body_entered)
	hit_box_component.body_exited.connect(_on_body_exited)

func enemy_died():
	pass
	
func enemy_hurt():
	pass
	
func _on_body_entered():
	pass

func _on_body_exited():
	pass
