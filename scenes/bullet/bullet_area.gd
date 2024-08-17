extends RigidBody3D

@export var SPEED := 30

func _ready() -> void:
	linear_velocity = global_transform.basis.z * -1 * SPEED
	#body_entered.connect(_destroy)

func _destroy(_arg: Variant) -> void:
	queue_free()
