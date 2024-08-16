extends Node
class_name ActionComponent

# So, entity can make some actions
# Attack, interact, etc...

func _input(event: InputEvent) -> void:
	if event.is_action_just_pressed("action_use"):
		_attack()

func _attack() -> void:
	print('attack')

