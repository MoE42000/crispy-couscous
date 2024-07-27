extends Area2D

@onready var damaging_area : Area2D = $DamagingArea
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@export var spike_damage : float = 5
var should_damage_player : bool = false
var hitboxes_to_damage : Array[HitBoxComponent] = []

func _ready():
	animation_player.play("hidden")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	damaging_area.area_entered.connect(_on_area_entered_damaging_area)
	damaging_area.area_exited.connect(_on_area_exited_damaging_area)

func _process(_delta):
	damage()

func _on_body_entered(_body):
	animation_player.play("coming_out")

func _on_body_exited(_body):
	animation_player.play("going_in")

func _on_area_entered_damaging_area(area):
	should_damage_player = true
	if area is HitBoxComponent and not DamageManager.is_damaged(area):
		hitboxes_to_damage.append(area)

func _on_area_exited_damaging_area(area):
	if area in hitboxes_to_damage:
		hitboxes_to_damage.erase(area)
		DamageManager.unregister_damage(area)
	if hitboxes_to_damage.size() == 0:
		should_damage_player = false

func damage():
	if should_damage_player:
		for hitbox_component in hitboxes_to_damage:
			if not DamageManager.is_damaged(hitbox_component):
				hitbox_component.damage(spike_damage)
				DamageManager.register_damage(hitbox_component)
	
