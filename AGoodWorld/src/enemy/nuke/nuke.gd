extends RigidBody

var arrOfThings := []

func _ready() -> void:
	connect("body_entered",self,"blowUP")
	$detector.connect("body_entered",self,"collector")
	$detector.connect("body_exited",self,"discarder")
	$explodeTimer.connect("timeout",self,"explodeGood")

func explodeGood() -> void:
	queue_free()

func collector(body) -> void:
	if body.is_in_group("player") or body.is_in_group("enemy"):
		arrOfThings.append(body)

func discarder(body) -> void:
	arrOfThings.erase(body)

func blowUP(body) -> void:
	if not body.is_in_group("enemy"):
		$MeshInstance.hide()
		$explodeTimer.start()
		$exploison.emitting = true
		if (Global.player.global_transform.origin - global_transform.origin).length() < 50:
			for thing in arrOfThings:
				if thing.is_in_group("player"):
					thing.hurt(20)
					thing.extraVel = (thing.global_transform.origin - global_transform.origin).normalized()*500
				elif thing.is_in_group("enemy"):
					thing.die()
