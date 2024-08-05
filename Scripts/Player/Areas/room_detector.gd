extends Area2D
class_name PlayerRoomDetector

@onready var camera : Camera2D  = $"../Camera2D"

func _ready():
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D):
	var room_area : CollisionShape2D = area.get_child(0)
	var room_size : Vector2 = room_area.shape.size
	var view_size : Vector2 = get_viewport_rect().size
	
	change_room(room_area.global_position, room_size)
	
	#if room_size.y < view_size.y:
		#room_size.y = view_size.y
	
	#if room_size.x < view_size.x: #MAYBE ZOOM?
		#room_size.x = view_size.x
		
	#camera.limit_top = room_area.global_position.y - room_size.y/2
	#camera.limit_bottom = room_area.global_position.y + room_size.y/2
	
	#camera.limit_left = room_area.global_position.x - room_size.x/2
	#camera.limit_bottom = room_area.global_position.x + room_size.x/2

func change_room(room_pos: Vector2, room_size: Vector2):
	camera.current_room_center = room_pos
	camera.current_room_size = room_size
	
	
	
	
