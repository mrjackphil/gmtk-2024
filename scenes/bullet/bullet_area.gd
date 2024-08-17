extends RigidBody3D
func _ready() -> void:
	linear_velocity = global_transform.basis.z * -1 * 30
