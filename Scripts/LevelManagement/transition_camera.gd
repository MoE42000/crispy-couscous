extends Camera2D
class_name SameSizeScreenTransitionCamera

var screen_size : Vector2

@export 
var cur_screen := Vector2( 0, 0 )

func _ready():
	screen_size = Global.SCREEN_SIZE / zoom
	set_as_top_level(true)
	global_position = get_parent().global_position
	update_screen( cur_screen )

func _process(delta):
	var player :Player = get_parent()
	var parent_screen : Vector2 = ( player.global_position / screen_size ).floor()
	if !parent_screen.is_equal_approx( cur_screen ) and player.is_on_floor() :
		update_screen( parent_screen )


func update_screen( new_screen : Vector2 ):
	cur_screen = new_screen
	global_position = cur_screen * screen_size + screen_size * 0.5
