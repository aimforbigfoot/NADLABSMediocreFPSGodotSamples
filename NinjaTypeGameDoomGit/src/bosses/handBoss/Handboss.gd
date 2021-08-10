extends Area

var dead := false
onready var phase1Tween := $phase1Tween
onready var animSprite := $faceAndOrbs/AnimatedSprite3D
onready var faceAndOrbs := $faceAndOrbs
onready var hand := $hand
onready var handTween := $handTween
onready var handBackTween := $handBackTween
onready var hand2Tween := $hand2Tween
onready var hand2BackTween := $hand2BackTween
onready var explosionParticles := $faceAndOrbs/explosionParticles
onready var phase1Orbs := $faceAndOrbs/phase1Orbs
onready var phase2Orbs := $faceAndOrbs/phase2Orbs
onready var phase3Orbs := $faceAndOrbs/phase3Orbs
onready var collisionShapeOfFace := $CollisionShape
onready var hand2 := $hand2
onready var clapperNoise := $clapperNoise
var movSpeed := 0.1
var canShowExplode := true
var handsStop := false
var hands2Stop := false
var phase := 1
var phase1OrbBool := false
var phase2OrbBool := false
var phase3OrbBool := false 
var player : KinematicBody

func _ready() -> void:
	explode()
	player = get_parent().get_node("player")
	hand.player = player
	hand2.player = player
	phase1Orbs.show()
	togglephase1Orbs(false)
	togglephase2Orbs(true)
	togglephase3Orbs(true)

func _on_moveTimer_timeout() -> void:
	if phase == 1:
		var randX := rand_range(-150,150)
		var randYAmt := rand_range(-10,10)
		var randTime := rand_range(1,3)
		phase1Tween.interpolate_property(faceAndOrbs,"translation",faceAndOrbs.translation,Vector3(randX,faceAndOrbs.translation.y,-50),randTime,Tween.TRANS_BACK,Tween.EASE_IN_OUT)
		phase1Tween.start()
		$moveTimer.start(randTime)
		pass
	elif phase == 2:
		var randY := rand_range(0,100)
		var randYAmt := rand_range(-10,10)
		var randTime := rand_range(1,3)
		phase1Tween.interpolate_property(faceAndOrbs,"translation",faceAndOrbs.translation,Vector3(0,randY,rand_range(-10,-50)),randTime,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT)
		phase1Tween.start()
		$moveTimer.start(randTime)
	elif phase == 3:
		var randX := rand_range(-150,150)
		var randY := rand_range(0,100)
		var randYAmt := rand_range(-10,10)
		var randTime := rand_range(1,3)
		phase1Tween.interpolate_property(faceAndOrbs,"translation",faceAndOrbs.translation,Vector3(randX,randY,rand_range(-10,-50)),randTime,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT)
		phase1Tween.start()
		$moveTimer.start(randTime)


func _physics_process(delta: float) -> void:
	if not handsStop:
		hand.global_transform.origin.z = lerp( hand.global_transform.origin.z, player.global_transform.origin.z , movSpeed)
	if not hands2Stop:
		hand2.global_transform.origin.z = lerp( hand2.global_transform.origin.z, player.global_transform.origin.z ,movSpeed)
	collisionShapeOfFace.global_transform.origin = animSprite.global_transform.origin
	pass


func _on_handClapTimer_timeout() -> void:
	handsStop = true
	clapperNoise.play()
	handTween.interpolate_property(hand,"translation",hand.translation,Vector3(0,hand.translation.y,hand.translation.z),1,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	handTween.start()
	hand2Tween.interpolate_property(hand2,"translation",hand2.translation,Vector3(0,hand2.translation.y,hand2.translation.z),1,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	hand2Tween.start()
	





func _on_handTween_tween_completed(object: Object, key: NodePath) -> void:
	if object and key:
		print("handed moved stop")
		handBackTween.interpolate_property(hand,"translation",hand.translation,Vector3(-175,hand.translation.y,hand.translation.z),1,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
		handBackTween.start()
	if phase == 3:
		player.shakeCam()
		

func _on_handBackTween_tween_completed(object: Object, key: NodePath) -> void:
	if object and key:
		handsStop = false


func _on_hand2Tween_tween_completed(object: Object, key: NodePath) -> void:
	if object and key:
		hand2BackTween.interpolate_property(hand2,"translation",hand2.translation,Vector3(175,hand2.translation.y,hand2.translation.z),1,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
		hand2BackTween.start()


func _on_hand2BackTween_tween_completed(object: Object, key: NodePath) -> void:
	if object and key:
		hands2Stop = false 




func checkphase1Orbs() -> bool:
	if phase1Orbs.get_children():
		return true
	else:
		return false
func checkphase2Orbs() -> bool:
	if phase2Orbs.get_children():
		return true
	else:
		return false
func checkphase3Orbs() -> bool:
	if phase3Orbs.get_children():
		return true
	else:
		return false

func togglephase1Orbs(bol) -> void:
	for thing in phase1Orbs.get_children():
		thing.disabled = bol
		thing.visible = !bol
func togglephase2Orbs(bol) -> void:
	for thing in phase2Orbs.get_children():
		thing.visible = !bol
		thing.disabled = bol
func togglephase3Orbs(bol) -> void:
	for thing in phase3Orbs.get_children():
		thing.visible = !bol
		thing.disabled = bol






func _on_oneSecondCheckerTimer_timeout() -> void:
	if !checkphase1Orbs() and not phase1OrbBool:
		print("true")
		phase = 2
		phase1OrbBool = true
		print('yes')
		canShowExplode = true 
		phase2Orbs.show()
		togglephase2Orbs(false)
		explode()
		
	if !checkphase2Orbs() and !checkphase1Orbs() and not phase2OrbBool:
		phase = 3
		phase2OrbBool = true
		canShowExplode = true 
		phase3Orbs.show()
		togglephase3Orbs(false)
		explode()
		
	if !checkphase3Orbs() and !checkphase2Orbs() and !checkphase1Orbs() and not phase3OrbBool:
		hands2Stop = true
		phase3OrbBool = true
		handsStop = true
		phase = 4
		canShowExplode = true 
		explode()
		
	print(phase)
	animSprite.play(str(phase))


func explode() -> void:
	if canShowExplode:
		explosionParticles.emitting = true
		canShowExplode = false
	if phase == 4:
		print('die explode')
		animSprite.hide()
		hands2Stop = true
		handsStop = true
		dead = true
		$moveTimer.stop()
		$handClapTimer.stop()
		$oneSecondCheckerTimer.stop()
	$bossDiePlayer.play()
#	make him explode, then kill him, spawn protal and make sure the particles hide each phase transition


func _on_afterExplodeTimer_timeout() -> void:
	pass # Replace with function body.
