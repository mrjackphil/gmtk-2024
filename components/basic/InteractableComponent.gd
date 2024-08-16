extends Node3D
class_name InteractableComponent

@export var mesh: GeometryInstance3D
@onready var outline_material: ShaderMaterial = preload("res://assets/outline.material")

@export var interations: Array[Interaction] = []

signal interacted

func interact(node: Node3D) -> void:
	for interaction in interations:
		var parent_owner: Node3D = get_parent() if owner == get_tree().current_scene else owner
		interaction.interact(parent_owner, node)
		await interaction.ended
	# mesh.material_overlay.set_shader_parameter("outline_width", 2)

# func _process(delta: float) -> void:
# 	var outline_width: int = mesh.material_overlay.get_shader_parameter("outline_width")
# 	mesh.material_overlay.set_shader_parameter("outline_width", lerp(float(outline_width), 0.0, 0.1 * delta))
# 	
# func _ready() -> void:
# 	mesh.material_overlay = outline_material
# 	mesh.material_overlay.set_shader_parameter("outline_width", 0)

func _get_configuration_warnings() -> PackedStringArray:
	var child := get_child(0)
	if not child:
		return ["There should be Area3D child"]

	if not child is Area3D:
		return ["Should have one child. And it should be Area3D"]

	return [""]
