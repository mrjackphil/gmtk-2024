extends RigidBody3D

@export var VECTOR_TO_SUM = Vector3(0,0,0)
@export var POWER = 10

func _ready() -> void:
	body_entered.connect(_push)

func _push(collider: RigidBody3D) -> void:
	collider.apply_central_impulse(collider.position - global_position)
	collider.apply_impulse((collider.position - global_position + VECTOR_TO_SUM) * POWER, collider.position)
