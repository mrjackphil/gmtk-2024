extends Node
class_name HurtEffectComponent

@export var effect_list: Array[Effect] = []

func apply(data: Effect.EffectData) -> void:
	for effect in effect_list:
		effect.apply(data)
