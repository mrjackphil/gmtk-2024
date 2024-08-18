extends Node
class_name WorldListenerComponent

@export var DeathScreen: Control
@export var NextLevelScreen: NextLevelScene


func _ready():
	Common.death.connect(_on_player_died)
	Common.win_level.connect(_on_player_win_level)


func _on_player_died():
	DeathScreen.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_player_win_level(next_level: PackedScene):
	NextLevelScreen.next_scene = next_level
	NextLevelScreen.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
