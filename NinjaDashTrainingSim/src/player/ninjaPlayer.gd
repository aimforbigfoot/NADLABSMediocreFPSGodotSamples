extends KinematicBody


signal dashDid

onready var UI := $head/Camera/UI

var health := 100.0
var MOUSE_SENS := 0.005
var gravity := -3
var defaultSpeed := 30.0
var speed := 30.0
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


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$head/Camera/camTween.connect("tween_all_completed",self,"tweenComplete")
#	$generalFixTimer.connect("timeout",self,"generalFix")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$head.rotation.x += -event.relative.y * MOUSE_SENS
		rotation.y += -event.relative.x * MOUSE_SENS


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("r"):
		get_tree().reload_current_scene()

func jump() -> void:
	jumpNum += 1
	ySpeed = jumpStrength

func fanEffect() -> void:
	dashNum = 0
	ySpeed = 0
	UI.numOfBarsToShow(0)

func boxEffect() -> void:
	ySpeed = 0
	dashNum = 0
	jumpNum = 0
	UI.numOfBarsToShow(0)

func dashFoward() -> void:
	emit_signal("dashDid")
	dashNum += 1
	dash()
	UI.dash()
	if sign(ySpeed) == -1:
		ySpeed = 0
	extraVel += ($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin).normalized()*extraVelMulti

func dashBack() -> void:
	emit_signal("dashDid")
	UI.dashDark()
	dashNum += 1
	dash()
	if sign(ySpeed) == -1:
		ySpeed = 0
	extraVel -= ($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin).normalized()*extraVelMulti*2

func _physics_process(delta: float) -> void:
	print(is_on_wall())
	if is_on_wall():
		dashNum = 0
		ySpeed = 0
		UI.numOfBarsToShow(0)
		var temp :Vector3= -(global_transform.origin - Vector3.ZERO).normalized()*500
		temp.y *= -1
		extraVel = temp
#	print(global_transform.origin)
	vel = get_dir().rotated( Vector3.UP, rotation.y) * speed
	if !is_on_floor() and global_transform.origin.y > 1.6:
		ySpeed += gravity
	else:
		ySpeed = 0.0
		canDash = true
		dashNum = 0
		UI.numOfBarsToShow(dashNum)
		jumpNum = 0
	if Input.is_action_just_pressed("space") and (jumpNum < maxJumpAmt):
		jump()
	vel.y = ySpeed
	if Input.is_action_just_pressed("click") and (dashNum < maxDashAmt):
		dashFoward()
	if Input.is_action_just_pressed("rClick")  and (dashNum < maxDashAmt):
		dashBack()
	extraVel = lerp( extraVel, Vector3.ZERO, 0.1 )
	vel += extraVel
	if Input.is_action_just_pressed("shift"):
		vel = Vector3.ZERO
		extraVel = Vector3.ZERO
	
	vel = move_and_slide(vel, Vector3.UP)
	$head.rotation_degrees.z = lerp($head.rotation_degrees.z, angForCamToLearpTo, 0.1)
	$head/Camera.rotation_degrees.x = lerp($head/Camera.rotation_degrees.x, XangForCamToLearpTo, 0.1)

func dash() -> void:
	$head/Camera/camTween.interpolate_property($head/Camera,"fov", 90, 94,0.02,Tween.TRANS_QUART,Tween.EASE_OUT,0)
	$head/Camera/camTween.start()
	UI.numOfBarsToShow(dashNum)
func gotKey() -> void:
	UI.gotKey()
func tweenComplete() -> void:
	$head/Camera/camTweenBack.interpolate_property($head/Camera,"fov", 94, 90,0.07,Tween.TRANS_QUART,Tween.EASE_IN,0)
	$head/Camera/camTweenBack.start()

func get_dir() -> Vector3:
	var dir : Vector3
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	angForCamToLearpTo = dir.x*-2.5
	dir.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	XangForCamToLearpTo = dir.z*7.5
	return dir.normalized()






