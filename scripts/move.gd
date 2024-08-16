extends Node3D

var SPEED: float = 2.0
var PATROL_TIMER: float = 10.0

var is_right: bool = true
var timer: Timer = Timer.new()

func _ready() -> void:
	add_child(timer)
	timer.start(PATROL_TIMER)
	timer.timeout.connect(_reverse)

func _process(delta: float) -> void:
	if is_right:
		position.x += SPEED * delta
		scale.x = 6
	else:
		position.x -= SPEED * delta
		scale.x = -6

func _reverse() -> void:
	is_right = !is_right
	timer.start(PATROL_TIMER)
	
