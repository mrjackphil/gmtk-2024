extends RigidBody3D

var SPEED := 1

func _ready() -> void:
	var die_timer: SceneTreeTimer = get_tree().create_timer(3.0)
	die_timer.timeout.connect(queue_free)
	
	body_entered.connect(_collide)
	
func _physics_process(delta: float) -> void:
	var move_vect: Vector3 = Vector3(0, 0, -1).normalized().rotated(Vector3.UP, rotation.y).rotated(Vector3.FORWARD, rotation.x) * SPEED * delta
	#position += move_vect

func _collide(collider: Node3D) -> void:
	var child := collider.get_children()
	for c in child:
		if c.has_method("collide"):
			c.collide()
