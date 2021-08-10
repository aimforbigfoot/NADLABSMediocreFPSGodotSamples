extends Area


func _on_heart_body_entered(body: Node) -> void:
	if body.is_in_group("player") and !body.is_in_group("bullet"):
		body.health += 10
		body.healthPickedUp()
		body.updateHealthAmount()
		queue_free()
