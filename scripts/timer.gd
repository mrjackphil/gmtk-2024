extends Control
class_name TimerComponent

@onready var _timer_label: Label = $MarginContainer/HBoxContainer/Label
@onready var _timer: Timer = $Timer

var _level_time_secs : float = 0.0

func stop():
	_timer.stop()

func _on_timer_timeout():
	_level_time_secs += 1
	var mins: int = int(_level_time_secs / 60.0)
	var secs: int = _level_time_secs - mins * 60
	_timer_label.text = "%02d:%02d" % [mins, secs]
