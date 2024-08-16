extends Node
class_name ShrinkComponent

@export var shinkable_object: Node3D
func _ready() -> void:
	if not shinkable_object:
		shinkable_object = get_parent()
		
func _physics_process(delta: float) -> void:
	if shinkable_object.scale != Vector3.ONE:
		shinkable_object.scale = lerp(shinkable_object.scale, Vector3.ONE, 0.05)
