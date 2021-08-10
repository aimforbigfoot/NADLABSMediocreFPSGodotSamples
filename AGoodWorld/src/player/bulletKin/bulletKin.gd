extends KinematicBody


var dir : Vector3


func _physics_process(delta: float) -> void:
	var col := move_and_collide(dir)
	if col and col.collider.is_in_group("enemy"):
		col.collider.die()
		queue_free()
	elif col:
		queue_free()
