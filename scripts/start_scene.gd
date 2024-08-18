extends Node2D

@onready var mute_btn: TextureButton = $Control/MarginContainer2/AudioButtonOff
@onready var sound_btn: TextureButton = $Control/MarginContainer2/AudioButtonOn

var first_scene = "res://world.tscn"

func _on_audio_button_on_pressed():
	# TODO: stop sounds
	mute_btn.visible = true
	sound_btn.visible = false


func _on_audio_button_off_pressed():
	# TODO: start sounds
	mute_btn.visible = false
	sound_btn.visible = true


func _on_start_button_pressed():
	get_tree().change_scene_to_file(first_scene)
