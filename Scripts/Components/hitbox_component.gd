extends Area2D
class_name HitBoxComponent

@export var health_component : HealthComponent

func damage(damage_amount:float):
	if health_component:
		health_component.damage(damage_amount)
