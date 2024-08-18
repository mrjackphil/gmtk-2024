extends Node

signal death
signal win_level


func player_died():
	emit_signal('death')


func player_win_level(next_level: PackedScene):
	emit_signal('win_level', next_level)
