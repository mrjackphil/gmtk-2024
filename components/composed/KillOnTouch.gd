extends Area3D
class_name KillOnTouch

@export var DAMAGE: int

func _ready() -> void:
	area_entered.connect(_collide)

func _collide(collider: Node3D) -> void:
	if collider.owner.is_in_group("player"):
		var hp_component: HealthComponent = collider.find_child("HealthComponent")
		if not hp_component: return

		if not DAMAGE:
			hp_component.hp = 0
		else:
			hp_component.hp -= DAMAGE

	if collider.owner.is_in_group("npc"):
		if collider.owner.has_node('Explosion'):
			collider.owner.freeze = true
			var explosion: Explosion = collider.owner.find_child('Explosion')
			explosion.explode()
		else:
			collider.owner.queue_free()
