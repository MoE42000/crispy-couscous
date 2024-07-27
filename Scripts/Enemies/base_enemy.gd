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

@export var ability : String

@export 
var detection_distance : float = 90

@export 
var touch_damage : float = 5
@export
var facing_direction :int = -1

signal changed_facing_direction

func _ready():
	
	health_component.health_depleted.connect(_enemy_died)
	health_component.health_changed.connect(_enemy_health_changed)
	hit_box_component.body_entered.connect(_on_body_entered)
	hit_box_component.body_exited.connect(_on_body_exited)
	hit_box_component.set_collision_layer(3)
	
	

func _process(_delta) -> void:
	handle_flipping(velocity.x)
	
func flip_sprite():
	sprite.flip_h = !sprite.flip_h
	facing_direction = -facing_direction
	if facing_direction > 0:
		sprite.offset.x = -15
	else:
		sprite.offset.x = 0
	changed_facing_direction.emit(facing_direction)

func handle_flipping(direction_input: float):
	if direction_input != 0:
		var should_flip = (direction_input > 0 and facing_direction == -1) or (direction_input < 0 and facing_direction == 1)
		if should_flip:
			flip_sprite()
	
func sprite_flash(color:Color,duration=.2,loops=1) -> void:
	var set_flash_state = func(v): sprite.material.set_shader_parameter("flashState", v)
	sprite.material.set_shader_parameter("color", color)
	var flash_tween = create_tween()
	flash_tween.set_loops(loops)
	flash_tween.tween_method(set_flash_state, 0,1,duration/2)
	flash_tween.tween_method(set_flash_state, 1,0,duration/2)

func _enemy_died():
	Global.player.current_ability = ability
	queue_free()
	
func _enemy_health_changed():
	sprite_flash(Color(1,1,1,.5))
	
func _on_body_entered(body):
	if body is Player:
		body.health_component.damage(touch_damage)

func _on_body_exited(_body):
	pass

func recoil():
	pass
