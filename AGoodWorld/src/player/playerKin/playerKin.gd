extends KinematicBody

signal dashDid

onready var UI := $head/Camera/UI

var health := 100.0
var MOUSE_SENS := 0.005
var defaultSpeed := 30.0
var speed := 30.0
var angForCamToLearpTo := 0.0
var XangForCamToLearpTo := 0.0
var vel := Vector3.ZERO
var ySpeed := 0.0
var jumpStrength := 50
var jumpNum := 0
var maxJumpAmt := 3

var starterHP := 100.0
var starterAmmoArr := [20,20,20,20,20,20]

var canDash := true
var dashNum := 0
var extraVelMulti := 100
var maxDashAmt := 3
var extraVel := Vector3.ZERO


func _ready() -> void:
	Global.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$generalFixTimer.connect("timeout",self,"generalFix")
	UI.setHP(starterHP)
	UI.setAmmo(starterAmmoArr[0])

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$head.rotation.x += -event.relative.y * MOUSE_SENS
		rotation.y += -event.relative.x * MOUSE_SENS



func _process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		pass
	if Input.is_action_just_pressed("r"):
		get_tree().reload_current_scene()



func _physics_process(delta: float) -> void:
#	print(global_transform.origin)
	vel = get_dir().rotated( Vector3.UP, rotation.y) * speed
	if !is_on_floor() and global_transform.origin.y > 1.6:
		ySpeed += Global.gravity
	else:
		ySpeed = 0.0
		canDash = true
		dashNum = 0
		jumpNum = 0
	if Input.is_action_just_pressed("space") and (jumpNum < maxJumpAmt):
		jumpNum += 1
		ySpeed = jumpStrength
	vel.y = ySpeed
	if Input.is_action_just_pressed("f") and (dashNum < maxDashAmt):
		emit_signal("dashDid")
		dashNum += 1
		if sign(ySpeed) == -1:
			ySpeed = 0
		extraVel += ($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin).normalized()*extraVelMulti
	extraVel = lerp( extraVel, Vector3.ZERO, 0.1 )
	vel += extraVel
	vel = move_and_slide(vel, Vector3.UP)
	$head.rotation_degrees.z = lerp($head.rotation_degrees.z, angForCamToLearpTo, 0.1)
	$head/Camera.rotation_degrees.x = lerp($head/Camera.rotation_degrees.x, XangForCamToLearpTo, 0.1)
func resetSpeed() -> void:
	$generalFixTimer.start()
	UI.splashWithGoop()
func generalFix() -> void:
	speed = defaultSpeed
func get_dir() -> Vector3:
	var dir : Vector3
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	angForCamToLearpTo = dir.x*-2.5
	dir.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	XangForCamToLearpTo = dir.z*7.5
	return dir.normalized()

func hurt(amt:float = 5.0) -> void:
	health -= amt
	UI.hurt(amt,health)
	if health < 0:
		die()

func die() -> void:
	get_tree().reload_current_scene()
	pass






