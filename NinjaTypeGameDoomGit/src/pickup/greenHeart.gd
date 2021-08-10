extends Area

func _on_greenHeart_body_entered(body: Node) -> void:
	if body.is_in_group("player") and !body.is_in_group("bullet"):
		body.health += 50
		body.healthPickedUp()
		body.updateHealthAmount()
		queue_free()


