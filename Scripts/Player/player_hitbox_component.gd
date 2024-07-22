extends HitBoxComponent
class_name PlayerHitboxComponent

@export var collision_shape : CollisionShape2D
@export var invincibility_duration : float = 1

func turn_invincible():
	collision_shape.set_deferred("disabled",true)
	await get_tree().create_timer(invincibility_duration).timeout
	collision_shape.set_deferred("disabled",false)
