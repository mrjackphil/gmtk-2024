extends Interaction
class_name TalkInteraction

func interact(owner: Node3D, node: Node3D) -> void:
	if Dialogic.current_timeline != null:
			return

	var layout := Dialogic.start('hello')
	layout.register_character(load("res://assets/dialogic_characters/ork.dch"), owner)

	Dialogic.timeline_ended.connect(_end_dialogue)
	# owner.get_viewport().set_input_as_handled()

func _end_dialogue() -> void:
	ended.emit()


