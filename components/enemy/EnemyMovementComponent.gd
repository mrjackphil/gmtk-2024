extends Node
class_name EnemyMovementComponent

@export var char_body: CharacterBody3D
@export var speed_modificator: float = 0
@export var nav: NavigationAgent3D


const _speed: int = 500
const _path_finding_minimum_distance: float = 3

var _destination: Vector3

func set_destination(dest: Vector3):
	_destination = dest


func _ready():
	_destination = char_body.global_transform.origin


func _physics_process(delta: float) -> void:
	var speed := (_speed + speed_modificator) * delta
	var current_position: Vector3 = char_body.global_transform.origin

	var direction: Vector3
	if current_position.distance_to(_destination) > _path_finding_minimum_distance:
		nav.target_position = _destination
		direction = nav.get_next_path_position() - char_body.global_position
		direction.y = _destination.y
	else:
		direction = (_destination - current_position)

	direction = direction.normalized()
	var move_vect: Vector3 = direction.normalized().rotated(Vector3.UP, char_body.rotation.y) * speed

	if move_vect:
		if char_body.find_child("Meshes") == null:
			char_body.velocity.x = move_vect.x
			char_body.velocity.z = move_vect.z
		else:
			char_body.velocity = char_body.get_node("Meshes").global_transform.basis.z * -1 * 10
	else:
		char_body.velocity.x = move_toward(char_body.velocity.x, 0, speed)
		char_body.velocity.z = move_toward(char_body.velocity.z, 0, speed)

	char_body.move_and_slide()
	for col_idx in char_body.get_slide_collision_count():
		var col := char_body.get_slide_collision(col_idx)
		if col.get_collider() is RigidBody3D:
			col.get_collider().apply_central_impulse(-col.get_normal() * 0.3)
			col.get_collider().apply_impulse(-col.get_normal() * 0.01, col.get_position())
