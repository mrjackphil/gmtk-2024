extends Node
class_name CameraMouseMoveComponent


@export var _root: Node3D
@export var _yaw: Node3D
@export var _camera: Camera3D
@export var CAMERA_ROTATION_SENSITIVITY: int = 400

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if not _camera.current: return
	
	if event is InputEventMouseButton and Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	
	if event is InputEventMouseMotion:
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
				return

		var camera_rotation: float = _yaw.rotation.x - event.relative.y / CAMERA_ROTATION_SENSITIVITY

		_root.rotation.y -= event.relative.x / CAMERA_ROTATION_SENSITIVITY
		_yaw.rotation.x = clamp(camera_rotation, -1.5, 1.5)
