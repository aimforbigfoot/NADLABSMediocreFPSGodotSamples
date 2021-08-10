extends Area

var dir := Vector3.ZERO

func _ready() -> void:
	connect("area_entered",self,"areaEnteredBullet")
	connect("body_entered",self,"bodyEnteredBullet")
	$despawnTimer.connect("timeout",self,"destroyBullet")
#	print("I came into life")


func _physics_process(delta: float) -> void:
	global_transform.origin += dir
	pass

func destroyBullet() -> void:
	queue_free()
	pass


func areaEnteredBullet(area: Area) -> void:
	if !area.is_in_group("player") or !area.is_in_group("enemy"):
		destroyBullet()
	elif area.is_in_group("player"):
		get_tree().reload_current_scene()
#	replace with smth with player dying
		pass

func bodyEnteredBullet(body:PhysicsBody) -> void:
	if !body.is_in_group("player") or body.is_in_group("enemy"):
#		destroyBullet()
		pass
	else:
		get_tree().reload_current_scene()
#	replace with smth with player dying
		pass
