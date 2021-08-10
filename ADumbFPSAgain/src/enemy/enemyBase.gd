extends Area

signal died
signal firedBullet
var dead := false 
var state := "idle"
var angToLookTo := 0.0
var isShooter := true
var isShotgunner := false
var isFlying := false
var isSpecialPlacement := false
var dir := Vector3.ZERO
var health := 10.0
var meantToLookAtPlayer := true
var ifregularenemyintermsofhittingwallflip := true
var margOfError := 3
var iflookingAtPlayerEverySec := true

func _ready() -> void:
	randomize()
	
	$explodeTimer.connect("timeout",self,"explodeFinished")
	$oneSecondTimer.connect("timeout",self,"everyOneSecond")
	if ifregularenemyintermsofhittingwallflip:
		connect("body_entered",self,"flipDirection")
		connect("area_entered",self,"flipDirectionArea")
	$oneSecondTimer.start(rand_range(1,2))

func everyOneSecond() -> void:
	if iflookingAtPlayerEverySec and not state == "dead" and isShooter:
		var playerVec := Vector2(Global.player.global_transform.origin.z, Global.player.global_transform.origin.x )
		var selfVec :=  Vector2( global_transform.origin.z,global_transform.origin.x )
		angToLookTo = selfVec.angle_to_point(playerVec) + PI
		if not isShotgunner:
			fireBulletTowardPlayer()
		else:
			fireShotgunTowardPlayer()
		$oneSecondTimer.wait_time = rand_range(0.5,3)

func fireBulletTowardPlayer(accuracyAmt : float= 1) -> void:
	emit_signal("firedBullet")
	var randAccForEnemy := Vector3( (randf() if randf() < 0.5 else -randf()),(randf() if randf() < 0.5 else -randf()),(randf() if randf() < 0.5 else -randf())   )*accuracyAmt
	var bullet :Area= preload("res://src/enemy/enemyBullet/enemyBullet.tscn").instance()
	get_parent().add_child(bullet)
	bullet.global_transform.origin = $crosshair.global_transform.origin
	bullet.dir = (Global.player.global_transform.origin - $crosshair.global_transform.origin + randAccForEnemy).normalized()*5
	$noises/shootPlayer.pitch_scale = rand_range(0.9,1.1)
	$noises/shootPlayer.play()


func fireShotgunTowardPlayer() -> void:
	for i in 10:
		fireBulletTowardPlayer(200)


func _process(delta: float) -> void:
	$RayCast.look_at(Global.player.global_transform.origin, Vector3.UP)
	if $RayCast.is_colliding():
		if $RayCast.get_collider().is_in_group("player"):
			state = "active"
		else:
			state= "idle"


func hit(amtDamage:float=10.0) -> void:
	health -= rand_range(amtDamage-margOfError,amtDamage+margOfError)
	if health <= 0:
		die()


#func _physics_process(delta: float) -> void:
#	if meantToLookAtPlayer:
#		rotation.y = lerp_angle( rotation.y, angToLookTo, 0.1 )


func flipDirection(body:PhysicsBody) -> void:
	if body and !self.is_in_group('wallavoid'):
		dir *= -1
	elif body.is_in_group("player"):
		body.die()


func flipDirectionArea(area:Area) -> void:
	if area.is_in_group("enemy"):
		dir *= -1


func die() -> void:
	$oneSecondTimer.stop()
	dead = true
	state = "dead"
	$explosionParticles.emitting = true
	dir = Vector3.ZERO
	$MeshInstance.hide()
	$CollisionShape.disabled = true
	$noises/noisePlayer.play()
	for i in 20:
		var gib :RigidBody= preload("res://src/enemy/enemyGibs/enemyGibs.tscn").instance()
		get_parent().add_child(gib)
		gib.global_transform.origin = global_transform.origin
	$explodeTimer.start()
#	VVV
func explodeFinished() -> void:
	queue_free()
	emit_signal("died")
	pass











