extends Area
var dir : Vector3

func _ready() -> void:
	connect("body_entered",self,"bodyEntered")

func fadeOut() -> void:
	queue_free()
#	fix for animations like fading out

func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("wall"):
		fadeOut()
		pass

	elif body.is_in_group("enemy"):
		body.dir = body.dir * -2
#		fadeOut()
	dir = Vector3.ZERO

func _physics_process(delta: float) -> void:
	global_transform.origin += dir
