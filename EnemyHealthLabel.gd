extends Label

@export var health_component : HealthComponent

func _ready():
	text = str(health_component.health)
	health_component.health_changed.connect(change_display)
	
func change_display():
	text = str(health_component.health)
