extends Node2D

@onready var mute_btn: TextureButton = $Control/MarginContainer2/AudioButtonOff
@onready var sound_btn: TextureButton = $Control/MarginContainer2/AudioButtonOn

@export var first_scene: PackedScene

func _on_audio_button_on_pressed():
	Music.stop()
	mute_btn.visible = true
	sound_btn.visible = false


func _on_audio_button_off_pressed():
	Music.play()
	mute_btn.visible = false
	sound_btn.visible = true


func _on_start_button_pressed():
	get_tree().change_scene_to_packed(first_scene)
