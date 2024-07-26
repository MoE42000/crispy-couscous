extends StaticBody2D
class_name DropThroughPlatform

@export var detection_area : Area2D
#@export var y_scale : float = 1
#@export var x_scale: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	set_collision_mask_value(2, true)
	#set_collision_mask_value(3, true)
	
	detection_area.set_collision_mask_value(2, true)
	
	detection_area.set_deferred("monitoring", false)
	detection_area.body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	body.set_collision_mask_value(1, false)
	await get_tree().create_timer(.2).timeout
	body.set_collision_mask_value(1, true)
	detection_area.set_deferred("monitoring", false)
