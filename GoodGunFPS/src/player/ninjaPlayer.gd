extends KinematicBody

signal dashDid

onready var hand := $head/Camera/hand
onready var UI := $head/Camera/UI

var enemyFolder : Spatial

var health := 100.0
var MOUSE_SENS := 0.005
var gravity := -3
var defaultSpeed := 30.0
var speed := 50.0
var angForCamToLearpTo := 0.0
var XangForCamToLearpTo := 0.0
var vel := Vector3.ZERO
var ySpeed := 0.0
var jumpStrength := 50
var jumpNum := 0
var maxJumpAmt := 3

var canDash := true
var dashNum := 0
var extraVelMulti := 100
var maxDashAmt := 3
var extraVel := Vector3.ZERO

var machineGunShoot := true
var macGunSpecial := false
var macAmmo := 200

var sniperShoot := true
var sniperAmmo := 50

var gernadeShoot := true
var gernadeAmmo := 10

var windShoot := true
var windAmmo := 25

var maxGunNum := 4
var whichGunNum := 0

var rocketShoot := true
var rocketAmmo := 40


func _ready() -> void:
	enemyFolder = get_parent().get_node("enemyFolder")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$head/Camera/camTween.connect("tween_all_completed",self,"tweenComplete")
#	$generalFixTimer.connect("timeout",self,"generalFix")
	$machineGunTimer.connect("timeout",self,"timeOut")
	$sniperTimer.connect("timeout",self,"sniperTimerOut")
	$gernadeTimer.connect("timeout",self,"gernadeTimer")
	$windTimers.connect("timeout",self,"windTimer")
	$rocketTimer.connect("timeout",self,"rocketTimer")
	UI.connect("macGunSpecialTrue",self,"macGunSpecialAllowed")
func windTimer() -> void:
	windShoot = true
func gernadeTimer() -> void:
	gernadeShoot = true
func sniperTimerOut() -> void:
	sniperShoot = true
func rocketTimer() -> void:
	rocketShoot = true
func macGunSpecialAllowed() -> void:
	macGunSpecial = true
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$head.rotation.x += -event.relative.y * MOUSE_SENS
		rotation.y += -event.relative.x * MOUSE_SENS
	if event.is_action_pressed("mouseWheelDown"):
		moveGunDownOne()
	if event.is_action_pressed("mouseWheelUp"):
		moveGunUpOne()
func jump() -> void:
	jumpNum += 1
	ySpeed = jumpStrength
func dashFoward() -> void:
	emit_signal("dashDid")
	dashNum += 1
	dash()
	if sign(ySpeed) == -1:
		ySpeed = 0
	extraVel += ($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin).normalized()*extraVelMulti
func dashBack() -> void:
	emit_signal("dashDid")
	dashNum += 1
	dash()
	if sign(ySpeed) == -1:
		ySpeed = 0
	extraVel -= ($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin).normalized()*extraVelMulti*2
func checkMaterialsOnHand() -> void:
	match whichGunNum:
		0:
			hand.material_override = load("res://assets/material/red.tres")
			UI.zero()
			UI.ammoSet(macAmmo)
		1:
			hand.material_override = load("res://assets/material/orange.tres")
			UI.one()
			UI.ammoSet(sniperAmmo)
		2:
			hand.material_override = load("res://assets/material/green.tres")
			UI.two()
			UI.ammoSet(gernadeAmmo)
		3:
			hand.material_override = load("res://assets/material/blue.tres")
			UI.three()
		4:
			hand.material_override = load("res://assets/material/purple.tres")
			UI.four()
		5:
#			no gun here yet :s
			hand.material_override = load("res://assets/material/yellow.tres")
			UI.five()

func moveGunDownOne() -> void:
	if whichGunNum <= 0:
		whichGunNum = maxGunNum
	else:
		whichGunNum -= 1
	checkMaterialsOnHand()
func moveGunUpOne() -> void:
	if whichGunNum >= maxGunNum:
		whichGunNum = 0
	else:
		whichGunNum += 1
	checkMaterialsOnHand()

func setCamToColor(color,t) -> void:
#	print("called ", color)
	UI.setCamToColor(color,t)
	

func timeOut() -> void:
	machineGunShoot = true 

func shootBullet(bulletIn,speed,noise,spread, pushBackAmt:float=1.0) -> void:
	var bullet :Area= bulletIn
	macAmmo -= 1
	UI.ammoSet(macAmmo)
	get_parent().add_child(bullet)
	bullet.global_transform.origin = $head/Camera/whereToSpawnBullet.global_transform.origin
	if spread:
		var rand :=   Vector3( rand_range(-1,1),rand_range(-1,1),rand_range(-1,1)  )/2
		bullet.dir = ($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin).normalized()*speed + rand
	else:
		bullet.dir = ($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin).normalized()*speed
	bullet.pushBackValue = pushBackAmt
	$head/Camera/AnimationPlayer.play("shoot")
	$shootBullet.stream = noise
	$shootBullet.play()
