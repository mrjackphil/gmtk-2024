extends RigidBody3D

func _ready() -> void:
	body_entered.connect(_push)

func _push(collider: RigidBody3D) -> void:
	collider.apply_central_impulse(-collider.get_normal() * 0.3)
	collider.apply_impulse(-collider.get_normal() * 0.01, collider.get_position())
