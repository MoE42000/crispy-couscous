extends BaseEnemy

@export
var animation_tree : AnimationTree

var facing_direction :int = 1

signal changed_facing_direction

func _process(_delta) -> void:
	animation_tree.set("parameters/Move/blend_position", self.velocity.x)
	handle_flipping(velocity.x)
	
func flip_sprite():
	sprite.flip_h = !sprite.flip_h
	facing_direction = -facing_direction
	changed_facing_direction.emit(facing_direction)

func handle_flipping(direction_input: int):
	if direction_input != 0:
		var should_flip = (direction_input > 0 and facing_direction == -1) or (direction_input < 0 and facing_direction == 1)
		if should_flip:
			flip_sprite()
