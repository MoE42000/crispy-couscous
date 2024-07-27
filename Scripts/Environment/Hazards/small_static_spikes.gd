extends StaticSpikeArea
class_name OneWayCollisionSpikes

func _ready():
	super()
	Global.player.falling.connect(_on_player_falling)

func _on_area_entered(area):
	if area is HitBoxComponent:
		var player = area.get_parent()
		if player is Player:
			if player.velocity.y > 0:  # Check if player is falling
				if not DamageManager.is_damaged(area):
					hitboxes_to_damage.append(area)
					should_damage_player = true
			elif player.is_on_floor():
				if not DamageManager.is_damaged(area):
					hitboxes_to_damage.append(area)
					should_damage_player = true


func _on_area_exited(area):
	if area in hitboxes_to_damage:
		hitboxes_to_damage.erase(area)
		DamageManager.unregister_damage(area)
	if hitboxes_to_damage.size() == 0:
		should_damage_player = false
		
func _process(delta):
	damage()

func _on_player_falling():
	pass
