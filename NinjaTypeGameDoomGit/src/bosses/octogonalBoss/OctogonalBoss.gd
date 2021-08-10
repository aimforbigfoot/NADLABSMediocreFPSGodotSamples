extends Spatial

signal moveToPhase2
signal moveToPhase3
signal bossDie 

var dead := false
var player : KinematicBody
var canMove := true
onready var moveAroundTween := $moveAroundTween
onready var oneSecondTimer := $oneSecondTimer
onready var explodeParticles := $explodeParticles
onready var side1 := $sides/side1
onready var side2 := $sides/side2
onready var side3 := $sides/side3
onready var side4 := $sides/side4
onready var side5 := $sides/side5
onready var side6 := $sides/side6
onready var side7 := $sides/side7
onready var side8 := $sides/side8
var angToMoveTo := 0
var phase := 1
var movedToPhase2Flag := false 
var movedToPhase3Flag := false
var angToMoveToY : float = 0.0
var angToMoveToX : float = 0.0
var angToMoveToZ : float = 0.0
onready var sides := $sides


func _ready() -> void:
	explode()
	player = get_parent().get_node("player")
	



func _physics_process(delta: float) -> void:
	sides.rotation.y = lerp_angle( sides.rotation.y,angToMoveToY,0.05  )
	sides.rotation.x = lerp_angle( sides.rotation.z,angToMoveToY,0.05  )
	sides.rotation.z = lerp_angle( sides.rotation.x,angToMoveToY,0.05  )



func _on_oneSecondTimer_timeout() -> void:
	angToMoveToY = rand_range(0,2*PI)
	angToMoveToX = rand_range(0,2*PI)
	angToMoveToZ = rand_range(0,2*PI)
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
	side5.updatePhase()
	side6.updatePhase()
	side7.updatePhase()
	side8.updatePhase()

	if side1.phase == 2 and side2.phase == 2 and side3.phase == 2 and side4.phase == 2 and side5.phase == 2 and side6.phase == 2 and  side7.phase == 2 and side8.phase == 2 and not movedToPhase2Flag:
		phase = 2
		movedToPhase2Flag = true 
		emit_signal("moveToPhase2")
	elif side1.phase == 3 and side2.phase == 3 and side3.phase == 3 and side4.phase == 3  and side5.phase == 3 and side6.phase == 3 and  side7.phase == 3 and side8.phase == 3 and not movedToPhase3Flag:
		phase = 3
		movedToPhase3Flag = true 
		emit_signal("moveToPhase3")
	elif side1.phase == 4 and side2.phase == 4 and side3.phase == 4 and side4.phase == 4  and side5.phase == 4 and side6.phase == 4 and  side7.phase == 4 and side8.phase == 4 :
		phase = 4
		explode()


func moveAround() -> void:
	if canMove:
		var randX := rand_range(120,200)
		var randY := rand_range(50,300)
		var randZ := rand_range(100,200)
		moveAroundTween.interpolate_property(self,"translation", translation, Vector3( randX, randY, randZ ), 2,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT)
		moveAroundTween.start()
		canMove = false

func moveAroundLikeMad() -> void:
	if canMove:
		var randX := rand_range(80,230)
		var randZ := rand_range(80,230)
		var randY := rand_range(50,300)
		moveAroundTween.interpolate_property(self,"translation", translation, Vector3( randX, randY, randZ ), 1,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT)
		moveAroundTween.start()
		canMove = false


func explode() -> void:
	explodeParticles.emitting = true
	emit_signal("bossDie")
	if phase == 4 and not dead:
		dead = true
		side1.queue_free()
		side2.queue_free()
		side3.queue_free()
		side4.queue_free()
		side5.queue_free()
		side6.queue_free()
		side7.queue_free()
		side8.queue_free()
		oneSecondTimer.stop()


func _on_moveAroundTween_tween_all_completed() -> void:
	canMove = true


func _on_OctogonalBoss_moveToPhase2() -> void:
	explode()
	side1.moveToPhase2()
	side2.moveToPhase2()
	side3.moveToPhase2()
	side4.moveToPhase2()
	side5.moveToPhase2()
	side6.moveToPhase2()
	side7.moveToPhase2()
	side8.moveToPhase2()

func _on_OctogonalBoss_moveToPhase3() -> void:
	explode()
	side1.moveToPhase3()
	side2.moveToPhase3()
	side3.moveToPhase3()
	side4.moveToPhase3()
	side5.moveToPhase3()
	side6.moveToPhase3()
	side7.moveToPhase3()
	side8.moveToPhase3()

func _on_OctogonalBoss_bossDie() -> void:
	pass # Replace with function body.
