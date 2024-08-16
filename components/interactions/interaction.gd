extends Resource
class_name Interaction

signal ended

func interact(owner: Node3D, node: Node3D) -> void:
	owner.queue_free()
	ended.emit()

