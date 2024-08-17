extends Node 
class_name PlayerCombatComponent

@export var rhand_anim_player: AnimationPlayer
@export var lhand_anim_player: AnimationPlayer
@export var movement_component: MovementComponent

@export var raycast: RayCast3D
@export var shoot_raycast: RayCast3D
@export var bullet_placement: Node3D
@export var camera_root: Node3D
# @export var inventory_component: InventoryComponent

@onready var bullet = preload("res://scenes/bullet/bullet.tscn")

const SHOOT_TIMEOUT := 14
var shoot_timeout := 0

var animations := {
	"attack": "player_anims/1h_attack",
	"idle": "player_anims/idle",
	"shoot": "player_anims/shoot"
}

func _ready() -> void:
	rhand_anim_player.connect("animation_finished", _idle)

func _process(delta: float) -> void:
	if shoot_timeout >= 0: shoot_timeout -= (1 * delta)
	
	if Input.is_action_pressed("combat_attack"):
		attack()

func _idle(_anim_string: String) -> void:
	rhand_anim_player.play(animations.idle)

func shoot() -> void:
	if shoot_timeout > 0:
		return
	
	shoot_timeout = SHOOT_TIMEOUT
	rhand_anim_player.stop()
	rhand_anim_player.play(animations.shoot)

	var b = bullet.instantiate()
	b.transform = bullet_placement.global_transform
	bullet_placement.add_child(b)

func attack() -> void:
	shoot()

# Kick, push, bash
func push() -> void:
	rhand_anim_player.play("defense")

func dash() -> void: 
	rhand_anim_player.play("defense")

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := []

	var entities := {
		"rhand_anim_player": rhand_anim_player,
		# "inventory_component": inventory_component,
	}

	for key: String in entities:
		if not entities[key]:
			warnings.push_front(key + "is missing in PlayerCombatComponent")

	return warnings
