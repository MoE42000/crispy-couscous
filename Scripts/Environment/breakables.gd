extends StaticBody2D
class_name Breakables

@export var health : HealthComponent

func _ready():
	health.health_depleted.connect(self.destroy)

func destroy(): 
	self.queue_free()

