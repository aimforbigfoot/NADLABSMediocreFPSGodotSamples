extends "res://src/enemy/enemyBase.gd"

func _ready() -> void:
	canFly = true
	global_transform.origin = rand_spot_on_map()

func _physics_process(delta: float) -> void:
	if not dead:
		$meshFolder/arms.rotation_degrees.y += 1
		$meshFolder/body.look_at(Global.player.global_transform.origin, Vector3.UP)
	pass
