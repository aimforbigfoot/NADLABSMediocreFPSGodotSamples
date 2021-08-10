extends "res://src/enemy/0base/enemy.gd"
var angToLookAt := 0.0
var charging := false 
var chargingAtPlayer := false
var waitTime := rand_range(1.2,3)

func _ready() -> void:
	$Tween.connect("tween_all_completed",self,"tweenDone")
	$Tween2.connect("tween_all_completed",self,"tweenDone")
	$Tween3.connect("tween_all_completed",self,"tweenDone")
	$Tween4.connect("tween_all_completed",self,"tweenDone")
	everySecond()
	$Tween5.connect("tween_all_completed",self,"goBackToRestPos")
	$Tween6.connect("tween_all_completed",self,"goBackToRestPos")
	$Tween7.connect("tween_all_completed",self,"goBackToRestPos")
	$Tween8.connect("tween_all_completed",self,"goBackToRestPos")
	
	tweenDone()

func tweenDone() -> void:
	$Tween5.interpolate_property($meshFolder/Icosphere001, "rotation_degrees:y",$meshFolder/Icosphere001.rotation_degrees.y, -40, waitTime - 0.1,Tween.TRANS_CIRC,Tween.EASE_IN)
	$Tween5.start()
	$Tween6.interpolate_property($meshFolder/Icosphere002, "rotation_degrees:y",$meshFolder/Icosphere002.rotation_degrees.y, -40, waitTime - 0.1,Tween.TRANS_CIRC,Tween.EASE_IN)
	$Tween6.start()
	$Tween7.interpolate_property($meshFolder/Icosphere003, "rotation_degrees:y",$meshFolder/Icosphere003.rotation_degrees.y, 40, waitTime - 0.1,Tween.TRANS_CIRC,Tween.EASE_IN)
	$Tween7.start()
	$Tween8.interpolate_property($meshFolder/Icosphere004, "rotation_degrees:y",$meshFolder/Icosphere004.rotation_degrees.y, 40, waitTime - 0.1,Tween.TRANS_CIRC,Tween.EASE_IN)
	$Tween8.start()
func goBackToRestPos() -> void:
	$Tween.interpolate_property($meshFolder/Icosphere001, "rotation_degrees:y",$meshFolder/Icosphere001.rotation_degrees.y, 25, 0.2,Tween.TRANS_CIRC,Tween.EASE_IN)
	$Tween.start()
	$Tween2.interpolate_property($meshFolder/Icosphere002, "rotation_degrees:y",$meshFolder/Icosphere002.rotation_degrees.y, 25, waitTime - 0.1,Tween.TRANS_CIRC,Tween.EASE_IN)
	$Tween2.start()
	$Tween3.interpolate_property($meshFolder/Icosphere003, "rotation_degrees:y",$meshFolder/Icosphere003.rotation_degrees.y, -25, waitTime - 0.1,Tween.TRANS_CIRC,Tween.EASE_IN)
	$Tween3.start()
	$Tween4.interpolate_property($meshFolder/Icosphere004, "rotation_degrees:y",$meshFolder/Icosphere004.rotation_degrees.y, -25, waitTime - 0.1,Tween.TRANS_CIRC,Tween.EASE_IN)
	$Tween4.start()
func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("player") and chargingAtPlayer:
		body.extraVel = (body.global_transform.origin - global_transform.origin).normalized() * speed * 10
	dir = -(body.global_transform.origin - global_transform.origin).normalized() * speed 
	

func af(an:String) -> void:
	pass

func everySecond() -> void:
	if not charging:
		dir = ( Vector3( rand_range(-95,95), rand_range(-20,95), rand_range(-95,95) ) - global_transform.origin  ).normalized()*speed
		$meshFolder/idleAndDeath.play("idle")
		$everySecond.start(waitTime)
		angToLookAt = Vector2( global_transform.origin.x, global_transform.origin.z ).angle_to_point( Vector2( global_transform.origin.x + dir.x , global_transform.origin.z + + dir.z )  )
		chargingAtPlayer = false
	else:
		dir = ( player.global_transform.origin - global_transform.origin  ).normalized() * speed * 8 + player.vel
		$GrowAndShrink.interpolate_property( $meshFolder, "scale", Vector3.ONE*5, Vector3.ONE, 0.5,Tween.TRANS_CUBIC, Tween.EASE_OUT )
		$GrowAndShrink.start()
		$everySecond.start(3)
		charging = false
		$chargeUpNoise.play()
		chargingAtPlayer = true
#		$meshFolder/idleAndDeath.play("chargingDown")
#	if charging:
#		yield(get_tree().create_timer(0.5), "timeout")
	if randf() < 0.05:
		$chargeUpNoise.pitch_scale = rand_range(0.8,1.2)

		$everySecond.start(5)
		chargingAtPlayer = true 
		$GrowAndShrink.interpolate_property( $meshFolder, "scale", Vector3.ONE, Vector3.ONE*5, 5,Tween.TRANS_BOUNCE, Tween.EASE_IN )
		$GrowAndShrink.start()
		charging = true
#		$meshFolder/idleAndDeath.play("chargingUp")

func _physics_process(delta: float) -> void:
	dir = dir.linear_interpolate(Vector3.ZERO, 0.05)
#	look_at(player.global_transform.origin, Vector3.UP)
	if chargingAtPlayer:
		look_at(player.global_transform.origin, Vector3.UP)
	else:
		rotation.y = lerp_angle( rotation.y, angToLookAt, 0.4  )
