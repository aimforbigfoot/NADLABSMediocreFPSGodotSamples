extends KinematicBody

signal gunChanged 
var dead := false
export var speed := 50.0
const normalSpeed := 75.0
const slowSpeed := normalSpeed*3/4
const fastSpeed := normalSpeed/3*4
const gravity := -4.5
var time := 0.0
var MOUSE_SENSITIVITY = 0.2
var JUMPSPEED := 90
var ySpeed := 0.0
var jumpNum := 0
const MAXJUMPNUM := 2
var extraVel := Vector3.ZERO
var vel : Vector3
var justLanded := false
var maxSpeed := 400.0
var minSpeed := -400.0
var gunPosToShow := 0
var canShoot := true
var health :int= 100
var canFlameHurt := false
var gunAmmos := ["Infinite",50,100,50,500]
var gunArr := ["pistol","rocket","shoutgun","sniper","uzi"]
var tempRot 

var shootNoiseSoundsArr := [
#	preload("res://assets/audio/sfx/kennyTests/footstep_concrete_003.ogg"),
#	preload("res://assets/audio/sfx/kennyTests/footstep_concrete_000.ogg"),
	preload("res://assets/audio/sfx/olderNoises/BESTFIRENOISEEVER.wav"),
	preload("res://assets/audio/sfx/olderNoises/theBestShootNOise.wav")
]
onready var cameraShake := $cameraShake
onready var hurtNoisePlayer := $hurtNoisePlayer
onready var head := $head
onready var gunManager := $head/Camera/GunManager
onready var animPlayer := $AnimationPlayer
onready var ammoCounter := $head/Camera/UISTuff/gunHUD/AmmoCounter
onready var posOfThing := $head/Camera/PosOfThing
onready var shootTimer := $shootTimer
onready var sniperRayCast := $head/Camera/sniperRayCast
onready var shootNoisePlayer := $shootNoisePlayer
onready var levelNumText := $head/Camera/UISTuff/LevelNum
onready var sniperCount := $head/Camera/UISTuff/gunHUD/SniperCount
onready var rocketCount := $head/Camera/UISTuff/gunHUD/RocketCount
onready var uziCount := $head/Camera/UISTuff/gunHUD/UziCount
onready var shotgunCount := $head/Camera/UISTuff/gunHUD/ShoutGunCount
onready var dieScreen := $head/Camera/UISTuff/DieScreen
onready var dieText := $head/Camera/UISTuff/DieScreen/dieText
onready var flashIndicator := $flashIndicator
onready var healthLabel := $head/Camera/UISTuff/heartHUD/healthNum
onready var flameArea := $head/Camera/GunManager/flameThrower/flameArea
onready var flameParticles := $head/Camera/GunManager/flameThrower/Particles
onready var flameText := $head/Camera/UISTuff/gunHUD/FlameGunText
onready var gunSelector := $head/Camera/UISTuff/gunSelector
onready var healthWarningLabel := $head/Camera/UISTuff/warningNode/healthWarning
onready var ammoWarningLabel := $head/Camera/UISTuff/warningNode/ammoWarning
onready var jumpNoisePlayer := $jumpNoisePlayer
onready var gunParticles := $head/Camera/gunParticles
var localMouseSense := Global.mouseSensitivty

func _ready() -> void:
	Global.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	animPlayer.play("moving")
	$head/Camera/UISTuff/pauseScreen.hide()
	levelNumText.text = str(Global.levelNum)
	health = Global.globalHealthNum
	gunAmmos = Global.globalAmmoArr
	if Global.gameMode == "infinite":
		updateAmmoCount()
		$head/Camera/UISTuff/TimeTiralMode.hide()
	if Global.gameMode=="trial":
		$oneSecondTimer.connect("timeout",self,"AddOneSecond")
		dieScreen.hide()
		gunManager.hide()
		canShoot = false
		shootTimer.stop()
		$head/Camera/UISTuff/LevelNum.hide()
		$head/Camera/UISTuff/LevelNumText.hide()
		$head/Camera/UISTuff/gunHUD.hide()
	$head/Camera/UISTuff/warningNode.hide()
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_x(deg2rad(event.relative.y *localMouseSense *-1))
		self.rotate_y(deg2rad(event.relative.x * localMouseSense * -1))
		var camera_rot = head.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -90, 90)
		head.rotation_degrees = camera_rot
	if Input.is_action_just_pressed("m"):
		Global.musicAllowed = false
		Global.soundAllowed = false
