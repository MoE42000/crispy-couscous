extends CharacterBody2D
class_name BaseEnemy

@onready  
var health_component : HealthComponent = $HealthComponent
@onready 
var hit_box_component : HitBoxComponent = $HitBoxComponent
@onready  
var sprite : Sprite2D = $Sprite2D
@onready 
var sm : StateMachine = $StateMachine


@export_group("Stats")
@export 
var detection_distance : float = 90
@export 
var health : float = 10

@export_group("Other")
@export 
var touch_damage : float = 5
@export
var facing_direction :int = -1
@export 
var ability : String

signal changed_facing_direction

func _ready():
	hit_box_component.set_collision_layer_value(3, true)
	hit_box_component.set_collision_layer_value(1, false)
	hit_box_component.set_collision_mask_value(2, true)
	hit_box_component.set_collision_mask_value(1, false)
	health_component.health = health
	health_component.health_depleted.connect(_enemy_died)
	health_component.health_changed.connect(_enemy_health_changed)
	hit_box_component.area_entered.connect(_on_area_entered)
	hit_box_component.body_exited.connect(_on_body_exited)
	
	

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
	
func _enemy_health_changed(lost_health):
	if lost_health:
		sprite_flash(Color(1,1,1,.5))
	
func _on_area_entered(area): # Make sure masks are correct
	area.damage(touch_damage)

func _on_body_exited(_body):
	pass

func recoil():
	pass
