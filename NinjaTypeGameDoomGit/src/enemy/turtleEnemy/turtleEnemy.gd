extends "res://src/enemy/baseEnemy/baseEnemy.gd"


func _ready() -> void:
	health = 100

func _on_turtleEnemy_body_entered(body: Node) -> void:
	if body.is_in_group("player") and body.has_method("die"):
		body.die("dienow")


func hurt() -> void:
	anim_player.play("hurt")
