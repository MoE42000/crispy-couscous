extends Label

@onready var health = $"../HealthComponent"


func _ready():
	text = str(health.health)
	health.health_changed.connect(_change_display)

func _change_display():
	text = str(health.health)
