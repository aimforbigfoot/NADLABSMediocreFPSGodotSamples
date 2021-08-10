extends Area

var dir := Vector3.ZERO

func _ready() -> void:
	$despawnBullet.connect("timeout",self,"despawnBullet")
	connect("body_entered",self,"bodyEnetered")

func _physics_process(delta: float) -> void:
	global_transform.origin += dir*3

func bodyEnetered(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
#		player hurt here
		body.die()
		pass
	else:
		despawnBullet()
	pass


func despawnBullet() -> void:
	$MeshInstance.hide()
	dir = Vector3.ZERO
	var timer := Timer.new()
	$bulletDespawnPlayer.play()
	$Particles.emitting = false
	add_child(timer)
	timer.start(0.5)
	$Particles2.emitting = true
	timer.connect("timeout",self,"queFreeTimer")


func queFreeTimer() -> void:
	queue_free()

