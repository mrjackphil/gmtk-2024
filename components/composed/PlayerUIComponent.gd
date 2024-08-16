extends CanvasLayer
class_name PlayerUIComponent

@export var interaction_component: InteractionComponent
@export var cursor: TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not cursor:
		cursor  = $CenterContainer/TextureRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if interaction_component and interaction_component.is_interactable():
		cursor.visible = true
	else: 
		cursor.visible = false

func _get_configuration_warnings() -> PackedStringArray:
	if not interaction_component:
		return ["Interaction component not provided for PlayerUIComponent"]

	return []
