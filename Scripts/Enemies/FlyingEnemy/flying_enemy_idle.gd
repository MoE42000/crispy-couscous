extends State

var direction :int
var change_dir_timer : Timer
var total_time : float

func _ready():
	change_dir_timer = Timer.new()
	add_child(change_dir_timer)
	change_dir_timer.timeout.connect(_on_timer_timeout)
	
func enter() -> void:
	change_dir_timer.wait_time = character.change_dir_time
	direction = 1 if randf() < .5 else -1
	change_dir_timer.start()
		

func process_physics(delta):
	# Move character left or right
	character.velocity.x = direction * character.fly_speed
	total_time += delta
	character.velocity.y = character.amplitude * sin(total_time * character.frequency * PI * 2)
		
	character.move_and_slide()

func _on_timer_timeout():
	direction *= -1 
