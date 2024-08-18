extends Area3D

@export var _hp := 1

signal dead

var hp: int:
	get:
		return _hp
	set(v):
		_hp = v
		if _hp <= 0:
			dead.emit()
			_dead()
			
func _dead() -> void:
	get_parent().queue_free()

func _ready() -> void:
	area_entered.connect(_hurt)
	dead.connect(print)

func _hurt(area: Area3D) -> void:
	hp -= 1
	area.get_parent().queue_free()
