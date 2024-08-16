extends Interaction
class_name KillerInteraction

func interact(owner: Node3D, _node: Node3D) -> void:
	owner.queue_free()
	ended.emit()
