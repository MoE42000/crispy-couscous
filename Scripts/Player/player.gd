extends CharacterBody2D
class_name Player


@onready 
var movement : MovementComponent = $MovementComponent
@onready  
var health_component : HealthComponent = $HealthComponent
@onready  
var hit_box_component : HitBoxComponent = $HitBoxComponent
@onready 
var feet_area : Area2D = $FeetArea
@onready 
var sprite : Sprite2D = $Sprite2D
@onready 
var facing_raycast: RayCast2D = $FacingRaycast
@onready 
var feet_raycast: RayCast2D = $FeetRaycast
@onready 
var animation_tree : AnimationTree = $AnimationTree

signal changed_facing_direction(facing_right:bool)
signal sword_hit_something
signal falling

var drop_through_platform : Area2D
var on_drop_through_platform : bool

var can_double_jump :bool = false

var direction_input : float
@export
var speed :float = 120.00
@export 
var sprint_speed_val : float = 80
var sprint_speed : float = 0

@export
var ability : String = ""
var current_ability : String = ability

var facing_direction : int = 1

func _ready() -> void:
	
	Global.player = self
	sprite.material.set_shader_parameter("flashState", 0)
	health_component.health_depleted.connect(player_died)
	health_component.health_changed.connect(_player_health_changed)
	hit_box_component.body_entered.connect(_on_body_entered)
	hit_box_component.body_exited.connect(_on_body_exited)
	feet_area.body_entered.connect(_on_feet_area_body_entered)
	feet_area.body_exited.connect(_on_feet_area_body_exited)
	changed_facing_direction.connect(_changed_facing_direction)
	
func _physics_process(_delta):
	direction_input = movement.get_movement_direction()
	animation_tree.set("parameters/move/blend_position", direction_input)
	

func player_died() -> void:
	get_tree().reload_current_scene()
	
func _player_health_changed(lost_health) -> void:
	if lost_health:
		sprite_flash(Color(1,1,1,.5),.9,3)
		hit_box_component.turn_invincible()
	
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

func handle_flipping(dir_input: int):
	if dir_input != 0:
		var should_flip = (dir_input > 0 and facing_direction == -1) or (dir_input < 0 and facing_direction == 1)
		if should_flip:
			flip_sprite()
			
func sprite_flash(color:Color,duration:=.2,loops:=1) -> void:
	var set_flash_state = func(v): sprite.material.set_shader_parameter("flashState", v)
	sprite.material.set_shader_parameter("color", color)
	var flash_tween = create_tween()
	flash_tween.set_loops(loops)
	flash_tween.tween_method(set_flash_state, 0,1,duration/(2*loops))
	flash_tween.tween_method(set_flash_state, 1,0,duration/(2*loops))
	
func _on_feet_area_body_entered(body):
	if body is DropThroughPlatform:
		drop_through_platform = body.detection_area
		on_drop_through_platform = true

func _on_feet_area_body_exited(body):
	if body is DropThroughPlatform:
		pass
		#await get_tree().create_timer(.5).timeout
		#on_drop_through_platform = false
	
func _on_body_entered(body):
	pass
	
func _on_body_exited(body):
	pass
		
func _changed_facing_direction(dir:int):
	if dir > 0:
		facing_raycast.target_position = facing_raycast.facing_right_pos
		sprite.position = Vector2(8,-14)
	else:
		facing_raycast.target_position = facing_raycast.facing_left_pos
		sprite.position = Vector2(-8,-14)
	sprint_speed = 0 # stop sprint
