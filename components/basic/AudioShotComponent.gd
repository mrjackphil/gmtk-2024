extends AudioStreamPlayer

@export var combat_component: PlayerCombatComponent

func _ready() -> void:
	combat_component.shoot_signal.connect(_play)
	
func _play() -> void:
	play()
