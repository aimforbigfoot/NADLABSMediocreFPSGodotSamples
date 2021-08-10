extends "res://src/enemy/baseEnemy.gd"


func _ready() -> void:
#	$timerFolder/teleAnimator.play("arriving")
	$timerFolder/teleAnimator.connect("animation_finished",self,"animDone")
	$timerFolder/oneSecondTimer.connect("timeout",self,"oneSecTelePort")
	$timerFolder/oneSecondTimer.wait_time = rand_range(1,5)
	$playerColidder.connect("body_entered",self,"bodyEntered")
	isFlyingType = true

func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		body.hurt(10)
		body.extraVel = Vector3(randf(),randf(),randf())*500

func animDone(an:String) -> void:
	if an == "leavingGood":
		global_transform.origin = Vector3( rand_range(-Global.mapSize.x*15,Global.mapSize.x*15),rand_range(20,35), rand_range(-Global.mapSize.y*15,Global.mapSize.x*15)  )
		$timerFolder/teleAnimator.play("arriving")
		dir.y = rand_range(-10,10)
		if randf() < 0.1:
			dir = (Global.player.global_transform.origin - global_transform.origin).normalized()*speed*2
	pass

func oneSecTelePort() -> void:
	$timerFolder/teleAnimator.play("leavingGood")
	var bulelt :Area=preload( "res://src/enemy/enemyBullet/enemyBullet.tscn"  ).instance()
	get_parent().add_child(bulelt)
	bulelt.dir = (Global.player.global_transform.origin - global_transform.origin + Vector3.LEFT *25).normalized() 
	bulelt.global_transform.origin = global_transform.origin
