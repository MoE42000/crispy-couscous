extends Camera2D
class_name AreasTransitionCameras

@export var follow_smoothing : float = .1

var smoothing : float
var current_room_center : Vector2
var current_room_size : Vector2

@onready var view_size : Vector2 = get_viewport_rect().size
var zoom_view_size : Vector2


func _ready():
	smoothing = follow_smoothing 


func _physics_process(_delta):
	zoom_view_size = view_size * zoom
	
	# get target pos
	var target_position : Vector2 = calculate_target_position(current_room_center, current_room_size)
	
	position = lerp(position, target_position, smoothing)
	
func calculate_target_position(room_center:Vector2, room_size: Vector2) -> Vector2:
	# Distance from the center of the room to the cameara boundry on one side

	var x_margin : float = (room_size.x - zoom_view_size.x) / 2
	var y_margin : float = (room_size.y - zoom_view_size.y) / 2
	
	var return_position : Vector2 = Vector2.ZERO
	
	if x_margin <= 0:
		return_position.x = room_center.x - x_margin
	else:
		var left_limit : float = room_center.x - x_margin
		var right_limit : float = room_center.x + x_margin
		return_position = clamp(Global.player.position.x, left_limit, right_limit)
		
	if y_margin <= 0:
		return_position.y = room_center.y - y_margin
	else:
		var top_limit : float = room_center.y - y_margin
		var bot_limit : float = room_center.y + y_margin
		return_position = clamp(Global.player.position.y, top_limit, bot_limit)
		
	return return_position
