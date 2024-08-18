extends Node
class_name EnemyRotationComponent

@export var rotation_body: Node3D

@export var rotation_speed: float = 5

var _rotation_vector: Vector3 = Vector3.ZERO

func set_rotation_vector(vect: Vector3) -> void:
	_rotation_vector = vect


func _physics_process(_delta: float) -> void:
	if _rotation_vector == Vector3.ZERO:
		return

	#var current_direction: Vector3 = rotation_body.global_transform.basis.z.normalized()
	#var vect: Vector3 = current_direction.lerp(_rotation_vector, 0.01)

	#rotation_body.rotation = vect
	#var tr: Transform3D = rotation_body.global_transform
	var tmp_scale := rotation_body.scale
	var player: CharacterBody3D = get_node("/root/World/Player")
	var tr_look: Transform3D = rotation_body.global_transform.looking_at(player.global_position, Vector3.UP)
	#rotation_body.global_transform = tr
	rotation_body.global_transform = rotation_body.global_transform.interpolate_with(tr_look, 0.1)
	rotation_body.scale = tmp_scale
