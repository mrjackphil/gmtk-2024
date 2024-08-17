extends RigidBody3D

func _ready() -> void:
	body_entered.connect(_push)

func _push(collider: RigidBody3D) -> void:
	collider.apply_central_impulse(collider.position - global_position)
	collider.apply_impulse(collider.position - global_position, collider.position)
