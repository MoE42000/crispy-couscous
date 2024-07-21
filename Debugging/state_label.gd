extends Label
class_name StateLabel

@export var sm : StateMachine

func _ready():
	set("theme_override_font_sizes/font_size", 10)

func _process(_delta):
	text = sm.state.state_name
	
