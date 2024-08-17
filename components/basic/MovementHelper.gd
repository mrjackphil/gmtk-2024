extends Node3D
class_name MovementHelperComponent

@export var ground_check: Area3D
@export var space_check: Area3D
@export var body: CharacterBody3D

func _physics_process(_delta: float) -> void:
	if not space_check or not ground_check or not body:
		printerr("ground_check, body or space_check are not set")
		return

	var forward_movement := Input.is_action_pressed("move_forward")
	var is_crouch := Input.is_action_pressed("move_crouch")
	if body.velocity.x == 0 and not forward_movement: return
	if is_crouch: return

	var overlapped_areas := ground_check.has_overlapping_areas()
	var empty_areas := space_check.has_overlapping_areas()

	if not overlapped_areas or empty_areas:
		return

	body.position.y += 0.15
	body.velocity.y = 0

func _get_configuration_warnings() -> PackedStringArray:
	if not space_check or not ground_check:
		return ["ground_check or space_check are not set"]
	return [""]
