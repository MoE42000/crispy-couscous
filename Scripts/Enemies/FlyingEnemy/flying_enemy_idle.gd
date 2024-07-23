extends State

var direction :int
@export 
var fly_speed : float = 20
@export
var change_dir_time : float = 1.5
var change_dir_timer := Timer.new()

@export 
var amplitude := 50
@export 
var frequency := 1

var total_time : float

func _ready():
	add_child(change_dir_timer)
	change_dir_timer.wait_time = change_dir_time
	change_dir_timer.timeout.connect(_on_timer_timeout)
	
func enter() -> void:
	direction = 1 if randf() < .5 else -1
	change_dir_timer.start()
		

func process_physics(delta):
	# Move character left or right
	character.velocity.x = direction * fly_speed
	total_time += delta
	character.velocity.y = amplitude * sin(total_time * frequency * PI * 2)
		
	character.move_and_slide()

func _on_timer_timeout():
	direction *= -1 
