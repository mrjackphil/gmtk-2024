extends RigidBody3D

@export var SPEED := 60

func _ready() -> void:
	linear_velocity = global_transform.basis.z * -1 * SPEED
	body_entered.connect(_stop)
	
func _stop(_arg: Variant) -> void:
	freeze = true
	
func _destroy(_arg: Variant) -> void:
	queue_free()
