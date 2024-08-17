extends Node
class_name EnemyRotationComponent

@export var rotation_body: Node3D

@export var rotation_speed: float = 5

var _rotation_vector: Vector3 = Vector3.ZERO


func set_rotation_vector(vect: Vector3):
	_rotation_vector = vect


func _physics_process(delta: float) -> void:
	if _rotation_vector == Vector3.ZERO:
		return

	var current_direction: Vector3 = rotation_body.global_transform.basis.z.normalized()
	var vect: Vector3 = current_direction.lerp(_rotation_vector, rotation_speed * delta)
	rotation_body.look_at(_rotation_vector)
	#var tr: Transform3D = rotation_body.global_transform

	#var tr: Transform3D = rotation_body.global_transform.looking_at(vect, Vector3.UP)
	#rotation_body.global_transform = tr
	#rotation_body.global_transform = rotation_body.global_transform.interpolate_with(tr, rotation_speed * delta)
