extends Node
class_name EnemyMovementComponent

@export var char_body: CharacterBody3D
@export var speed_modificator: int = 0
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
	else:
		direction = (_destination - current_position)

	direction = direction.normalized()
	var move_vect: Vector3 = Vector3(direction.x, 0, direction.z).normalized().rotated(Vector3.UP, char_body.rotation.y) * speed

	# Accelerate
	if move_vect:
		char_body.velocity.x = move_vect.x
		char_body.velocity.y += move_vect.y
		char_body.velocity.z = move_vect.z
	# Deccelerate
	else:
		char_body.velocity.x = move_toward(char_body.velocity.x, 0, speed)
		char_body.velocity.z = move_toward(char_body.velocity.z, 0, speed)

	char_body.move_and_slide()
