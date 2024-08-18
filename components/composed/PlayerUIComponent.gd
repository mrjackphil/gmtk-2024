extends CanvasLayer
class_name PlayerUIComponent

@export var cursor: TextureRect
@export var grab := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$CenterContainer/TextureRect3.visible = grab

func _get_configuration_warnings() -> PackedStringArray:
	return []
