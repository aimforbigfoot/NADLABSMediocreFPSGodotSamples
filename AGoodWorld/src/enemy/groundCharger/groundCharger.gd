extends "res://src/enemy/baseEnemy.gd"

var dumbAmt := 0.8

func _ready() -> void:
	$timerFolder/oneSecondTimer.connect("timeout",self,"oneSecMove")
	$timerFolder/oneSecondTimer.wait_time = rand_range(0.5,1.5)
	$playerCollider.connect("body_entered",self,"bodyEntered")

func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		body.speed = 2
		body.resetSpeed()



func oneSecMove() -> void:
	if randf() > dumbAmt :
		var t := (Global.player.global_transform.origin - global_transform.origin).normalized()*speed
		t.y = 0
		t.rotated( Vector3.UP, rand_range(-1.57,1.57) )
		dir = t
	else:
		dir = Vector3(rand_range(-1,1),0,rand_range(-1,1)).normalized()*speed
	
