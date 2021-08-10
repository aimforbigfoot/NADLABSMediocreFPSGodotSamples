extends "res://src/enemy/enemyBase.gd"

var sp : Vector3

func _ready() -> void:
	sp = global_transform.origin
	isFlying = true
	ifregularenemyintermsofhittingwallflip = false
	connect("body_entered",self,"flipDirectionBallType")
	dir = Vector3(randf(),randf(),randf()) if randf() < 0.5 else -Vector3(randf(),randf(),randf()) 
	dir *= 11
	connect("died",self,"selfDied")

func selfDied() -> void:
	dir = Vector3.ZERO
	sp = global_transform.origin

func _physics_process(delta: float) -> void:
	global_transform.origin += dir
	look_at(Global.player.global_transform.origin, Vector3.UP)

func flipDirectionBallType(body:PhysicsBody) -> void:
	if body:
#		print("I was suposed to flip")
		var centerHeighted := Vector3( 0, rand_range(123,350),0 )
		dir = -(global_transform.origin - centerHeighted).normalized()*12
	
	pass


