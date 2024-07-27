extends Area2D
class_name StaticSpikeArea

@export var spike_damage : float = 5

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	body.health_component.damage(spike_damage)
