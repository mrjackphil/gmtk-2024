extends Enemy

@export var looses_player: bool = false
@export var speed_modificator: float = 0.0

@onready var _behavior_component: EnemyBehaviorComponent = $Components/EnemyBehaviorComponent
@onready var _movement_component: EnemyMovementComponent = $Components/EnemyMovementComponent

func _ready():
	_behavior_component.looses_player = looses_player
	_movement_component.speed_modificator = speed_modificator

func _physics_process(delta):
	pass