func shootMachinGun(bolForPusher:bool) -> void:
#	if bool for pusher is false fire regular bullet, else just fire a knocback bullet
	if machineGunShoot:
		if not bolForPusher:
			UI.addToMacGun()
			UI.macGunReset(0.08)
			shootBullet( preload("res://src/player/bullets/machineGunBullet.tscn").instance(),5, load("res://assets/sfx/macGunRegular.wav"), false , 1.0)
			$machineGunTimer.start(0.08)
			machineGunShoot = false
		else:
			UI.addToMacGun()
			UI.macGunReset(0.08)
			shootBullet( preload("res://src/player/bullets/machineGunBullet.tscn").instance(),5, load("res://assets/sfx/macGunRegular.wav"), false , 2.0)
			$machineGunTimer.start(0.08)
			machineGunShoot = false
func shootSpecialMachineGun() -> void:
	if macGunSpecial:
		$machineGunTimer.start(1.5)
		UI.macGunReset(1.5)
		UI.resetMacGun()
		shootBullet( preload("res://src/player/bullets/specialMachineGunBullet.tscn").instance(),1, load("res://assets/sfx/macGunSpecial.wav"), false, 3.0 )
		macGunSpecial = false
		extraVel = -($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin).normalized()*200
func shootShotGun() -> void:
	if machineGunShoot:
		for i in 10:
			UI.addToMacGun()
			UI.macGunReset(0.75)
			shootBullet( preload("res://src/player/bullets/machineGunBullet.tscn").instance(),3, load("res://assets/sfx/shootKnifeSound.wav"), true, 1.5 )
			$machineGunTimer.start(0.75)
			machineGunShoot = false
	pass

func sniperChecker() -> void:
	var thing = $head/Camera/sniperRay.get_collider()
	if thing.is_in_group("enemy"):
		pass 
	elif thing.is_in_group("weakPoint"):
		print("hit weakpoint")
		thing.weakPointExplode()

func sniperShootFunc(damageAmt) -> void:
	if $head/Camera/sniperRay.is_colliding():
		sniperChecker()
#			do smth with damage amt
		var part : Particles = preload("res://src/player/efx/sniperParticles.tscn").instance()
		get_parent().add_child(part)
		part.global_transform.origin = $head/Camera/sniperRay.get_collision_point()
		match damageAmt:
			100:
				part.scale = Vector3(3,5,3)
				$shootBullet.stream = load("res://assets/sfx/sniperSpecial.wav")
			50:
				part.scale = Vector3(2,2,2)
				$shootBullet.stream = load("res://assets/sfx/sniperRegular.wav")
			20:
				$shootBullet.stream = load("res://assets/sfx/sniperQuickQuestio.wav")
		extraVel = -( $head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin )*damageAmt
	$shootBullet.play()
	sniperAmmo -= 1
	UI.ammoSet(sniperAmmo)
func shootSniper() -> void:
	if sniperShoot:
		sniperShootFunc(100)
		$sniperTimer.start(1.5)
		UI.sniperReset(1.5)
		sniperShoot = false
func shootSniperRightClick() -> void:
	if sniperShoot:
		sniperShootFunc(50)
		sniperShoot = false
		UI.sniperReset(0.5)
		$sniperTimer.start(0.5)
func shootSniperMiddleClick() -> void:
	if sniperShoot:
		sniperShootFunc(20)
		sniperShoot = false
		UI.sniperReset(0.1)
		$sniperTimer.start(0.1)

func shootPepperGernade() -> void:
	if gernadeShoot:
		UI.gernadesReset(2.0)
		$gernadeTimer.start(2.0)
		gernadeShoot = false
		var pg :RigidBody= preload("res://src/player/gernades/pepperSpray/pepperSpray.tscn").instance()
		get_parent().add_child(pg)
		pg.global_transform.origin = $head/Camera/Position3D.global_transform.origin
		pg.apply_central_impulse( ($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin)* 10  ) 
func shootHealthGernade() -> void:
	if gernadeShoot:
		UI.gernadesReset(2.0)
		$gernadeTimer.start(2.0)
		gernadeShoot = false
		var pg :RigidBody= preload("res://src/player/gernades/hpBomb/HPBomb.tscn").instance()
		get_parent().add_child(pg)
		pg.global_transform.origin = $head/Camera/Position3D.global_transform.origin
		pg.apply_central_impulse( ($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin)* 10  ) 
