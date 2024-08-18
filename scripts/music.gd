extends AudioStreamPlayer

var music := preload("res://assets/sounds/music.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	stream = music
	stream.set_loop(true)
	volume_db = -40
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
