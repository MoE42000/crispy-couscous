extends PlayerState

@export
var recoil_force := 80

func enter():
	super()
	character.velocity.y = -40
	character.velocity.x = -recoil_force * character.facing_direction

func process(delta):
	super(delta)
	if character.velocity.y > 0:
		transitioned.emit(self, "fall") 
		
func process_physics(delta):
	super(delta)
	character.velocity.y += Global.GRAVITY * delta
