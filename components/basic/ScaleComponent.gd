extends Node
class_name ScaleComponent

@export var MIN_SCALE := 1.0
@export var MAX_SCALE := 3.0
@export var SCALE_MULTIPLIER := 2.0
@export var SCALE_ENABLE := Vector3(1.0, 1.0, 1.0)

func collide() -> void:
	var parent = get_parent()
	parent.scale = clamp(parent.scale + (SCALE_MULTIPLIER * SCALE_ENABLE), Vector3(MIN_SCALE, MIN_SCALE, MIN_SCALE), Vector3(MAX_SCALE, MAX_SCALE, MAX_SCALE))
