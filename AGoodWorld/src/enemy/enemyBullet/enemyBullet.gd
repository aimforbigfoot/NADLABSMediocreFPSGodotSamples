extends Area


var dir : Vector3

func _ready() -> void:
	connect("body_entered",self,"bodyEntered")
	$bulletGone.connect("timeout",self,"timeOut")

func timeOut() -> void:
	queue_free()

func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		body.hurt(3)
		body.extraVel = dir * 100
		queue_free()
	elif body.is_in_group("wall") or body.is_in_group("obstacle"):
		queue_free()

func _physics_process(delta: float) -> void:
	global_transform.origin += dir
