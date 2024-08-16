extends Area3D
class_name HitboxComponent

signal was_hit(area: Area3D)

func _init() -> void:
	area_entered.connect(_area_entered)

func _area_entered(area: Area3D) -> void:
	if area.is_in_group("player_weapon"):
		was_hit.emit(area)
