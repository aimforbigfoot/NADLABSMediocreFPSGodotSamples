extends KinematicBody

const MOUSE_SENS := 0.005
var canDash := true
var returnSpeed := 400.0
var speed := 400.0
var angForCamToLearpTo := 0.0
var XangForCamToLearpTo := 0.0
var ySpeed := 0.0
var extraVel := Vector3.ZERO
var jumpNum := 0
var gravity := -20
var unlimitedJump := false
var gravityReturnAmt := -20
var jumpStrength := 500
var knockbackAmt := 0.0
var maxJumpAmt := 4
var vecOfCrossHair := Vector3.ZERO
var canShoot := true
var vel := Vector3.ZERO
var waitTimeShoot := 0.1
var canFlipGravity := false
var dashMultipler := 1
var gunNumFromArrOfSettings := 0
func _ready() -> void:
	gunNumFromArrOfSettings = Global.arrOfSettings[1]
#	gunNumFromArrOfSettings = 1
	match gunNumFromArrOfSettings:
		0:
			pass
		1:
			waitTimeShoot = 1.5
		2:
			waitTimeShoot = 3.0
		3:
			waitTimeShoot = 0.5

	match Global.arrOfSettings[0]:
		0:
			pass
		1:
			gravityReturnAmt = -4
			maxJumpAmt = 1
			print("happened I set the gravity rn")
		2:
			returnSpeed = 200.0
			maxJumpAmt = 10
		3:
			$CollisionShape.shape = load("res://src/player/playerCols/playerSmallCol.tres")
			returnSpeed = 200.0
		4:
			returnSpeed = 800.0
			maxJumpAmt = 2
		5:
			unlimitedJump = true
			returnSpeed = 100.0
		6:
			dashMultipler = -5
		7:
			canFlipGravity = true
			gravityReturnAmt = -60
			pass
	$shotTimer.connect("timeout",self,"resetShootBool")
	Global.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print(Global.arrOfSettings[0], "HEYYYYYYYYY")
			

func _input(event: InputEvent) -> void:
	vecOfCrossHair = $head/Camera/Position3D.global_transform.origin - global_transform.origin
	if event is InputEventMouseMotion:
		$head.rotation.x += -event.relative.y * MOUSE_SENS
		rotation.y += -event.relative.x * MOUSE_SENS

func _process(delta: float) -> void:
	if Input.is_action_pressed("click") and canShoot:
		match gunNumFromArrOfSettings:
			0:
				shootBullet(1)
			1:
				fireShotgun()
			2:
				fireMegaShotgun()
			3:
				fireLaser()
	if Input.is_action_just_released("click"):
		canDash = true
		$goodJobPlayer.play()
		speed = returnSpeed
		gravity = gravityReturnAmt
		jumpStrength = 500
		$head/Camera/AnimationPlayer.play("idle")

func _physics_process(delta: float) -> void:
	vel = get_dir().rotated( Vector3.UP, rotation.y) * speed
	if !is_on_floor():
		ySpeed += gravity
	else:
		canDash = true
		ySpeed = 0.0
		jumpNum = 0
	if Input.is_action_just_pressed("space") and (jumpNum < maxJumpAmt or unlimitedJump) and not canFlipGravity:
		jumpNum += 1
		ySpeed = jumpStrength
	elif canFlipGravity and Input.is_action_just_pressed("space"):
		gravity *= -1
		gravityReturnAmt = gravity
		print(gravity)
	vel.y = ySpeed
	
	if Input.is_action_just_pressed("f") and canDash:
		canDash = false
		extraVel = ($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin).normalized()*1000*dashMultipler
	extraVel = lerp( extraVel, Vector3.ZERO, 0.1 )
	vel += extraVel
	vel = move_and_slide(vel, Vector3.UP)
	$head.rotation_degrees.z = lerp($head.rotation_degrees.z, angForCamToLearpTo, 0.1)
	$head/Camera.rotation_degrees.x = lerp($head/Camera.rotation_degrees.x, XangForCamToLearpTo, 0.1)

func get_dir() -> Vector3:
	var dir : Vector3
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	angForCamToLearpTo = dir.x*-5.0
	dir.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	XangForCamToLearpTo = dir.z*15.0
	return dir


func resetShootBool() -> void:
	canShoot = true

func commonShootStuff() -> void:
	canShoot = false
	$shotTimer.start(waitTimeShoot)
	speed = 0.0
	canDash = false
	gravity = 0.0
	jumpStrength = 0.0
	ySpeed = 0.0


func shootBullet(amt) -> void:
	$head/Camera/AnimationPlayer.play("shoot")
	var bullet :Area= preload("res://src/player/playerProjectiles/playerBullet.tscn").instance()
	get_parent().add_child(bullet)
	$shootPlayer.play()
	bullet.global_transform.origin = $head/Camera/bulletSpawnPt.global_transform.origin
	var randVec := Vector3( (randf() if randf()<0.5 else -randf()) *amt, (randf() if randf()<0.5 else -randf())*amt,(randf() if randf()<0.5 else -randf())*amt ) 
	bullet.dir = -( $head/Camera/badHand.global_transform.origin - $head/Camera/Sprite3D.global_transform.origin + vel.normalized() +randVec ).normalized()*20
	commonShootStuff()

func fireShotgun() -> void:
	for i in 10:
		shootBullet(10)
		extraVel = ( $head/Camera/badHand.global_transform.origin - $head/Camera/Sprite3D.global_transform.origin).normalized()*2000

func fireMegaShotgun() -> void:
	for i in 2:
		fireShotgun()
		extraVel = ( $head/Camera/badHand.global_transform.origin - $head/Camera/Sprite3D.global_transform.origin).normalized()*8000


func fireLaser() -> void:
	if $head/Camera/sniperRay.is_colliding():
		commonShootStuff()
		var enemy = $head/Camera/sniperRay.get_collider()
		if enemy.is_in_group("enemy") and enemy.has_method("hit"):
			enemy.hit()
	$head/Camera/AnimationPlayer.play("shootLaser")


func die() -> void:
	get_tree().change_scene("res://src/homeScreens/playScreen/RealGameScene.tscn")
	pass






