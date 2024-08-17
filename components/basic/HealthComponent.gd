extends Node
class_name HealthComponent

@export var hp: int = 10

signal hp_changed(hp: int)
signal hp_end

func heal(points: int) -> int:
	hp += points
	hp_changed.emit(hp)
	return hp

func hurt(damage: int) -> int:
	hp -= damage
	hp_changed.emit(hp)

	if hp <= 0:
		hp_end.emit()

	return hp
