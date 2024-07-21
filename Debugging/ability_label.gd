extends Label
class_name AbilityLabel

func _ready():
	set("theme_override_font_sizes/font_size", 10)

func _process(delta):
	text = Global.player.current_ability