#	if event.is_action_pressed("ui_cancel"):
#		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
#			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#		else:
#			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("h"):
		gunManager.visible = !gunManager.visible
	if event.is_action_pressed("mouseWheelUp") and Global.gameMode == "infinite":
		if !gunPosToShow >= gunArr.size()-1:
			gunPosToShow += 1
		else:
			gunPosToShow = 0
		updateGun()
		updateAmmoCount()
	if event.is_action_pressed("mouseWheelDown") and Global.gameMode == "infinite":
		
		if !gunPosToShow <= 0:
			gunPosToShow -= 1
		else:
			gunPosToShow = gunArr.size()-1
		updateGun()
		updateAmmoCount()
	
	if Input.is_action_just_pressed("1"):
		gunPosToShow = 0
		updateGun()
		print("pressed")
		
	if Input.is_action_just_pressed("2"):
		gunPosToShow = 1
		updateGun()

	if Input.is_action_just_pressed("3"):
		gunPosToShow = 2
		updateGun()

	if Input.is_action_just_pressed("4"):
		gunPosToShow = 3
		updateGun()

	if Input.is_action_just_pressed("5"):
		gunPosToShow = 4
		updateGun()


	flameParticles.emitting = false
	canFlameHurt = false 
	if Input.is_action_pressed("lClick") and canShoot and Global.gameMode == "infinite":
#		var gunAmmos := ["Infinite",50,100,50,500]
#		var gunArr := ["pistol","rocket","shoutgun","sniper","uzi"]
		if gunPosToShow == 0: # PISTOL
			spawn_bullet(0, 0.1,6.0, false,0,false)
		elif gunPosToShow == 1 and gunAmmos[1]>0: # ROCKET 
			spwan_rocket(300, 1, 4)
			subAmmo()
		elif gunPosToShow == 2 and gunAmmos[2]>0: # SHOUTGUN
			for i in 20:
				spawn_bullet(250, 0.2, 10.0,true, PI/24,true)
			subAmmo()
		elif gunPosToShow == 3 and gunAmmos[3]>0: # SNIPER
			subAmmo()
			fire_ray_cast_bullet(500, 0.5)
		elif gunPosToShow == 4 and gunAmmos[4]>0: # UZI - or sub machine gun for intents and pursospe
			spawn_bullet(75, 0.01, 10.0,true,PI/64, false)
			subAmmo()
		elif gunPosToShow == 5 and gunAmmos[5]>0: #flamethrower
			sprayFire()
	var amtToMove := 0.01

func AddOneSecond() -> void:
	time += 1
	$head/Camera/UISTuff/TimeTiralMode/Label.text = ("Time: "+ str(time))
	pass



func updateGun() -> void:
	for child in gunManager.get_children():
		child.visible = false
	gunManager.get_child(gunPosToShow).visible = true
	emit_signal("gunChanged",[gunPosToShow])
	updateAmmoCount()
	
func fire_ray_cast_bullet(pushBackAmt : float, shootTimerTimeOut : float) -> void:
	canShoot = false
	shootTimer.wait_time = shootTimerTimeOut
	shootTimer.start()
	if Global.soundAllowed:
		shootNoisePlayer.stream = shootNoiseSoundsArr[1]
		print("shootnoisePLaed")
		shootNoisePlayer.play()
	var diff : Vector3 = (posOfThing.global_transform.origin - gunManager.global_transform.origin).normalized()
	extraVel = -diff * pushBackAmt
	var hitThing = sniperRayCast.get_collider()
	if sniperRayCast.is_colliding() and hitThing:
		if hitThing and !hitThing.is_in_group("player") and hitThing.has_method("die") and !hitThing.is_in_group("sniperImmune"):
			sniperRayCast.get_collider().die()
			print("found an enemy, killed it")
		elif hitThing.is_in_group("sniperImmune") and hitThing.has_method("hurt") :
			sniperRayCast.get_collider().hurt()
	gunParticles.emitting = true 


