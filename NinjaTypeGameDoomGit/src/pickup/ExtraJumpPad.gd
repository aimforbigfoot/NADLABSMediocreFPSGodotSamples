extends Area



func _on_ExtraJumpPad_body_entered(body: Node) -> void:
	if body.is_in_group("player") and !body.is_in_group("bullet"):
		body.extraVel += Vector3(0,2000,0)
		print("TIME TO JUMBO JUMP PLAER")
		pass
