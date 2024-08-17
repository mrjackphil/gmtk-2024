extends EnemyBehaviorComponent
class_name FlyingBehaviorComponent


func _do_triggered_state(delta: float, enemy_position: Vector3):
	var target_position: Vector3 = _detected_body.global_transform.origin
	rotation_component.set_rotation_vector(target_position + Vector3(0, 1.7, 0))
	if movement_component:
		movement_component.set_destination(Vector3(target_position.x, target_position.y, target_position.z))
