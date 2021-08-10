extends "res://src/enemy/enemyBase.gd"

var ySpotToMoveTo := 0.0
var dirLerp := Vector3.ZERO

func _ready() -> void:
	var dir := Vector3(randf(),randf(),randf())
	$moveAroundTwoSecond.connect("timeout",self,"moveTimedOut")
	global_transform.origin.y = rand_range(200,500)
	connect("died",self,"selfDied")

func selfDied() -> void:
	$moveAroundTwoSecond.stop()
	$AnimationPlayer.stop()
func moveTimedOut() -> void:
	fireShotgunTowardPlayer()
	$moveAroundTwoSecond.wait_time = rand_range(2,3)
	ySpotToMoveTo = rand_range(200,500)
	dirLerp = (Global.player.global_transform.origin - global_transform.origin).normalized()*10
	dir = lerp(dir, dirLerp, 0.02)
	global_transform.origin += dir


func _physics_process(delta: float) -> void:
	global_transform.origin.y = lerp(global_transform.origin.y,ySpotToMoveTo, 0.02)
	look_at(Global.player.global_transform.origin, Vector3.UP)
