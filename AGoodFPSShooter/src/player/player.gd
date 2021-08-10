extends KinematicBody

onready var head := $head
onready var shootNoise := $shootNoise
onready var gunAnimPlayer := $head/gunManager/gunAnimPlayer
onready var gunPos := $head/gunManager/gunPos
onready var gunManager := $head/gunManager
onready var crosshair := $head/crossHair
onready var floorChecker := $floorChecker
onready var sniperRay := $head/sniperRay
onready var meshFlasher := $head/gunManager/meshFlasher
onready var gunTimer := $gunTimer
onready var camShakePlayer := $camShakePlayer

var arrOfGuns := []
const ColorArr := ["red","blue","yellow"]
var colorCycleArr := []
var MAXJUMPNUM := 4
var currentColor := "red"
var JUMPSPEED := 100
var gravity := -5.0
var jumpNum := 0
var ySpeed := 0.0
var speed := 80.0
var normalSpeed := speed
var fastSpeed := normalSpeed
var vel : Vector3
var localMouseSense := 0.15
var extraVel := Vector3.ZERO
var gunPosNum := 0
var health := 100
var canShoot = true
var minDamage := 5
var maxDamage := 10
var posOfColorCycle := 0

func _ready() -> void:
	arrOfGuns = [ 
		$head/gunManager/blueGun,
		$head/gunManager/redGun,
		$head/gunManager/yellowGun
		 ]
	for i in 5:
		colorCycleArr.append( ColorArr[floor(ColorArr.size()*randf())] )
	commonGunSwitchStuff()
	Global.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	gunTimer.connect("timeout",self,"gunTimerTimeOut")

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_x(deg2rad(event.relative.y *localMouseSense *-1))
		self.rotate_y(deg2rad(event.relative.x * localMouseSense * -1))
		var camera_rot = head.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -90, 90)
		head.rotation_degrees = camera_rot
	if global_transform.origin.y < -100:
		die()
	if Input.is_action_pressed("r"):
		print("gotarrr")
#		get_tree().reload_current_scene()
	if event.is_action_pressed("mouseWheelDown"):
		if gunPosNum <= 0:
			gunPosNum = arrOfGuns.size()-1
		else:
			gunPosNum -= 1
		commonGunSwitchStuff()
	if event.is_action_pressed("mouseWheelUp"):
		if gunPosNum >= arrOfGuns.size()-1:
			gunPosNum = 0
		else:
			gunPosNum += 1
		commonGunSwitchStuff()
func _physics_process(_delta: float) -> void:
#	vel = lerp( vel, Vector3.ZERO, 0.5 )
	vel = speed * get_dir().rotated(Vector3.UP,rotation.y)
	vel += extraVel
	extraVel = lerp(extraVel, Vector3.ZERO, 0.1)
#	print(floorChecker.is_colliding())
	if !floorChecker.is_colliding():
		ySpeed += gravity
	else:
		jumpNum = 0
		ySpeed = 0

	if Input.is_action_just_pressed("space") and jumpNum <= MAXJUMPNUM :
		jumpNum += 1
		print('got a jump')
		ySpeed = JUMPSPEED
	if Input.is_action_just_pressed("f"):
		extraVel = (crosshair.global_transform.origin - head.global_transform.origin)*10
	
	vel.y += ySpeed
	
	vel = move_and_slide(vel, Vector3.UP)
	
	if Input.is_action_pressed("lclick") and canShoot:
		shoot()
		print(jumpNum)

func hit() -> void:
	health -= randi()%maxDamage+minDamage
	if health < 0:
		die()
	die()
	pass


func die() -> void:
#	get_tree().reload_current_scene()
	pass


func shoot() -> void:
	gunAnimPlayer.play("shoot")
	shootNoise.play()
	match gunPosNum:
		0:
#			fireColoredBullet("blue")
			fireSniper("blue")
		1:
			fireSniper("red")
#			fireColoredBullet("red")
		2:
			fireSniper("yellow")
#			fireColoredBullet("yellow")
	canShoot = false
	gunTimer.start()
	camShakePlayer.play("shake1")
	commonGunSwitchStuff()
	
func get_dir() -> Vector3:
	var dir : Vector3 = Vector3.ZERO
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if dir:
		gunAnimPlayer.play("walking")
	else:
		gunAnimPlayer.play("idle")
	return dir 

func gunTimerTimeOut() -> void:
	canShoot = true

func gunPosNumUpdate() -> void:
	gunPosNum = gunManager.gunPos
	currentColor = ColorArr[gunPosNum]


func showUI() -> void:
	pass



func fireKinBullet() -> void:
#	var diff : Vector3 = -(pistolPoint.global_transform.origin - crosshair.global_transform.origin).normalized()*7
#	var bullet : Area = preload("res://src/player/bulletKin/playerKinBullet.tscn").instance()
#	get_parent().add_child(bullet)
#	bullet.dir = diff
#	bullet.global_transform.origin = pistolPoint.global_transform.origin
	pass
func fireColoredBullet(color:String) -> void:
	var diff : Vector3 = -(gunPos.global_transform.origin - crosshair.global_transform.origin).normalized()*7
	var bullet : Area = preload("res://src/player/bulletKin/playerKinBullet.tscn").instance()
	bullet.color = color
	get_parent().add_child(bullet)
	bullet.dir = diff
	bullet.global_transform.origin = gunPos.global_transform.origin
	pass
func fireShotGunBullets() -> void:
#	for i in 8:
#		var randAmt := Vector3( randf(),randf(),randf()  )
#		var diff : Vector3 = -(shotGunPoint.global_transform.origin - crosshair.global_transform.origin+randAmt).normalized()*3
#		var bullet : Area = preload("res://src/player/bulletKin/playerKinBullet.tscn").instance()
#		get_parent().add_child(bullet)
#		bullet.dir = diff
#		bullet.global_transform.origin = shotGunPoint.global_transform.origin

	pass

func fireSniper(color:String) -> void:
	if sniperRay.is_colliding():
		var particles : Particles = preload("res://src/player/effects/exploisonEffects.tscn").instance()
		get_parent().add_child(particles)
		particles.myStart()
		particles.material_override = load("res://assets/materials/colorMaterials/"+color+".tres")
		particles.global_transform.origin = sniperRay.get_collision_point()
		if sniperRay.get_collider().is_in_group("enemy") and !sniperRay.get_collider().is_in_group("bullet"):
			print("hit enemy")
			sniperRay.get_collider().hit(color)
	var diff : Vector3 = (sniperRay.global_transform.origin - crosshair.global_transform.origin).normalized()*2
	extraVel = diff
	meshFlasher.play("shoot"+color)
	pass


#func fireGernade() -> void:
#	var gernade : RigidBody = preload("res://src/player/gernades/basic/basicGernade.tscn").instance()
#	var diff : Vector3 = -(shotGunPoint.global_transform.origin - crosshair.global_transform.origin).normalized()*100
#	gernade.dir = diff
#	get_parent().add_child(gernade)
#	gernade.global_transform.origin = gernadePoint.global_transform.origin
#	pass



func commonGunSwitchStuff() -> void:
	for gun in arrOfGuns:
		gun.hide() 
	arrOfGuns[gunPosNum].show()
	pass




