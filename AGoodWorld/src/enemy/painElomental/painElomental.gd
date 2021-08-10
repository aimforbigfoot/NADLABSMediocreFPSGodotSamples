extends "res://src/enemy/baseEnemy.gd"


#Maybe this one drops bombs on the player ???
func _ready() -> void:
	isFlyingType = true
	$timerFolder/oneSecondTimer.connect("timeout",self,"oneSecMove")
	global_transform.origin.y = rand_range(20,35)
	$timerFolder/oneSecondTimer.wait_time = rand_range(1,3)


func shootFunc() -> void:
	$timerFolder/oneSecondTimer.wait_time = rand_range(0.5,2)
	var bullet :Area= preload("res://src/enemy/enemyBullet/enemyBullet.tscn").instance()
	var bullet2 :Area= preload("res://src/enemy/enemyBullet/enemyBullet.tscn").instance()
	get_parent().add_child(bullet)
	get_parent().add_child(bullet2)
	$meshFolder/leftBullet/bulletParticles.emitting = true
	$meshFolder/rightBullet/bulletParticles.emitting = true
	var d :Vector3 
	if randf() < 0.5:
		d = (Global.player.global_transform.origin - global_transform.origin). normalized()*2.0
	else: 
		d = dir.normalized()*2.0
	if sign( global_transform.origin.dot( Global.player.global_transform.origin ) ) == 1:
		bullet.dir = d
		bullet2.dir = d
		bullet.global_transform.origin = $meshFolder/leftBullet/Position3D.global_transform.origin
		bullet2.global_transform.origin = $meshFolder/rightBullet/Position3D.global_transform.origin
	else:
		bullet.dir = d
		bullet2.dir = d
		bullet.global_transform.origin = $meshFolder/leftBullet2/Position3D.global_transform.origin
		bullet2.global_transform.origin = $meshFolder/rightBullet2/Position3D.global_transform.origin

func oneSecMove() -> void:
	if dir:
		shootFunc()
	var posInterIn := Vector3( 
		rand_range( -Global.mapSize.x*16, Global.mapSize.x*16 ),
		0,
		rand_range( -Global.mapSize.y*16, Global.mapSize.y*16 )
	)
	dir = (posInterIn-global_transform.origin).normalized()*speed
	var r := randf()
	if r < 0.5:
		dir.y = rand_range(-1,1)
	else:
		dir.y = 0
		

