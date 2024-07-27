extends Area2D
class_name StaticSpikeArea

@export var spike_damage : float = 5

var hitboxes_to_damage : Array[HitBoxComponent]
var should_damage_player : bool = false

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	should_damage_player = true
	if area is HitBoxComponent and not DamageManager.is_damaged(area):
		hitboxes_to_damage.append(area)

func _on_area_exited(area):
	if area in hitboxes_to_damage:
		hitboxes_to_damage.erase(area)
		DamageManager.unregister_damage(area)
	if hitboxes_to_damage.size() == 0:
		should_damage_player = false
	
func _process(_delta):
	damage()
	
func damage():
	if should_damage_player:
		for hitbox_component in hitboxes_to_damage:
			if not DamageManager.is_damaged(hitbox_component):
				hitbox_component.damage(spike_damage)
				DamageManager.register_damage(hitbox_component)

