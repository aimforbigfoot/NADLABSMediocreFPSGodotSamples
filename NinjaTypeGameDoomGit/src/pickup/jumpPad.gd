extends Area

func _on_jumpPad_body_entered(body: Node) -> void:
	if body.is_in_group("player") and !body.is_in_group("bullet"):
		body.extraVel += Vector3(0,1000,0)
		print("TIME TO JUMP PLAER")
		pass
