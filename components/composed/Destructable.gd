extends Area3D
class_name Destructable

@export var SCALE_TRESHOLD := 1.2

func _ready() -> void:
	area_entered.connect(_destruction)

func _destruction(area: Area3D) -> void:
	print(area.get_parent().scale)
	if _check_scale(area.get_parent()):
		queue_free()

func _check_scale(area: Node3D) -> bool:
	if area.scale.x > SCALE_TRESHOLD:
		return true

	if area.scale.y > SCALE_TRESHOLD:
		return true

	if area.scale.z > SCALE_TRESHOLD:
		return true

	return false
