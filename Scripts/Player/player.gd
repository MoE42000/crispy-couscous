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

var direction : float
var speed :float = 200.00
var jump_force:float = -400.00

func _ready() -> void:
	health_component.health_depleted.connect(player_died)
	health_component.health_changed.connect(player_hurt)
	hit_box_component.body_entered.connect(_on_body_entered)
	hit_box_component.body_exited.connect(_on_body_exited)
	changed_facing_direction.connect(_changed_facing_direction)
	
func _physics_process(_delta):
	direction = movement.get_movement_direction()
	animation_tree.set("parameters/move/blend_position", direction)
	

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
	
func _on_body_entered(body):
	if body is DropThroughPlatform:
		drop_through_platform = body.detection_area
		on_drop_through_platform = true

func _on_body_exited(body):
	if body is DropThroughPlatform:
		on_drop_through_platform = false
		
func _changed_facing_direction(facing_right:bool):
	if facing_right:
		raycast.target_position = raycast.facing_right_pos
	else:
		raycast.target_position = raycast.facing_left_pos
