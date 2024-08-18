extends RigidBody3D

@export var SPEED := 100
var to_kill := false
var timer_to_destroy := 5
@export var scale_down := false

func _ready() -> void:
	linear_velocity = global_transform.basis.z * -1 * SPEED
	body_entered.connect(_destroy)

func _process(_delta: float) -> void:
	if to_kill:
		timer_to_destroy -= 1
	if timer_to_destroy <= 0:
		queue_free()

func _stop(_arg: Variant) -> void:
	freeze = true

func _destroy(_arg: Variant) -> void:
	if not to_kill: to_kill = true
