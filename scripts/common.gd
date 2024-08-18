extends Node

signal death

func player_died():
	emit_signal('death')
