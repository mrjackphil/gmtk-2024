extends Node
class_name EnemyBehaviorComponent

@export var movement_component: EnemyMovementComponent
@export var rotation_component: EnemyRotationComponent
@export var player_detection_area: Area3D
@export var enemy: CharacterBody3D

enum State {
	idle,
	patrol,
	triggered,
}

var _state: State = State.idle
var _detected_body: Node3D

func _ready():
	player_detection_area.connect('body_entered', _body_detected)
	player_detection_area.connect('body_exited', _body_dissapeared)


func _physics_process(delta):
	var enemy_position: Vector3 = enemy.global_transform.origin
	match _state:
		State.idle:
			_do_idle_state(delta, enemy_position)
		State.patrol:
			_do_patrol_state(delta, enemy_position)
		State.triggered:
			_do_triggered_state(delta, enemy_position)


func _do_idle_state(delta: float, enemy_position: Vector3):
	rotation_component.set_rotation_vector(Vector3.ZERO)
	if movement_component:
		movement_component.set_destination(enemy_position)

func _do_patrol_state(delta: float, enemy_position: Vector3):
	rotation_component.set_rotation_vector(Vector3.ZERO)
	if movement_component:
		movement_component.set_destination(enemy_position)

func _do_triggered_state(delta: float, enemy_position: Vector3):
	var target_position: Vector3 = _detected_body.global_transform.origin
	rotation_component.set_rotation_vector(target_position)
	if movement_component:
		movement_component.set_destination(Vector3(target_position.x, 0, target_position.z))


func _body_detected(body: Node3D):
	if not body.is_in_group('player'):
		return

	_detected_body = body
	_state = State.triggered


func _body_dissapeared(body: Node3D):
	if not body.is_in_group('player'):
		return

	_state = State.idle
	_detected_body = null
