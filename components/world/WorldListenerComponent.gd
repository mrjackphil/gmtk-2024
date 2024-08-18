extends Node
class_name WorldListenerComponent

@export var DeathScreen: Control
@export var NextLevelScreen: NextLevelScene
@export var LevelTimer: TimerComponent


func _ready():
	Common.death.connect(_on_player_died)
	Common.win_level.connect(_on_player_win_level)


func _on_player_died():
	LevelTimer.stop()
	DeathScreen.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_player_win_level(next_level: PackedScene):
	LevelTimer.stop()
	NextLevelScreen.next_scene = next_level
	NextLevelScreen.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
