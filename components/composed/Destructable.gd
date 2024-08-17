extends Area3D
class_name Destructable

func _ready() -> void:
	area_entered.connect(_destruction)
	
func _destruction(area: Area3D) -> void:
	print(area.scale)
	if _check_scale(area.get_parent()):
		queue_free()

func _check_scale(area: Node3D) -> bool:
	if area.scale.x > 1: 
		return true
		
	if area.scale.y > 1: 
		return true
	
	if area.scale.z > 1: 
		return true
	
	return false
