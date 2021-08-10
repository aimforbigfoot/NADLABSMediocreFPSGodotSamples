extends "res://src/enemy/baseEnemy.gd"

var predictive := 20


func _ready() -> void:
	isFlyingType = true
	$timerFolder/oneSecondTimer.connect("timeout",self,"oneScondCheck")


func oneScondCheck() -> void:
	var goToPos : Vector3 = Global.player.global_transform.origin + (Global.player.vel)*predictive
	
	dir = ( goToPos - global_transform.origin  ).normalized()*speed
	dir.y /= 4
