extends CharacterBody3D
class_name Enemy

var _gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func set_gravity(gravity: float):
	_gravity = gravity

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() or position.y > 0:
		velocity.y -= _gravity * delta

	if position.y < 0:
		velocity.y = 0
		position.y = 0
