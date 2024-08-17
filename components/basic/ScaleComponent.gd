extends Node
class_name ScaleComponent

@export var MIN_SCALE := 1.0
@export var MAX_SCALE := 3.0
@export var SCALE_VELOCITY := Vector3(1.0, 1.0, 1.0)
@export var SCALE_SLOWNESS := 0.5


@export var SHRINK_TIMEOUT := 100
@export var SHRINK_SLOWNESS := 0.5

var _timeout := 0

@onready var parent = get_parent()


func collide() -> void:
	_timeout = SHRINK_TIMEOUT

func _get_resized_scale() -> Vector3:
	var x = clamp(parent.scale.x + SCALE_VELOCITY.x, MIN_SCALE, MAX_SCALE)
	var y = clamp(parent.scale.y + SCALE_VELOCITY.y, MIN_SCALE, MAX_SCALE)
	var z = clamp(parent.scale.z + SCALE_VELOCITY.z, MIN_SCALE, MAX_SCALE)

	return Vector3(x,y,z)

func _physics_process(delta: float) -> void:
	if _timeout > 0:
		_timeout -= 1 * delta
		parent.scale = lerp(parent.scale, _get_resized_scale(), SCALE_SLOWNESS * delta)
		return

	if parent.scale != Vector3.ONE:
		parent.scale = lerp(parent.scale, Vector3.ONE, SHRINK_SLOWNESS * delta)
