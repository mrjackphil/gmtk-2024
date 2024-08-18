extends Area3D
class_name WinOnTouch

@export var next_level: PackedScene

func _ready() -> void:
	area_entered.connect(_collide)

func _collide(collider: Node3D) -> void:
	if collider.owner.is_in_group("player"):
		collider.owner.find_child("MovementComponent").process_mode = Node.PROCESS_MODE_DISABLED
		collider.owner.find_child("CombatComponent").process_mode = Node.PROCESS_MODE_DISABLED
		collider.owner.find_child("CameraMouseMoveComponent").process_mode = Node.PROCESS_MODE_DISABLED
		Common.player_win_level(next_level)
