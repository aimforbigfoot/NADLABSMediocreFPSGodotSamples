extends "res://src/enemy/baseEnemy.gd"


func _ready() -> void:
	isFlyingType = true
	$timerFolder/oneSecondTimer.connect("timeout",self,"oneSecMove")
	$collisonArea.connect("body_entered",self,"bodyMoveAway")
	lookAtDir = false


func oneSecMove() -> void:
	var dist :Vector3= (Global.player.global_transform.origin - global_transform.origin)
	if dist.length() < 100 and round(randf()):
		dir = Vector3(rand_range(-1,1),rand_range(-1,1), rand_range(-1,1)).normalized()*speed
	else:
		dir = dist.normalized() * speed
		$meshFolder/meshAnimPlayer.play("idle")

func bodyMoveAway(body:PhysicsBody) -> void:
#	print(body)
	if body.is_in_group("obstacle"):
		dir *= -1
		dir.rotated(Vector3.LEFT, rand_range(-0.7,0.7))
		dir.rotated(Vector3.DOWN, rand_range(-0.7,0.7))
		dir.rotated(Vector3.FORWARD, rand_range(-0.7,0.7))
	if body.is_in_group("player"):
		print('got a player')
		$meshFolder/meshAnimPlayer.play("chew")
		body.hurt(10.0)
		body.extraVel = (body.global_transform.origin-global_transform.origin)*50
		print("bite player")
		dir =Vector3.ZERO


func _physics_process(delta: float) -> void:
	look_at(Global.player.global_transform.origin,Vector3.UP)
