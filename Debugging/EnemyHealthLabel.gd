extends Label
class_name HealthLabel


@export var health_component : HealthComponent

func _ready():
	set("theme_override_font_sizes/font_size", 10)
	text = str(health_component.health)
	health_component.health_changed.connect(change_display)
	
func change_display(_lost_health):
	text = str(health_component.health)
