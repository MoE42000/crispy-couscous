extends Area2D
class_name BreakingPlatform

@export var resets : bool = true
@onready var animation := $AnimationPlayer

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(_body):
	animation.play("break")
	#await animation.animation_finished
	#queue_free()
