extends PlayerState
class_name PlayerSlide

@export var wall_slide_gravity : float = 180
@export var fall_delay:float=.05
var fall_timer:Timer
var sliding : bool
var facing_dir : int

func _ready():
	fall_timer = Timer.new()
	add_child(fall_timer)
	fall_timer.one_shot = true
	fall_timer.timeout.connect(_on_fall_timer_timeout)
	fall_timer.wait_time = fall_delay

func enter() -> void:
	super()
	facing_dir = character.direction_input
	sliding = true
	

func exit():
	super()
	sliding = false

func process(delta) -> void:
	super(delta)
	if character.feet_raycast.is_colliding():#character.is_on_floor():
		if character.direction_input != 0:
			transitioned.emit(self, "run")
		else:
			transitioned.emit(self, "idle")
			
	elif !character.facing_raycast.is_colliding():
		transitioned.emit(self, "fall")
		
	elif character.direction_input != facing_dir:
		if fall_timer.is_stopped():
			fall_timer.start()

		
	if character.movement.wants_jump():
		transitioned.emit(self, "wall_jump")



func process_physics(delta) -> void:
	
	
	character.velocity.y += wall_slide_gravity * delta
	character.velocity.y = min(character.velocity.y,wall_slide_gravity)
	super(delta)
	
func _on_fall_timer_timeout():
	if sliding:
		transitioned.emit(self, "fall")
