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
	target_scale.x = clamp(target_scale.x + SCALE_VELOCITY.x, MIN_SCALE, MAX_SCALE)
	target_scale.y = clamp(target_scale.y + SCALE_VELOCITY.y, MIN_SCALE, MAX_SCALE)
	target_scale.z = clamp(target_scale.z + SCALE_VELOCITY.z, MIN_SCALE, MAX_SCALE)

func _vec_more_each(vec1: Vector3, vec2: Vector3) -> bool:
	var x = vec1.x > vec2.x
	var y = vec1.y > vec2.y
	var z = vec1.z > vec2.z
	
	return x and y and z

func _physics_process(delta: float) -> void:
	if _vec_more_each(parent.scale, target_scale * 0.95) and _timeout > 0:
		_timeout -= 1 * delta
		return
		
	if _timeout > 0:
		parent.scale = lerp(parent.scale, target_scale, SCALE_SLOWNESS * delta)
		return

	target_scale = Vector3.ONE
	parent.scale = lerp(parent.scale, Vector3.ONE, SHRINK_SLOWNESS * delta)
