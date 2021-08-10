extends "res://src/enemy/enemyBase.gd"

onready var randLookTimer := $randLookTimer
var newRot :=  Vector3.ONE

func _ready() -> void:
	$meshFolder/EnemyShooter.cross = crosshair
	canFly = true
	global_transform.origin = rand_spot_on_map()
	randomize()
	randLookTimer.connect("timeout",self,"lookAtNewPlace")
	lookAtNewPlace()

func lookAtNewPlace() -> void:
	if not dead:
	#	print("used")
		var waitTime := rand_range(1,5)
		randLookTimer.start(waitTime)
		newRot = Vector3( rand_range(0,2*PI),rand_range(0,2*PI),rand_range(0,2*PI)  )

func _physics_process(delta: float) -> void:
	rotation.y = lerp_angle(rotation.y, newRot.y,0.01)
	rotation.x = lerp_angle(rotation.x, newRot.x,0.01)
	rotation.z = lerp_angle(rotation.z, newRot.z,0.01)
