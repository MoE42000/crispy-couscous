extends Sprite2D
class_name Breakable

@export var health : HealthComponent

func _ready():
	health.health_depleted.connect(self.destroy)

func destroy(): 
	self.queue_free()