func spwan_rocket(pushBackAmt : float, shootTimerTimeOut : float, bulSpeed : float) -> void:
	canShoot = false
	shootTimer.wait_time = shootTimerTimeOut
	shootTimer.start()
	if Global.soundAllowed:
		shootNoisePlayer.stream = shootNoiseSoundsArr[0]
		shootNoisePlayer.play()
	var bullet :Area= preload("res://src/player/playerRocket.tscn").instance()
	bullet.player = self
	var diff : Vector3 = (posOfThing.global_transform.origin - gunManager.global_transform.origin).normalized()
	gunParticles.emitting = true

		
	bullet.dir = diff * bulSpeed
	
	get_parent().add_child(bullet)
	extraVel = -diff * pushBackAmt
	bullet.global_transform.origin = global_transform.origin



func spawn_bullet(pushBackAmt : float, shootTimerTimeOut : float, bulSpeed : float, spread:bool,spreadAmt:float, slugOrBullet:bool) -> void:
	gunParticles.emitting = true
	canShoot = false
	shootTimer.wait_time = shootTimerTimeOut
	shootTimer.start()
	if Global.soundAllowed:
		shootNoisePlayer.stream = shootNoiseSoundsArr[0]
		shootNoisePlayer.play()
	var bullet :Area
	if not slugOrBullet:
		bullet = preload("res://src/player/playerBullet.tscn").instance()
	else:
		bullet = preload("res://src/player/playerSlugBullet.tscn").instance()
	bullet.player = self
	var diff : Vector3 = (posOfThing.global_transform.origin - gunManager.global_transform.origin).normalized()
#		bullet.add_to_group("player")
	if spread:
#		var spreadVal := PI/64
		diff += Vector3( rand_range(-spreadAmt,spreadAmt), rand_range(-spreadAmt,spreadAmt), rand_range(-spreadAmt,spreadAmt)  )
#		diff.rotated(Vector3.LEFT, rand_range(-spreadVal,spreadVal))
#		diff.rotated(Vector3.DOWN, rand_range(-spreadVal,spreadVal))
		
	bullet.dir = diff * bulSpeed
	
	get_parent().add_child(bullet)
	extraVel = -diff * pushBackAmt
	bullet.global_transform.origin = global_transform.origin

func sprayFire() -> void:
	flameParticles.emitting = true
	canFlameHurt = true
	if randf() < 0.01:
		gunAmmos[5] -= 1
	updateAmmoCount()
#var gunAmmos := ["Infinite",50,100,50,500]
#var gunArr := ["pistol","rocket","shoutgun","sniper","uzi"]

func updateAmmoCount() -> void:
	if Global.gameMode == "infinite":
		ammoCounter.text = str(gunAmmos[gunPosToShow])
		rocketCount.text = str(gunAmmos[1])
		shotgunCount.text = str(gunAmmos[2])
		sniperCount.text = str(gunAmmos[3])
		uziCount.text = str(gunAmmos[4])
		
		
func subAmmo() -> void:
	gunAmmos[gunPosToShow] -= 1.0
	updateAmmoCount()
	pass


func _physics_process(_delta: float) -> void:

		
		
	
	if Input.is_action_just_pressed("ctrl"):
		speed = slowSpeed
	if Input.is_action_just_released("ctrl") or Input.is_action_just_released("shift"):
		speed = normalSpeed
	if Input.is_action_just_pressed("shift"):
		speed = fastSpeed
			
#	print(vel)
	vel = speed * get_dir().rotated(Vector3.UP,rotation.y)
	vel += extraVel
#	print(extraVel)
	extraVel = lerp(extraVel, Vector3.ZERO, 0.1)

		
	if is_on_ceiling():
		ySpeed += gravity
		
	if !is_on_floor():
		ySpeed += gravity
#		print("not on ground  ", ySpeed)
	elif is_on_floor() or is_on_wall():
		jumpNum = 0
		ySpeed = 0
#		print("on ground  ", ySpeed)
	
	if Input.is_action_just_pressed("space") and jumpNum <= MAXJUMPNUM :
		jumpNum += 1
		ySpeed = JUMPSPEED
		jumpNoisePlayer.play()
#		print(jumpNum)
	
	
	vel.y += ySpeed
	

	vel = move_and_slide(vel, Vector3.UP)
	if !vel.is_equal_approx(Vector3.ZERO):
		animPlayer.play("moving")
	else:
		animPlayer.stop()
#	print(vel.y)

#	if Input.is_action_pressed("movementKey") and animPlayer.is_playing():
#		animPlayer.play("moving")
#	else:
#		animPlayer.stop()


