extends RigidBody

var dir : Vector3

func _ready() -> void:
	apply_central_impulse(dir)


func _on_basicGernade_body_entered(body: Node) -> void:
	if body.is_in_group("explodable"):
		explode()


func _on_startExplode_timeout() -> void:
	explode()


func explode() -> void:
	$explodeTimer.start()
	$exploisonEffected/CollisionShape.disabled = false
	$Particles.emitting = true
	$MeshInstance.hide()
	pass




func _on_exploisonEffected_body_entered(body: Node) -> void:
	if body:
		print("going to hurt what comes here")


func _on_explodeTimer_timeout() -> void:
	queue_free()
