extends Node

var player: CharacterBody3D
var timer: Timer = Timer.new()
@onready var npc := preload("res://scenes/npc.tscn")

var TIMER_TIME: float = 1.0
var ENEMY_MAX_COUNT: int = 5
var ENEMY_DISTANCE: int = 5

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
	add_child(timer)
	timer.start(TIMER_TIME)
	timer.timeout.connect(_spawn_enemy)

func _spawn_enemy() -> void:
	timer.start(TIMER_TIME)

	var world := get_tree().root.get_node("World")
	if not world:
		push_error("There is no tree to get")

	var enemies_count := get_tree().get_nodes_in_group("npc").size()

	if enemies_count < ENEMY_MAX_COUNT:
		var npc_instance := npc.instantiate()
		npc_instance.position = player.position + Vector3(randi_range(-ENEMY_DISTANCE, ENEMY_DISTANCE), 0.5, randi_range(-ENEMY_DISTANCE, ENEMY_DISTANCE))

		world.add_child(npc_instance)

