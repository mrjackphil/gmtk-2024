extends RigidBody3D

func _ready() -> void:
	linear_velocity = global_transform.basis.z * -1 * 30
	#body_entered.connect(_destroy)

func _destroy(_arg: Variant) -> void:
	queue_free()
