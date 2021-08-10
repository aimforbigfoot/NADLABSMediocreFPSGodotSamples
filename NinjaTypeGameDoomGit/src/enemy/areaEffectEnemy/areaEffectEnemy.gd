extends "res://src/enemy/baseEnemy/baseEnemy.gd"

func _ready() -> void:
	canMove = false
	bulletAmt = 20

func _on_sludgeArea_body_entered(body: Node) -> void:
	if body.is_in_group("player") and !body.is_in_group("bullet"):
		body.die()
#		KILL PLAYER IS HERE
#		body.kill()

func hurt() -> void:
	anim_player.play("hurt")
