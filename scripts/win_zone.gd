extends CSGBox3D

@export var next_level: PackedScene

func _ready():
	$WinOnTouch.next_level = next_level
