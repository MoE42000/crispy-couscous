extends PlayerAttack

func enter():
	super()
	character.sprite.offset.y += 14
	
func exit():
	super()
	character.sprite.offset.y -= 14
