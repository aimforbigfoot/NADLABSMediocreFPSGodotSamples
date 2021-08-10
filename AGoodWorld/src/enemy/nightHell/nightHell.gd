extends "res://src/enemy/baseEnemy.gd"

var canJumpPersonal := true
var canHurtPlayer := false

func _ready() -> void:
	$timerFolder/oneSecondTimer.connect("timeout",self,"jumpTime")
	$timerFolder/afterLandedTimer.connect("timeout",self,"allowedToJumpAgain")
	$checkIfHitFloor.connect("body_entered",self,"bodyEntered")
	$timerFolder/oneSecondTimer.start(rand_range(1,5))
	$playerChecker.connect("body_entered",self,"pushPlayer")
	$timerFolder/quickAfterLand.connect("timeout",self,"stopCanHurtPlayer")
	gravitMulti = 20

func pushPlayer(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		print("got a player", canHurtPlayer)
		if canHurtPlayer:
			body.hurt(10)
			body.extraVel = (body.global_transform.origin - global_transform.origin).normalized()*200


func bodyEntered(body:PhysicsBody) -> void:
	if not body.is_in_group("player") and not body.is_in_group("enemy"):
		dir = (Global.player.global_transform.origin - global_transform.origin).normalized()*speed
		$checkIfHitFloor/jumpParticles.emitting = true
		$timerFolder/afterLandedTimer.wait_time = rand_range(4,10)
		$timerFolder/afterLandedTimer.start()
		$timerFolder/quickAfterLand.start()
		print("started quick land")

func stopCanHurtPlayer() -> void:
	canHurtPlayer = false
	print("stoped quick land")
	pass

func allowedToJumpAgain() -> void:
	canJumpPersonal = true

func jumpTime() -> void:
	if canJumpPersonal and is_on_floor():
		canHurtPlayer = true
		$checkIfHitFloor/jumpParticles.emitting = true
		$noisePlayerFolder/jumpNoisePlayer.play()
		canJumpPersonal = false
		var mar := 40
		if randf() < 0.2:
			var getPosNearbyMe := (Vector3( rand_range(-mar,mar) ,0, rand_range(-mar,mar)  )).normalized() * speed
			getPosNearbyMe.y = rand_range(2500,4000)
			dir = getPosNearbyMe
	#		$timerFolder/oneSecondTimer.wait_time = rand_range(2,5)
		else:
			var tempDir := (Global.player.global_transform.origin -  global_transform.origin ).normalized() * speed
			tempDir.y = rand_range(2500,4000)
			dir = tempDir
	else:
		dir = (Global.player.global_transform.origin - global_transform.origin).normalized()*speed
		
