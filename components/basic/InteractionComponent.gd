extends Node
class_name InteractionComponent

@export var raycast: RayCast3D
# @export var cursor: Control
# @export var _input_component: InputComponent

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("action_use"):
		interact()

func interact() -> void:
	var collider: Area3D = raycast.get_collider()

	if not collider: return
	if not raycast.is_colliding(): return

	var collider_parent: Node3D = collider.get_parent()
	if collider_parent is InteractableComponent:
		collider_parent.interact(owner)

func is_interactable() -> bool:
	if raycast.is_colliding():
		var collider: Area3D = raycast.get_collider()

		if not collider: return false
			
		var collider_parent := collider.get_parent()
		if collider_parent is InteractableComponent:
			return true
		return false
	else:
		# cursor.visible = false
		return false

func _ready() -> void:
	# _input_component.interact.connect(_interact)
	pass

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array[String] = []
	if not raycast:
		return ["There is no raycast provided"]
		# warnings.push_front("There is no raycast provided")

	return warnings
