extends Node

var damaged_hitboxes : Dictionary = {}

func register_damage(hitbox_component):
	damaged_hitboxes[hitbox_component] = null

func unregister_damage(hitbox_component):
	damaged_hitboxes.erase(hitbox_component)

func is_damaged(hitbox_component) -> bool:
	return hitbox_component in damaged_hitboxes
