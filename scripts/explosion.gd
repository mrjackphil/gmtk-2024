extends Node3D
class_name Explosion

@export var exploding_object: Node3D

@onready var _debris = $Debris
@onready var _smoke = $Smoke
@onready var _fire = $Fire

func explode():
	exploding_object.visible = false
	_debris.emitting = true
	_smoke.emitting = true
	_fire.emitting = true
	await get_tree().create_timer(2.0).timeout
	exploding_object.queue_free()
