extends KinematicBody


signal gotRubySignal

var didGetRuby := false
var MOUSE_SENS := 0.001
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
export var inAHub := false

var canDash := true
var dashNum := 0
var extraVelMulti := 100
var maxDashAmt := 3
var extraVel := Vector3.ZERO
var IsGrappling := false
var pointIAmGrapplingWith: StaticBody

func _ready() -> void:
	OS.window_fullscreen = true
#	Global.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event is InputEventMouseMotion:
		$head.rotation.x += -event.relative.y * MOUSE_SENS
		rotation.y += -event.relative.x * MOUSE_SENS


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("r"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("o"):
		if OS.window_fullscreen == true:
			OS.window_fullscreen = false
		else:
			OS.window_fullscreen = true
func jump() -> void:
	jumpNum += 1
	ySpeed = jumpStrength

func dashFoward() -> void:
	emit_signal("dashDid")
	dashNum += 1
	if sign(ySpeed) == -1:
		ySpeed = 0
	extraVel += ($head/Camera/Position3D.global_transform.origin - $head/Camera.global_transform.origin).normalized()*extraVelMulti

func checkAndGrapple() -> void:
	if $head/Camera/RayCast.is_colliding() and not IsGrappling:
		if $head/Camera/RayCast.get_collider().is_in_group("grapplePoint"):
			IsGrappling = true
			pointIAmGrapplingWith = $head/Camera/RayCast.get_collider()
			$head/Camera/UI/AnimatedSprite.play("toClose")
#			dashNum = 0
			jumpNum = 0 
#			vel.y = 0
#			ySpeed = 0
			$AudioStreamPlayer3D.play()

func resetFromGrapple() -> void:
	gravity = -2.75
	IsGrappling = false
	$head/Camera/UI/AnimatedSprite.play("toOpen")
	$head/Camera/MeshInstance/Position3D.hide()
 
func _physics_process(delta: float) -> void:
#	print(is_on_wall())
	vel =  get_dir().rotated( Vector3.UP, rotation.y) * speed * 3  if IsGrappling else  get_dir().rotated( Vector3.UP, rotation.y) * speed 
	
	if !is_on_floor() or global_transform.origin.y > 0 and ySpeed > -100:
		ySpeed += gravity
	else:
		ySpeed = 0.0
		canDash = true
		dashNum = 0
		jumpNum = 0
	if Input.is_action_just_pressed("space") and (jumpNum < maxJumpAmt) and not IsGrappling:
		jump()
	vel.y = ySpeed
	if abs(vel.x) > 10 and abs(vel.z) > 10:
		$head/Camera.fov = lerp( $head/Camera.fov,  (  70+ vel.length()/8  ) , 0.2 )
		$head/Camera.fov = clamp( $head/Camera.fov, 70, 178 )
		print($head/Camera.fov)
	if IsGrappling:
		$head/Camera/MeshInstance/Position3D.look_at(pointIAmGrapplingWith.global_transform.origin, Vector3.UP)
		$head/Camera/MeshInstance/Position3D.show()
#		vel.normalized()*600
		var forceOfGrapple :Vector3= (pointIAmGrapplingWith.global_transform.origin - global_transform.origin)
#		print(forceOfGrapple.length())
		if forceOfGrapple.length() > 40:
			extraVel += ($head/Camera/Position3D.global_transform.origin - global_transform.origin).normalized()  * 2000/forceOfGrapple.length() 
		elif forceOfGrapple.length() > 20:
			extraVel += ($head/Camera/Position3D.global_transform.origin - global_transform.origin).normalized()  
		else:
			IsGrappling = false
			resetFromGrapple()
	if Input.is_action_just_pressed("click") and $head/Camera/RayCast.is_colliding():
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if $head/Camera/RayCast.get_collider().is_in_group("grapplePoint"):
			ySpeed = 0
			vel.y = 0
	if Input.is_action_pressed("click"):
		checkAndGrapple()
	if Input.is_action_just_released("click"):
		resetFromGrapple()
#	if Input.is_action_just_pressed("f") and (dashNum < maxDashAmt):
#		dashFoward()
	
	
	extraVel = lerp( extraVel, Vector3.ZERO, 0.1 )
	vel += extraVel

	vel = move_and_slide(vel, Vector3.UP)
	$head.rotation_degrees.z = lerp($head.rotation_degrees.z, angForCamToLearpTo, 0.1)
	$head/Camera.rotation_degrees.x = lerp($head/Camera.rotation_degrees.x, XangForCamToLearpTo, 0.1)

func rubyGot() -> void:
	$head/Camera/UI/AnimationPlayer.play("rubyGot")
	emit_signal("gotRubySignal")
	pass

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






