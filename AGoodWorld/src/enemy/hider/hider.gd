extends "res://src/enemy/baseEnemy.gd"

func _ready() -> void:
	canJump = false
	$timerFolder/oneSecondTimer.connect("timeout",self,"oneSecondMove")
	$timerFolder/oneSecondTimer.wait_time = rand_range(0.25,0.5)
	$exploisonChecker.connect("body_entered",self,"bodyEntered")


func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		$meshFolder/explosionParticles.emitting = true
		$noisePlayerFolder/dieNoisePlayer.play()
		body.extraVel = (body.global_transform.origin - global_transform.origin).normalized()* 1000
		body.hurt(7.5)

func _process(delta: float) -> void:
	$RayCast.look_at(Global.player.global_transform.origin, Vector3.UP)
func oneSecondMove() -> void:
	if $RayCast.is_colliding():
		if $RayCast.get_collider().is_in_group("player"):
			dir = Vector3(rand_range(-1,1), 0, rand_range(-1,1)).normalized()*speed 
		else:
			dir = Vector3.ZERO
