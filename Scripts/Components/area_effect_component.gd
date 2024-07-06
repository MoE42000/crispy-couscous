extends Area2D
class_name AreaEffectComponent

@export var character : CharacterBody2D
@export var shape : FlipableShape

func _ready():
	monitoring = false
	body_entered.connect(_on_body_entered)
	character.changed_facing_direction.connect(_changed_facing_direction)

func _on_body_entered(_body):
	pass
	
func _changed_facing_direction(_facing_right:bool):
	pass
