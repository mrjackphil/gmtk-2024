extends Resource
class_name Effect

class EffectData:
	var owner: Node3D
	var applier: Node3D

	func _init(o: Node3D, a: Node3D) -> void:
		owner = o
		applier = a

func apply(_data: EffectData) -> void:
	printerr("Effect should override apply()")
