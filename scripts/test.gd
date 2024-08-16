extends SceneTree

var icon_sprite = preload("res://icon.svg")

func _init() -> void:
	var sprite := Sprite2D.new()
	sprite.texture = icon_sprite
	sprite.position.x = 20
	sprite.position.y = 20

	current_scene.append_child(sprite)

func _process(_delta: float) -> bool:
	if Input.is_key_pressed(KEY_ESCAPE):
		print("KEY_ESCAPE pressed, quitting")
		return true

	return false


## So... Dynamic combat...
func combat_emulation() -> void: 
	pass
