extends RigidBody3D

@export var SPEED := 1
@export var BOUNCE_COUNT := 1

@export var COLLIDER_AREA: Area3D

var _bounced := 0

func _ready() -> void:
	var die_timer: SceneTreeTimer = get_tree().create_timer(3.0)
	die_timer.timeout.connect(queue_free)
	
	COLLIDER_AREA.body_entered.connect(_collide)
	
func _physics_process(delta: float) -> void:
	var move_vect: Vector3 = Vector3(0, 0, -1).normalized().rotated(Vector3.UP, rotation.y).rotated(Vector3.FORWARD, rotation.x) * SPEED * delta
	#position += move_vect

func _collide(collider: Node3D) -> void:
	_bounced += 1

	var child := collider.get_children()
	for c in child:
		if c.has_method("collide"):
			c.collide()
			
	if _bounced > BOUNCE_COUNT:
		queue_free()
