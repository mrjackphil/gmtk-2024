extends Area3D
class_name ShootAtPlayer

func _ready() -> void:
	area_entered.connect(_collide)
	area_exited.connect(_loose)

var target: Node3D
@export var SHOOT_TIMEOUT := 100
var _timeout := 0

var bullet := preload("res://scenes/enemy_bullet/enemy_bullet.tscn")

func _loose(_collider: Node3D) -> void:
	target = null

func _collide(collider: Node3D) -> void:
	if collider.owner.is_in_group("player"):
		target = collider.owner

func _physics_process(_delta: float) -> void:
	if target and _timeout <= 0:
		var t := target.find_child("Target")
		if t:
			target = t

		look_at(target.global_position)
		var instnance := bullet.instantiate()
		instnance.transform = global_transform
		add_child(instnance)
		_timeout = SHOOT_TIMEOUT

	if _timeout > 0:
		_timeout -= 1
