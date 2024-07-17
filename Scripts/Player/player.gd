extends CharacterBody2D
class_name Player


@export 
var movement : MovementComponent
@export 
var health_component : HealthComponent
@export 
var hit_box_component : HitBoxComponent
@export 
var sprite : Sprite2D
@export 
var raycast: RayCast2D
@export 
var animation_tree : AnimationTree

signal changed_facing_direction(facing_right:bool)

var drop_through_platform : Area2D
var on_drop_through_platform : bool

var direction_input : float
var speed :float = 120.00
var jump_force:float = -315.00

var facing_direction : int = 1

func _ready() -> void:
	health_component.health_depleted.connect(player_died)
	health_component.health_changed.connect(player_hurt)
	hit_box_component.body_entered.connect(_on_body_entered)
	hit_box_component.body_exited.connect(_on_body_exited)
	changed_facing_direction.connect(_changed_facing_direction)
	
func _physics_process(_delta):
	direction_input = movement.get_movement_direction()
	#facing_direction = 1 if !sprite.flip_h else -1
	animation_tree.set("parameters/move/blend_position", direction_input)
	

func player_died() -> void:
	get_tree().reload_current_scene()
	
func player_hurt() -> void:
	print("hurt")
	
func drop_through() -> bool:
	if drop_through_platform and on_drop_through_platform:
		drop_through_platform.set_deferred("monitoring", true)
		return true
	else:
		return false
		
func flip_sprite():
	sprite.flip_h = !sprite.flip_h
	facing_direction = -facing_direction
	changed_facing_direction.emit(facing_direction)

func handle_flipping(direction_input: int):
	if direction_input != 0:
		var should_flip = (direction_input > 0 and facing_direction == -1) or (direction_input < 0 and facing_direction == 1)
		if should_flip:
			flip_sprite()
	
func _on_body_entered(body):
	if body is DropThroughPlatform:
		drop_through_platform = body.detection_area
		on_drop_through_platform = true

func _on_body_exited(body):
	if body is DropThroughPlatform:
		on_drop_through_platform = false
		
func _changed_facing_direction(dir:int):
	if dir > 0:
		raycast.target_position = raycast.facing_right_pos
		sprite.position = Vector2(8,-14)
	else:
		raycast.target_position = raycast.facing_left_pos
		sprite.position = Vector2(-8,-14)
