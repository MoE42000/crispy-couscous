extends State

var wander_distance: float
var moving_right: bool
var walk_speed = 50

func enter() -> void:
	change_animation(animation_name)
	set_random_wander()

func set_random_wander() -> void:
	# Set a random distance to wander
	wander_distance = randf_range(10, 50)
	# Check whether he should avoid edge otherwise randomly decide to move left or right
	if !character.edge_checking_raycast.is_colliding():
		if character.facing_direction < 0:
			moving_right = true
		else:
			moving_right = false
	else:
		moving_right = randf() < 0.5
	
func process(_delta):
	if abs(character.position.direction_to(Global.player.position).y) < .2 and character.position.distance_to(Global.player.position) < 35:
		transitioned.emit(self,"attack")
	if !character.edge_checking_raycast.is_colliding():
		transitioned.emit(self,"idle")

func process_physics(delta) -> void:
	if wander_distance > 0:
		# Move character left or right
		var direction = 1 if moving_right else -1
		character.velocity.x = direction * walk_speed
		wander_distance -= abs(character.velocity.x) * delta

	else:
		# Stand still when wander distance is exhausted, then choose new wander distance
		transitioned.emit(self,"idle")

	# Apply gravity
	character.velocity.y += Global.GRAVITY * delta
	character.move_and_slide()
