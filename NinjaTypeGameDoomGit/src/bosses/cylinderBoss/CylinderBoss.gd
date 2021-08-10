extends Area

signal hitGround

var player : KinematicBody
var bossPhase := 0
onready var sideOrbs := $HealthOrbFolderSides
onready var topOrbs := $HealthOrbFolderTop
onready var bottomOrbs := $HealthOrbFolderBottom
onready var moveToTween := $moveToTween
onready var slamGroundTween := $slamGroundTween
onready var dieParticles := $dieParticles
var width := 300
var height := 300
var margin := 20
var cruiseHeight := 80
var dead := false

func _ready() -> void:
	player = get_parent().get_node("player")
	toggleBottomOrbs(true)
	toggleTopOrbs(true)

func die() -> void:
	print("I am immune u smelly")

func _on_oneSecondTimer_timeout() -> void:
	print(checkSideOrbs(),checkTopOrbs(),checkBottomOrbs())
	if !checkSideOrbs():
		bossPhase = 1
	if checkTopOrbs() and !checkSideOrbs():
		bossPhase = 2
		cruiseHeight += 20
		toggleTopOrbs(false)
	if checkBottomOrbs() and !checkTopOrbs() and !checkSideOrbs():
		cruiseHeight += 20
		bossPhase = 3
		toggleBottomOrbs(false)
	if !checkBottomOrbs()and !checkTopOrbs() and !checkSideOrbs():
		kill_boss()
		$oneSecondTimer.stop()
	print(bossPhase)
	

func _on_slamTimer_timeout() -> void:
	if not dead:
	#	slamRandom()
	#	slamPlayer()
		if randf() < 0.25:
			slamRandom()
		else:
			slamPlayer()


func slamRandom() -> void:
	var randX := rand_range(margin,width-margin)
	var randZ := rand_range(margin,height-margin)
	moveToTween.interpolate_property(self,"translation", translation, Vector3(randX,cruiseHeight,randZ),rand_range(1,2),Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	moveToTween.start()

func slamPlayer() -> void:
	moveToTween.interpolate_property(self,"translation", translation, Vector3(player.global_transform.origin.x,cruiseHeight,player.global_transform.origin.z),rand_range(1,2),Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	moveToTween.start()
	pass


func checkSideOrbs() -> bool:
	if sideOrbs.get_children():
		return true
	else:
		return false
func checkBottomOrbs() -> bool:
	if bottomOrbs.get_children():
		return true
	else:
		return false
func checkTopOrbs() -> bool:
	if topOrbs.get_children():
		return true
	else:
		return false

func toggleTopOrbs(bol) -> void:
	for thing in topOrbs.get_children():
		thing.disabled = bol
		thing.visible = !bol
func toggleBottomOrbs(bol) -> void:
	for thing in bottomOrbs.get_children():
		thing.visible = !bol
		thing.disabled = bol
func toggleSideOrbs(bol) -> void:
	for thing in sideOrbs.get_children():
		thing.visible = !bol
		thing.disabled = bol





func _on_moveToTween_tween_all_completed() -> void:
	if not dead:
		slamGroundTween.interpolate_property(self,"translation",translation, Vector3(translation.x,8,translation.z),0.25,Tween.TRANS_CUBIC,Tween.EASE_IN,0)
		slamGroundTween.start()
		$slamNoisePlayer.play()





func _on_CylinderBoss_body_entered(body: Node) -> void:
	if body.is_in_group("player") and body.has_method("die"):
		body.die("dienow")
	else:
		emit_signal("hitGround")



func kill_boss() -> void:
	if not dead:
		dieParticles.emitting = true
		$MeshInstance.hide()
		$CollisionShape.disabled = true
		dead = true
		$dietimer.start()
		$dieNoisePlayer.play()


func _on_dietimer_timeout() -> void:
	queue_free()
