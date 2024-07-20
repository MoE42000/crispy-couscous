class_name HealthComponent
extends Node

# create signals
signal health_changed
signal health_depleted

@export var health : float = 1:
	set(value):# set allows to call something whenever the value has been changed
		health = value
		health_changed.emit()
		
		if health <= 0:
			health_depleted.emit()
			
var max_health = health

func damage(damage_amount:float):
	health -= damage_amount
	
func heal(healing:float):
	health += healing
