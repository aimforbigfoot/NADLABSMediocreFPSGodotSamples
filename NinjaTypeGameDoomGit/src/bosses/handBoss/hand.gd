extends Area
var player :KinematicBody



func _on_hand_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.die()
		pass
	else:
#		player.shakeCam()
		pass
