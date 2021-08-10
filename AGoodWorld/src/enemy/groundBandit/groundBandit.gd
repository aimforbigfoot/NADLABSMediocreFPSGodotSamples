extends "res://src/enemy/baseEnemy.gd"

var thresholdDiffFromPlayer := rand_range(30,100)
func _ready() -> void:
	$timerFolder/oneSecondTimer.connect("timeout",self,"oneSecondMove")
	$collisonArea.connect("body_entered",self,"bodyEntered")

func bodyEntered(body) -> void:
	if body.is_in_group("obstacle") and randf() < 0.5:
		dir *= -1
		dir.rotated(Vector3.UP, rand_range(-0.7,0.7)).normalized()*speed
	else:
		var randPos := Vector3( rand_range((-Global.mapSize.x-1)*20,(Global.mapSize.x-1)*20),
		0,
		rand_range((-Global.mapSize.y-1)*20,(Global.mapSize.y-1)*20) )
		dir = (randPos-global_transform.origin).normalized()*speed

func oneSecondMove() -> void:
	var dist : Vector3 = (Global.player.global_transform.origin - global_transform.origin)
	dist.y = 0
	if dist.length() < thresholdDiffFromPlayer:
		dir = -dist.normalized()*speed
	else:
		dir = dist.normalized()*speed
