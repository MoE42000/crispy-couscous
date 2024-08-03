extends Area2D
class_name BreakingPlatform

@export var resets : bool = true
@export var reconstruct_time : float = 3
@onready var animation := $AnimationPlayer

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(_body):
	await get_tree().create_timer(0.2).timeout
	animation.play("break")
	await get_tree().create_timer(reconstruct_time).timeout
	animation.play("reconstruct")
