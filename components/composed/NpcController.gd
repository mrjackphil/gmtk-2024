extends Node
class_name NpcController

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var _hp_component: HealthComponent
@export var _hitbox_component: HitboxComponent
@export var _hit_effect_component: HurtEffectComponent
@export var _enemy_detection_area: Area3D

var _character_body: CharacterBody3D = owner

func _ready() -> void:
	if not _hit_effect_component:
		printerr("NpcController is missing _hit_effect_component")
		return

	if not owner is CharacterBody3D:
		push_error("NpcController can only be used on CharacterBody3D")

	if _hp_component == null or _hitbox_component == null:
		return

	_hitbox_component.was_hit.connect(_hurt)
	_hp_component.hp_end.connect(_die)

func _die() -> void:
	owner.queue_free()

func _hurt(damager: Node3D, damage: int = 1) -> void:
	if not _hit_effect_component:
		return

	_hit_effect_component.apply(Effect.EffectData.new(owner, damager))
	_hp_component.hurt(damage)

func _apply_gravity(delta: float) -> void:
	if not owner.is_on_floor():
		owner.velocity.y -= gravity * delta
	elif owner.velocity.y < 0:
		owner.velocity.y = 0

func _horizontal_movement() -> void:
	const DECCELERATION = 0.05
	owner.velocity.x = lerp(owner.velocity.x, 0.0, DECCELERATION)
	owner.velocity.z = lerp(owner.velocity.z, 0.0, DECCELERATION)

func _attack_player() -> void:
	if _enemy_detection_area.has_overlapping_bodies():
		var bodies = _enemy_detection_area.get_overlapping_bodies()
		for b: Node3D in bodies:
			if b.is_in_group("player") and b.position.distance_to(owner.position) > 3:
				_move_to_player(b)
				break

func _move_to_player(body: CharacterBody3D):
	var goto = (body.position - owner.position).normalized() * Vector3(1, 0, 1)
	owner.velocity += goto * 0.1	
		
func _physics_process(delta: float) -> void:
	_horizontal_movement()
	_apply_gravity(delta)
	_attack_player()

	owner.move_and_slide()
	
