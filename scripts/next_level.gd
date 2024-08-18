extends Control
class_name NextLevelScene

@onready var next_btn: Button = $CenterContainer/Button
@onready var win_label: Label = $CenterContainer2/Label

var _next_scene: PackedScene

var next_scene: PackedScene:
	get:
		return _next_scene
	set(scene):
		if not scene:
			return

		next_btn.visible = true
		win_label.visible = false
		_next_scene = scene


func _on_button_pressed():
	get_tree().change_scene_to_packed(_next_scene)
