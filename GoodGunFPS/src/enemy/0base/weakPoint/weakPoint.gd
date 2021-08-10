extends Area

signal weakPointGone

func weakPointExplode(damageAmt:float = 50.0) -> void:
	$Particles.emitting = true
	emit_signal("weakPointGone", damageAmt)
	for child in get_children():
		if child is MeshInstance:
			child.hide()
	$OmniLight.hide()
	$Timer.start()



func _on_Timer_timeout() -> void:
	queue_free()
