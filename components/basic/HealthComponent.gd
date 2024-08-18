extends Node
class_name HealthComponent

var _hp: int = 10
@export var hp: int:
	get:
		return _hp
	set(v):
		_hp = v
		hp_changed.emit(_hp)

		if _hp <= 0:
			hp_end.emit()

@export var gun: Node3D
@export var main_camera: Camera3D
@export var death_camera: Camera3D

@export var movement_component: MovementComponent
@export var combat_component: PlayerCombatComponent

var _already_died: bool = false

signal hp_changed(hp: int)
signal hp_end

func _ready() -> void:
	hp_end.connect(_dead)

func _dead() -> void:
	if _already_died:
		return

	_already_died = true

	gun.visible = false
	death_camera.make_current()
	movement_component.process_mode = Node.PROCESS_MODE_DISABLED
	combat_component.process_mode = Node.PROCESS_MODE_DISABLED
	Common.player_died()
