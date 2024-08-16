extends Node 
class_name PlayerCombatComponent

@export var rhand_anim_player: AnimationPlayer
@export var lhand_anim_player: AnimationPlayer
@export var movement_component: MovementComponent

@export var raycast: RayCast3D
@export var shoot_raycast: RayCast3D
# @export var inventory_component: InventoryComponent
@export var interaction_component: InteractionComponent


var animations := {
	"attack": "player_anims/1h_attack",
	"idle": "player_anims/idle",
}

func _ready() -> void:
	rhand_anim_player.connect("animation_finished", _idle)

func _process(_delta: float) -> void:
	var can_interact := false

	if interaction_component:
		can_interact = interaction_component.raycast.is_colliding()

	if can_interact: return

	if Input.is_action_just_pressed("combat_attack"):
		attack()

func _idle(_anim_string: String) -> void:
	rhand_anim_player.play(animations.idle)

func shoot() -> void:
	if not shoot_raycast or not shoot_raycast.is_colliding(): return
	
	var collider := shoot_raycast.get_collider()
	collider.scale *= 2

func attack() -> void:
	shoot()
	pass

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
		"interaction_component": interaction_component
	}

	for key: String in entities:
		if not entities[key]:
			warnings.push_front(key + "is missing in PlayerCombatComponent")

	return warnings
