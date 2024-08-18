extends Node
class_name EnemyBehaviorComponent

@export var movement_component: EnemyMovementComponent
@export var rotation_component: EnemyRotationComponent
@export var player_detection_area: Area3D
@export var enemy: CharacterBody3D
@export var flying_enemy: bool = false
@export var looses_player: bool = false

enum State {
	idle,
	patrol,
	triggered,
}

var _state: State = State.idle
var _detected_body: Node3D

func _ready() -> void:
	player_detection_area.connect('body_entered', _body_detected)
	if looses_player:
		player_detection_area.connect('body_exited', _body_dissapeared)


func _physics_process(delta: float) -> void:
	var enemy_position: Vector3 = enemy.global_transform.origin
	match _state:
		State.idle:
			_do_idle_state(delta, enemy_position)
		State.patrol:
			_do_patrol_state(delta, enemy_position)
		State.triggered:
			_do_triggered_state(delta, enemy_position)


func _do_idle_state(_delta: float, enemy_position: Vector3) -> void:
	rotation_component.set_rotation_vector(Vector3.ZERO)
	if movement_component:
		movement_component.set_destination(enemy_position)

func _do_patrol_state(_delta: float, enemy_position: Vector3) -> void:
	rotation_component.set_rotation_vector(Vector3.ZERO)
	if movement_component:
		movement_component.set_destination(enemy_position)

func _do_triggered_state(_delta: float, _enemy_position: Vector3) -> void:
	var target_position: Vector3 = _detected_body.global_transform.origin
	rotation_component.set_rotation_vector(target_position + Vector3(0, 1.7, 0))
	if movement_component:
		var y: float = 0.0 if not flying_enemy else target_position.y
		movement_component.set_destination(Vector3(target_position.x, y, target_position.z))


func _body_detected(body: Node3D) -> void:
	if not body.is_in_group('player'):
		return

	_detected_body = body
	_state = State.triggered


func _body_dissapeared(body: Node3D) -> void:
	if not body.is_in_group('player'):
		return

	_state = State.idle
	_detected_body = null
