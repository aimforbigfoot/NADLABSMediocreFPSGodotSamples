extends "res://src/enemy/enemyBase.gd"

var dirLerp := Vector3.ZERO

func _ready() -> void:
	isFlying = false
	global_transform.origin.y = 0.0
	$fourSecRelay.connect("timeout",self,"moveTowardPlayerAgresively")
	connect("died",self,"selfDied")

func selfDied() -> void:
	$fourSecRelay.stop()
	$AnimationPlayer.stop()
func moveTowardPlayerAgresively() -> void:
	var diff := Vector3.ZERO
	var amt := 50.0
	if randf() < 0.5:
		diff = (Global.player.global_transform.origin  - global_transform.origin + Vector3(randf()*amt,0,randf()*amt) ).normalized()*10 
		diff.y = 0.0
	else:
		diff = (Vector3(rand_range(-Global.maxSize,Global.maxSize),0,rand_range(-Global.maxSize,Global.maxSize)) - global_transform.origin ).normalized()*5
		diff.y = 0.0
	global_transform.origin.y = 0
	dirLerp = diff

func _physics_process(delta: float) -> void:
	dir = lerp( dir, dirLerp, 0.05 )
	global_transform.origin += dir
	var playerVec := Vector2(Global.player.global_transform.origin.z, Global.player.global_transform.origin.x )
	var selfVec :=  Vector2( global_transform.origin.z,global_transform.origin.x )
	angToLookTo = selfVec.angle_to_point(playerVec) + PI
	rotation.y = angToLookTo
