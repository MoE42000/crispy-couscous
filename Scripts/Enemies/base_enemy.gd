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



@export 
var enemy_strength : float = 5

func _ready():
	
	health_component.health_depleted.connect(_enemy_died)
	health_component.health_changed.connect(_enemy_health_changed)
	hit_box_component.body_entered.connect(_on_body_entered)
	hit_box_component.body_exited.connect(_on_body_exited)
	hit_box_component.set_collision_layer(3)
	
func sprite_flash(color:Color,duration=.2,loops=1) -> void:
	var set_flash_state = func(v): sprite.material.set_shader_parameter("flashState", v)
	sprite.material.set_shader_parameter("color", color)
	var flash_tween = create_tween()
	flash_tween.set_loops(loops)
	flash_tween.tween_method(set_flash_state, 0,1,duration/2)
	flash_tween.tween_method(set_flash_state, 1,0,duration/2)

func _enemy_died():
	queue_free()
	
func _enemy_health_changed():
	sprite_flash(Color(1,1,1,.5))
	
func _on_body_entered(body):
	if body is Player:
		body.health_component.damage(enemy_strength)

func _on_body_exited(_body):
	pass

func recoil():
	pass
