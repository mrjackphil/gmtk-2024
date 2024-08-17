extends Node
class_name MovementComponent

@export var char_body: CharacterBody3D

func _ready() -> void:
	coyote_timer.one_shot = true
	coyote_timer.timeout.connect(_unallow_jump)
	char_body.add_child.call_deferred(coyote_timer) 

func _unallow_jump() -> void:
	can_jump = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not char_body.is_on_floor() or char_body.position.y > 0:
		char_body.velocity.y -= gravity * delta

	if char_body.position.y < 0:
		char_body.velocity.y = 0
		char_body.position.y = 0

	var speed: int = _sprint_handler(delta)

	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_backward", "move_forward")
	var move_vect: Vector3 = Vector3(input_dir.x, 0, -input_dir.y).normalized().rotated(Vector3.UP, char_body.rotation.y) * speed
	# Accelerate
	if move_vect:
		char_body.velocity.x = move_vect.x
		char_body.velocity.z = move_vect.z
	# Deccelerate
	else:
		char_body.velocity.x = move_toward(char_body.velocity.x, 0, speed)
		char_body.velocity.z = move_toward(char_body.velocity.z, 0, speed)

	_crouch_handler(delta)
	_jump_handler(delta)
	char_body.move_and_slide()

###########################################################

@export var camera: Camera3D

const MOVEMENT_SPEED: int = 500
const SPRINT_MULTIPLIER: float = 1.5
const CROUCH_MULTIPLIER: float = 0.5
const CAMERA_FOV_DEFAULT: float = 75.0
const CAMERA_FOV_SPRINT: float = 90.0
@export var EXTERNAL_MODIFICATOR: int = 0

func _sprint_handler(delta: float) -> int:
	var speed := (MOVEMENT_SPEED + EXTERNAL_MODIFICATOR) * delta
	var is_on_floor := char_body.is_on_floor() or char_body.position.y == 0

	if Input.is_action_pressed("move_crouch") and is_on_floor:
		speed *= CROUCH_MULTIPLIER
	elif Input.is_action_pressed("move_sprint"):
		speed *= SPRINT_MULTIPLIER
		camera.fov = lerp(camera.fov, CAMERA_FOV_SPRINT, 0.1)
	else:
		camera.fov = lerp(camera.fov, CAMERA_FOV_DEFAULT, 0.1)
	
	return int(speed)

###########################################################

@export var walk_collision: CollisionShape3D
@export var crouch_collision: CollisionShape3D
@export var ceiling_check: Area3D
@export var camera_root: Node3D

var is_crouching := false
@onready var initial_camera_position := camera_root.position.y

func _crouch_handler(delta: float) -> void:
	if Input.is_action_pressed("move_crouch"):
		is_crouching = true
	elif ceiling_check.get_overlapping_areas().size() == 0: 
		is_crouching = false

	if is_crouching:
		walk_collision.disabled = true
		crouch_collision.disabled = false
		camera_root.position.y = lerp(camera_root.position.y, initial_camera_position / 2, 10 * delta)
	else:
		walk_collision.disabled = false
		crouch_collision.disabled = true
		camera_root.position.y = lerp(camera_root.position.y, initial_camera_position, 10 * delta)

###########################################################

var JUMP_STRENGTH: int = 8
var COYOTE_TIME: float = 0.1

var can_jump := true
# Start "coyote timer"
var coyote_timer: Timer = Timer.new()
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _jump_handler(delta: float) -> void:
	# Jump
	if Input.is_action_just_pressed("move_jump") and can_jump:
		char_body.velocity.y = JUMP_STRENGTH
		can_jump = false
		coyote_timer.stop()
	elif char_body.position.y > 0 and not char_body.is_on_floor():
		char_body.velocity.y -= gravity * delta

		# Start "coyote timer"
		if coyote_timer.is_stopped():
			coyote_timer.start(COYOTE_TIME)

	elif char_body.position.y < 0:
		char_body.position.y = 0
		char_body.velocity.y = 0
		coyote_timer.stop()
		can_jump = true
	else:
		char_body.velocity.y = 0
		coyote_timer.stop()
		can_jump = true

###########################################################

func _get_configuration_warnings() -> PackedStringArray:
	if not char_body:
		return ["Character Body is not provided in MovementComponent"]
	return []
