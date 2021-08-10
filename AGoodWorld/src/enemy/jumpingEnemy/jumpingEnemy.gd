extends "res://src/enemy/baseEnemy.gd"

var canJumpPersonal := true

func _ready() -> void:
	$timerFolder/oneSecondTimer.connect("timeout",self,"jumpTime")
	$timerFolder/oneSecondTimer.wait_time = rand_range(2,3)
	$checkIfHitFloor.connect("body_entered",self,"bodyEntered")
	$playerChecker.connect("body_entered",self,"bodyEnteredPlayerChecker")
	gravitMulti = 15

func bodyEnteredPlayerChecker(body:PhysicsBody) -> void:
	if body.is_in_group("player") and canJumpPersonal:
		body.hurt(2.42)
		body.extraVel = (body.global_transform.origin - global_transform.origin).normalized()*100

func bodyEntered(body:PhysicsBody) -> void:
	if not body.is_in_group("player") and not body.is_in_group("enemy"):
		dir = Vector3.ZERO
		$meshFolder/AnimationPlayer.play("Smash")
		canJumpPersonal = true
		$checkIfHitFloor/jumpParticles.emitting = true


func jumpTime() -> void:
	if canJumpPersonal and is_on_floor():
		$meshFolder/AnimationPlayer.play_backwards("Smash")
		$noisePlayerFolder/jumpNoisePlayer.play()
		canJumpPersonal = false
		var mar := 40
		if randf() < 0.2:
			var getPosNearbyMe := (Vector3( rand_range(-mar,mar) ,0, rand_range(-mar,mar)  )).normalized() * speed
			getPosNearbyMe.y = rand_range(1000,2500)
			dir = getPosNearbyMe
	#		$timerFolder/oneSecondTimer.wait_time = rand_range(2,5)
		else:
			var tempDir := (Global.player.global_transform.origin -  global_transform.origin ).normalized() * speed
			tempDir.y = rand_range(1000,2500)
			dir = tempDir
	
