extends Particles
signal done
func _ready() -> void:
	emitting = true

func _on_Timer_timeout() -> void:
	queue_free()
	emit_signal("done")
