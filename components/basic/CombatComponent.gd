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

@export var ui: PlayerUIComponent

@onready var bullet := preload("res://scenes/bullet/bullet.tscn")

signal shoot_signal
signal force_signal

const FORCE_POWER = 0.1
const SHOOT_TIMEOUT := 14.0
var shoot_timeout := 0.0

var animations := {
	"attack": "player_anims/1h_attack",
	"idle": "player_anims/idle",
	"shoot": "player_anims/shoot"
}

func _ready() -> void:
	rhand_anim_player.connect("animation_finished", _idle)

func _process(_delta: float) -> void:
	if shoot_timeout >= 0: shoot_timeout -= 1.0
	
	ui.grab = shoot_raycast.is_colliding()
	
	if Input.is_action_pressed("combat_attack"):
		attack()
		
	if Input.is_action_pressed("combat_defense"):
		push()

func _idle(_anim_string: String) -> void:
	rhand_anim_player.play(animations.idle)

func shoot(scale_down: bool = false) -> void:
	if shoot_timeout > 0:
		return
	
	shoot_timeout = SHOOT_TIMEOUT
	rhand_anim_player.stop()
	rhand_anim_player.play(animations.shoot)
	shoot_signal.emit()

	var b := bullet.instantiate()
	b.transform = bullet_placement.global_transform
	b.scale_down = scale_down
	bullet_placement.add_child(b)

func attack() -> void:
	shoot()

# Kick, push, bash
func push() -> void:
	shoot(true)
	#return
	#var collider := shoot_raycast.get_collider()
	#if collider and collider is RigidBody3D:
		#collider.apply_impulse((owner.global_position - collider.position) * FORCE_POWER, owner.global_position - collider.position)
		#force_signal.emit()
	#if collider and collider.owner is RigidBody3D:
		#collider.owner.apply_impulse((owner.global_position - collider.owner.position) * FORCE_POWER, owner.global_position - collider.owner.position)
		#force_signal.emit()

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