func updateHealthAmount() -> void:
	healthLabel.text = str(health)


func get_dir() -> Vector3:
	var dir : Vector3 = Vector3.ZERO
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
#	animPlayer.play("moving")
	return dir 


func _on_shootTimer_timeout() -> void:
	canShoot = true

func ammoPickedUp() -> void:
	flashIndicator.play("ammoPickup")
	pass

func healthPickedUp() -> void:
	flashIndicator.play("healthPickup")


func die(inputstr="null") -> void:
	if not dead :
		hurtNoisePlayer.play()
		health -= floor(rand_range(Global.minDamageEnemy,Global.maxDamageEnemy))
		flashIndicator.play("hit")
		if health > 0 and inputstr != "good":
			healthPickedUp()
			updateHealthAmount()
		else:
			var dieTextsArr :=[
				"OMG You just died",
				"OMG You died, try again?",
				"It's alright, better luck next time champ!",
				"You still have monsters to kill, try again",
				"Try Again!",
				"Game Over!",
				"You Died!",
				"Try Again",
				"Game Over",
				"You Died"
			]
			dieText.text = dieTextsArr[ floor( dieTextsArr.size()*randf() )  ]
			for child in get_parent().get_children():
				child.set_physics_process(false)
			set_process(false)
			set_physics_process(false)
			get_parent().set_process(false)
			$head/Camera/UISTuff/heartHUD.hide()
			$head/Camera/UISTuff/gunHUD.hide()
			get_parent().didPlayerDie = true
			dead = true
			$head/Camera/UISTuff/LevelNum.hide()
			$head/Camera/UISTuff/LevelNumText.hide()
			$head/Camera/UISTuff/warningNode.hide()
			$head/Camera/UISTuff/warningNode/healthWarning.hide()
			$head/Camera/UISTuff/warningNode/ammoWarning.hide()
			$twoSecDelay.stop()
			$shootTimer.stop()
			Global.playAnimStarting = "start"
			shootTimer.stop()
			canShoot = false
			if inputstr == "good":
				Global.globalHealthNum = health 
				Global.globalAmmoArr = gunAmmos 
				get_tree().change_scene("res://src/inBetweenScene/inBetweenScene.tscn")
	#			dieText.text = "Good job, you finised the monsters on level 1, but there is more to do. I am still working on the game"
			dieScreen.show()
		if inputstr == "dienow":
				health -= 100
				die()


func _on_flameArea_area_entered(area: Area) -> void:
	if area.is_in_group("enemy") and area.has_method("die") and canFlameHurt and !area.is_in_group("flameImmune"):
		area.die()
		print("flamedoing hurt")


#var gunAmmos := ["Infinite",50,100,50,500,200]
#var gunArr := ["pistol","rocket","shoutgun","sniper","uzi","flamethrower"]
func _on_gunButton_pressed() -> void:
	gunPosToShow = 0
	updateGun()


func _on_gunButton2_pressed() -> void:
	gunPosToShow =4
	updateGun()

func _on_gunButton3_pressed() -> void:
	gunPosToShow = 1
	updateGun()


func _on_gunButton4_pressed() -> void:
	gunPosToShow = 2
	updateGun()

func _on_gunButton5_pressed() -> void:
	gunPosToShow = 3
	updateGun()

func _on_gunButton6_pressed() -> void:
	gunPosToShow = 5
	updateGun()


func _on_twoSecDelay_timeout() -> void:
	if global_transform.origin.y < -100:
		dead = true 
		die("dienow")
	$head/Camera/UISTuff/warningNode.show()
	if health < 30:
		healthWarningLabel.show()
		print("low health")
	else:
		healthWarningLabel.hide()
	if typeof(gunAmmos[gunPosToShow]) != TYPE_STRING:
		if gunAmmos[gunPosToShow] < 30:
			ammoWarningLabel.show()
			ammoWarningLabel.text = "Low Ammo"
			if gunAmmos[gunPosToShow] == 0:
				ammoWarningLabel.text = "No Ammo"
			
		
		else:
			ammoWarningLabel.hide()
	else:
		ammoWarningLabel.hide()


func shakeCam() -> void:
	tempRot= rotation_degrees
	print("shooketh the player")
	var randRange := floor(rand_range(1,3)-0.01  )
	cameraShake.play("1")

