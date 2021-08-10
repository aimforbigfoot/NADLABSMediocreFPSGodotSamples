extends Area


func _ready() -> void:
	connect("body_entered",self,"bodyEntered")


func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		print("LASETTTTTTTTTTTRRRRRRRRRR GOT PLAYER")
		body.die()
