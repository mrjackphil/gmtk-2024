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

@onready var bullet = preload("res://scenes/bullet.tscn")


var animations := {
	"attack": "player_anims/1h_attack",
	"idle": "player_anims/idle",
}

func _ready() -> void:
	rhand_anim_player.connect("animation_finished", _idle)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("combat_attack"):
		attack()

func _idle(_anim_string: String) -> void:
	rhand_anim_player.play(animations.idle)

func shoot() -> void:
	
	#var collider := shoot_raycast.get_collider()
	
	#if not collider: return
	#collider.scale *= 2
	var b = bullet.instantiate()
	b.transform = bullet_placement.global_transform
	b.linear_velocity = bullet_placement.global_transform.basis.z * -1 * 30
	bullet_placement.add_child(b)
	
	print("bullet_placement", camera_root.rotation)
	print("bullet", b.rotation)

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
