extends Area

signal moveToPhase2
signal moveToPhase3
signal bossDie 
# THERE MAY BE AN ISSUE WITH THE MUSIC AND NOISES OF BOSSES
var dead := false
var player : KinematicBody
var canMove := true
onready var moveAroundTween := $moveAroundTween
onready var oneSecondTimer := $oneSecondTimer
onready var explodeParticles := $explodeParticles
onready var side1 := $side1
onready var side2 := $side2
onready var side3 := $side3
onready var side4 := $side4
var angToMoveTo := 0
var phase := 1
var movedToPhase2Flag := false 
var movedToPhase3Flag := false

func _ready() -> void:
	explode()
	player = get_parent().get_node("player")
	


func _on_oneSecondTimer_timeout() -> void:
	var randAmt := randf()
	if randAmt < 0.25:
		side1.smash()
	elif randAmt < 0.5:
		side2.smash()
	elif randAmt < 0.75:
		side3.smash()
	else:
		side4.smash()
	if phase == 1:
		angToMoveTo = rand_range(0,PI/4)
		oneSecondTimer.wait_time = 1
	elif phase == 2:
		angToMoveTo = rand_range(0,PI)
		oneSecondTimer.wait_time = 0.75
		moveAround()
		
	elif phase == 3:
		angToMoveTo = rand_range(0,2*PI)
		oneSecondTimer.wait_time = 0.6
		moveAroundLikeMad()
	side1.updatePhase()
	side2.updatePhase()
	side3.updatePhase()
	side4.updatePhase()

	if side1.phase == 2 and side2.phase == 2 and side3.phase == 2 and side4.phase == 2 and not movedToPhase2Flag:
		phase = 2
		movedToPhase2Flag = true 
		emit_signal("moveToPhase2")
	elif side1.phase == 3 and side2.phase == 3 and side3.phase == 3 and side4.phase == 3 and not movedToPhase3Flag:
		phase = 3
		movedToPhase3Flag = true 
		emit_signal("moveToPhase3")
	elif side1.phase == 4 and side2.phase == 4 and side3.phase == 4 and side4.phase == 4:
		phase = 4
		explode()


func moveAround() -> void:
	if canMove:
		var randX := rand_range(120,200)
		var randZ := rand_range(120,200)
		moveAroundTween.interpolate_property(self,"translation", translation, Vector3( randX, 28, randZ ), 2,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT)
		moveAroundTween.start()
		canMove = false

func moveAroundLikeMad() -> void:
	if canMove:
		var randX := rand_range(80,230)
		var randZ := rand_range(80,230)
		
		moveAroundTween.interpolate_property(self,"translation", translation, Vector3( randX, 28, randZ ), 1,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT)
		moveAroundTween.start()
		canMove = false

func _physics_process(delta: float) -> void:
	rotation.y = lerp_angle( rotation.y, angToMoveTo, 0.05 )


func _on_pyramidBoss_moveToPhase2() -> void:
	explode()
	side1.moveToPhase2()
	side2.moveToPhase2()
	side3.moveToPhase2()
	side4.moveToPhase2()


func _on_pyramidBoss_moveToPhase3() -> void:
	explode()
	side1.moveToPhase3()
	side2.moveToPhase3()
	side3.moveToPhase3()
	side4.moveToPhase3()


func explode() -> void:
	explodeParticles.emitting = true
	emit_signal("bossDie")
	if phase == 4 and not dead:
		dead = true
		side1.queue_free()
		side2.queue_free()
		side3.queue_free()
		side4.queue_free()
		oneSecondTimer.stop()


func _on_moveAroundTween_tween_all_completed() -> void:
	canMove = true
