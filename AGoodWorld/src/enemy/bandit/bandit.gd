extends "res://src/enemy/baseEnemy.gd"


func _ready() -> void:
	isFlyingType = true
	$timerFolder/oneSecondTimer.connect("timeout",self,"oneSecondMove")
	$collisonArea.connect("body_entered",self,"bodyEntered")
	$timerFolder/nukeTimer.connect("timeout",self,"nukeTimer")
	global_transform.origin.y = rand_range(25,38)
	$timerFolder/nukeTimer.wait_time = rand_range(1,5)

func nukeTimer() -> void:
	var nuke :RigidBody= preload("res://src/enemy/nuke/nuke.tscn").instance()
	get_parent().add_child(nuke)
	nuke.global_transform.origin = global_transform.origin
	

func oneSecondMove() -> void:
	var dist :Vector3= (Global.player.global_transform.origin - global_transform.origin)
	if dist.length() < 200:
		dir = -dist.normalized().rotated(Vector3.UP,rand_range(-3,3))*speed
	else:
		dir = dist.normalized()*speed
		dir.y *= -1
	dir.y = rand_range(-0.2,2)

func bodyEntered(body) -> void:
	if body.is_in_group("obstacle"):
		dir = Vector3( rand_range(-1,1), rand_range(-1,1), rand_range(-1,1)  ).normalized()*speed
	pass
