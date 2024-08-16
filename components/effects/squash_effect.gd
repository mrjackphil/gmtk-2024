extends Effect
class_name SquashEffect

var sprite: SpriteBase3D = null

func apply(data: EffectData) -> void:
	var target: Node3D = data.owner
	
	if target.is_queued_for_deletion():
		return

	# Find sprite (loop, urgh... yeah, I'm lazy to do it better)
	for child in target.get_children():
		if child.is_queued_for_deletion():
			break
