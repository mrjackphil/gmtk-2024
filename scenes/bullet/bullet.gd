extends Area3D

@export var SPEED := 1

func _ready() -> void:
	var die_timer: SceneTreeTimer = get_tree().create_timer(3.0)
	die_timer.timeout.connect(owner.queue_free)
	area_entered.connect(_collide)

func _collide(collider: Node3D) -> void:
	var child := collider.get_parent().get_children()
	
	if collider.owner.is_in_group("player"):
		var hp_component: HealthComponent = collider.find_child("HealthComponent")
		if not hp_component: return
		
		hp_component.hp -= 10
		
	for c in child:
		if c.has_method("collide"):
			c.collide()

	owner.queue_free()
