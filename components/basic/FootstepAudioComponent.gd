extends AudioStreamPlayer

@export var movement_component: MovementComponent
@export var combat_component: PlayerCombatComponent

var STEP_TIMER := 25
var RUN_TIMER := 15
var _timer := 10

func _ready() -> void:
	movement_component.move_signal.connect(_step)

func _process(_delta: float) -> void:
	if _timer > 0: _timer -= 1

func _step(is_on_floor: bool, is_crouching: bool, is_sprinting: bool) -> void:
	if _timer <= 0 and is_on_floor and not is_crouching and not is_sprinting:
		_timer = STEP_TIMER
		play()

	elif _timer <= 0 and is_on_floor and not is_crouching and is_sprinting:
		_timer = RUN_TIMER
		play()
