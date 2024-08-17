extends Area3D

@export var SPEED := 1
@export var BOUNCE_COUNT := 1

@export var COLLIDER_AREA: Area3D

var _bounced := 0

func _ready() -> void:
	var die_timer: SceneTreeTimer = get_tree().create_timer(3.0)
	die_timer.timeout.connect(owner.queue_free)
	area_entered.connect(_collide)

func _collide(collider: Node3D) -> void:
	var child := collider.get_parent().get_children()
	for c in child:
		if c.has_method("collide"):
			c.collide()

	owner.queue_free()
