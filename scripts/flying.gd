extends Enemy

@export var looses_player: bool = false

func _ready():
	$Components/EnemyBehaviorComponent.looses_player = looses_player

func _physics_process(delta):
	pass
