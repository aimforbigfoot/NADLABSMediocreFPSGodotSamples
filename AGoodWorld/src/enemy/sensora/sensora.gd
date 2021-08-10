extends "res://src/enemy/baseEnemy.gd"

func _ready() -> void:
	$playerDetector.connect("body_entered",self,"bodyEntered")
	$timerFolder/oneSecondTimer.wait_time = rand_range(5,10)
	$timerFolder/oneSecondTimer.connect("timeout",self,"stopThatDir")

func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		getNewDir()

func getNewDir() -> void:
	dir =( ( Vector3( rand_range(-Global.mapSize.x*16, Global.mapSize.x*16),0, rand_range(-Global.mapSize.y*16,Global.mapSize.y*16)  )  )-global_transform.origin).normalized()*speed

func stopThatDir() -> void:
	getNewDir()
#	dir = Vector3.ZERO
