extends Node
class_name ScaleComponent

@export var MIN_SCALE := 1.0
@export var MAX_SCALE := 3.0
@export var SCALE_VELOCITY := Vector3(1.0, 1.0, 1.0)
@export var SCALE_SLOWNESS := 0.5


@export var SHRINK_TIMEOUT := 100
@export var SHRINK_SLOWNESS := 0.5

var _timeout := 0
var target_scale := Vector3.ONE

@onready var parent = get_parent()

func collide() -> void:
	_timeout = SHRINK_TIMEOUT
	target_scale = clamp(target_scale + SCALE_VELOCITY, Vector3(MIN_SCALE, MIN_SCALE, MIN_SCALE), Vector3(MAX_SCALE, MAX_SCALE, MAX_SCALE))

func _get_resized_scale() -> Vector3:
	var x = clamp(target_scale.x, MIN_SCALE, MAX_SCALE)
	var y = clamp(target_scale.y, MIN_SCALE, MAX_SCALE)
	var z = clamp(target_scale.z, MIN_SCALE, MAX_SCALE)
	
	return Vector3(x,y,z)

func _physics_process(delta: float) -> void:
	print(parent.scale)
	if parent.scale >= target_scale * 0.95 and _timeout > 0:
		_timeout -= 1 * delta
		return
		
	if parent.scale != target_scale and _timeout > 0:
		parent.scale = lerp(parent.scale, _get_resized_scale(), SCALE_SLOWNESS * delta)
		return

	if parent.scale > Vector3.ONE * 1.15:
		target_scale = Vector3.ONE
		parent.scale = lerp(parent.scale, Vector3.ONE, SHRINK_SLOWNESS * delta)
	else:
		target_scale = Vector3.ONE
		parent.scale = Vector3.ONE
