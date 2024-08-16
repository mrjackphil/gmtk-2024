extends Effect
class_name PushEffect

@export var PUSH_UP_STRENGTH: int = 5
@export var PUSH_BACK_STRENGTH: int = 10

func apply(data: EffectData) -> void:
	var target: Node3D = data.owner
	var who_damaged: Node3D = data.applier

	target.velocity.x = (target.global_position.x - who_damaged.global_position.x) * PUSH_BACK_STRENGTH
	target.velocity.z = (target.global_position.z - who_damaged.global_position.z) * PUSH_BACK_STRENGTH
	target.velocity.y = PUSH_UP_STRENGTH