func shootTarBomb() -> void:
	if gernadeShoot:
		UI.gernadesReset(2.0)
		$gernadeTimer.start(2.0)
		gernadeShoot = false
		var pg :RigidBody= preload("res://src/player/gernades/tarBomb/tarBomb.tscn").instance()
		get_parent().add_child(pg)
		pg.global_transform.origin = $head/Camera/Position3D.global_transform.origin
		pg.apply_central_impulse( ($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin)* 10  ) 
	pass

func shootWinds(num : int ) -> void:
	if windShoot:
		var wind :RigidBody= preload("res://src/player/spells/wind/wind.tscn").instance()
		match num:
			2:
				wind.lookAtTrue = true
				wind.player = self
				get_parent().add_child(wind)
				wind.global_transform.origin = $head/Camera/fartherPos2.global_transform.origin
				UI.windReset(9.0)
				$windTimers.start(9.0)
#				subtracts 5 hp tho to use or uses more shield ammo maybe uses double or tiple the shield ammo 
			0:
				add_child(wind)
				wind.global_transform.origin = $head/Camera/fartherPos.global_transform.origin
				UI.windReset(3.0)
				$windTimers.start(3.0)
			1:
				wind.lookAtTrue = true
				wind.player = self
				get_parent().add_child(wind)
				wind.global_transform.origin = $head/Camera/fartherPos2.global_transform.origin
				UI.windReset(3.0)
				$windTimers.start(3.0)
		wind.look_at(global_transform.origin, Vector3.UP)
		windShoot = false

func shootRockets() -> void:
	if rocketShoot:
		rocketShoot = false
		$rocketTimer.start()
		UI.rocketReset(1)
		var rocket :Area= preload("res://src/player/rockets/rocket.tscn").instance()
		get_parent().add_child(rocket)
		rocket.player = self
		rocket.enemyFolder = enemyFolder
		rocket.dir = ( $head/Camera/fartherPos.global_transform.origin - $head/Camera.global_transform.origin ).normalized() * 1
		rocket.global_transform.origin = $head/Camera/whereToSpawnBullet.global_transform.origin


func _process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		match whichGunNum:
			0:
				shootMachinGun(false)
			1:
				shootSniperMiddleClick()
			2:
				shootHealthGernade()
			3:
				shootWinds(0)
			4:
				shootRockets()
			5:
				shootShotGun()
	if Input.is_action_pressed("rclick"):
		match whichGunNum:
			0:
				shootMachinGun(true)
			1:
				shootSniperRightClick()
			2:
				shootPepperGernade()
			3:
				shootWinds(1)
	if Input.is_action_pressed("middleClick"):
		match whichGunNum:
			0:
				shootSpecialMachineGun()
			1:
				shootSniper()
			2:
				shootTarBomb()
			3:
				shootWinds(2)






func _physics_process(delta: float) -> void:
	vel = get_dir().rotated( Vector3.UP, rotation.y) * speed
	if !is_on_floor() and global_transform.origin.y > 1.6:
		ySpeed += gravity
	else:
		ySpeed = 0.0
		canDash = true
		dashNum = 0
		jumpNum = 0
	if is_on_ceiling():
		ySpeed = gravity
	if Input.is_action_just_pressed("space") and (jumpNum < maxJumpAmt):
		jump()
	vel.y = ySpeed
	if Input.is_action_just_pressed("f") and (dashNum < maxDashAmt):
		dashFoward()
	if Input.is_action_just_pressed("g") and (dashNum < maxDashAmt):
		dashBack()
	if Input.is_action_just_pressed("r"):
		get_tree().reload_current_scene()

	extraVel = lerp( extraVel, Vector3.ZERO, 0.1 )
	vel += extraVel
	vel = move_and_slide(vel, Vector3.UP, true, 4, 1.3)
	$head.rotation_degrees.z = lerp($head.rotation_degrees.z, angForCamToLearpTo, 0.1)
	$head/Camera.rotation_degrees.x = lerp($head/Camera.rotation_degrees.x, XangForCamToLearpTo, 0.1)

func get_dir() -> Vector3:
	var dir : Vector3
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	angForCamToLearpTo = dir.x*-2.5
	dir.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	XangForCamToLearpTo = dir.z*7.5
	return dir.normalized()






func dash() -> void:
	$head/Camera/camTween.interpolate_property($head/Camera,"fov", 90, 93,0.02,Tween.TRANS_QUART,Tween.EASE_OUT,0)
	$head/Camera/camTween.start()
	
func tweenComplete() -> void:
	$head/Camera/camTweenBack.interpolate_property($head/Camera,"fov", 93, 90,0.07,Tween.TRANS_QUART,Tween.EASE_IN,0)
	$head/Camera/camTweenBack.start()
