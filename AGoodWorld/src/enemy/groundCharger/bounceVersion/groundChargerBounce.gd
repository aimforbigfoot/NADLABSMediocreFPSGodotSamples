extends "res://src/enemy/groundCharger/groundCharger.gd"

func _ready() -> void:
	dumbAmt = 0.2
	$checker.connect("body_entered",self,"moveRandomDir")

func moveRandomDir(body) -> void:
	if body.is_in_group("obstacle"):
		dir = Vector3( rand_range(-1,1) , 0, rand_range(-1,1)).normalized() * speed
	elif body.is_in_group("player"):
		$meshFolder/meshAnimPlayer.play("bite")
		body.hurt(9.5)
		body.extraVel = dir*5
