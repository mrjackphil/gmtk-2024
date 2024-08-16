extends Interaction
class_name SliderInteraction

@export var relative_position: Vector3 = Vector3.FORWARD

var toggled: bool = false
var initial_position: Vector3

func interact(owner: Node3D, _node: Node3D) -> void:
	if not initial_position:
		initial_position = owner.position

	_move(owner)
	toggled = !toggled

func _move(node: Node3D) -> void:
	if toggled:
		node.position = node.position + relative_position
	else:
		node.position = initial_position

