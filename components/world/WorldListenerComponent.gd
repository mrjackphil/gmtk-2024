extends Node
class_name WorldListenerComponent

@export var DeathScreen: Control

func _ready():
	Common.death.connect(_on_player_died)


func _on_player_died():
	DeathScreen.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
