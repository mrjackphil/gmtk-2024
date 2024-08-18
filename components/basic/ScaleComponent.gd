extends Node
class_name ScaleComponent
# To work: parent object should have Area3D trigger with according collision
# layer. It's LAYER 4 for now.

@export var MIN_SCALE := 1.0
@export var MAX_SCALE := 3.0
@export var SCALE_VELOCITY := Vector3(1.0, 1.0, 1.0)
@export var SCALE_SLOWNESS := 0.5

@export var SHRINK_TIMEOUT := 100
@export var SHRINK_SLOWNESS := 0.5

var _timeout := 0.0
var _scaling_up := false
var target_scale := Vector3.ONE

@export var target: Node3D
@onready var parent: Node3D = get_parent()

@export var sfx: AudioStream = preload("res://assets/sounds/sci-fi_weapon_ray_gun_laser_small_fun_01.wav")
var stream_player := AudioStreamPlayer.new()

func _ready() -> void:
	stream_player.stream = sfx
	stream_player.volume_db = -10
	add_child(stream_player)

func _get_collider() -> Node3D:
	if target:
		return target

	return parent

func collide(scale_down: bool = false) -> void:
	stream_player.play()
	_scaling_up = true
	_timeout = SHRINK_TIMEOUT
	
	var _modificator = 1
	if scale_down: _modificator = -1
	
	target_scale.x = clamp(_get_collider().scale.x + (SCALE_VELOCITY.x * _modificator), MIN_SCALE, MAX_SCALE)
	target_scale.y = clamp(_get_collider().scale.y + (SCALE_VELOCITY.y * _modificator), MIN_SCALE, MAX_SCALE)
	target_scale.z = clamp(_get_collider().scale.z + (SCALE_VELOCITY.z * _modificator), MIN_SCALE, MAX_SCALE)

func _vec_more_each(vec1: Vector3, vec2: Vector3) -> bool:
	var x: bool = (abs(vec1.x - vec2.x) < 0.05)
	var y: bool = (abs(vec1.y - vec2.y) < 0.05)
	var z: bool = (abs(vec1.x - vec2.y) < 0.05)

	return x and y and z

func _physics_process(delta: float) -> void:
	if _vec_more_each(_get_collider().scale, target_scale):
		_scaling_up = false

	if _scaling_up:
		_get_collider().scale = lerp(_get_collider().scale, target_scale, SCALE_SLOWNESS * delta)

	if  not _scaling_up and _timeout > 0.0:
		_timeout -= 1.0
		return

	if not _scaling_up and _timeout <= 0.0:
		_get_collider().scale = lerp(_get_collider().scale, Vector3.ONE, SHRINK_SLOWNESS * delta)
