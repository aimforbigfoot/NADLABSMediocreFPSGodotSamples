extends Area
var dir : Vector3
var exploded := false
var enemyFolder : Spatial
var player :KinematicBody

func _ready() -> void:
	connect("body_entered",self,"bodyEntered")

func explode() -> void:
	if not exploded:
		exploded = true
		dir = Vector3.ZERO
		$meshFolder/Particles.emitting = false
		$meshFolder.hide()
		for enemy in enemyFolder.get_children():
			var diff :Vector3= global_transform.origin - enemy.global_transform.origin
			if enemy.is_in_group('enemy') and diff.length() < 50:
				print("yes")
				enemy.dir = -diff * 10
				enemy.hurt(75)
		var pdiff :Vector3 = global_transform.origin - player.global_transform.origin
		if pdiff.length() < 50:
			player.extraVel = -pdiff.normalized() * 500
		$explodeParticles.emitting = true
	

func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("wall") or body.is_in_group("enemy"):
		explode()

func _physics_process(delta: float) -> void:
	global_transform.origin += dir
