extends Area

var dir : Vector3

func _ready() -> void:
	connect("body_entered",self,"bodyEntered")
	$Timer.connect("timeout",self,"explode")
	$afterOneSecond.connect("timeout",self,"die")

func bodyEntered(body) -> void:
	if body.is_in_group("wall"):
		dir = Vector3.ZERO
		explode()
	elif body.is_in_group("player"):
		get_tree().reload_current_scene()

func explode() -> void:
	$MeshInstance.hide()
	dir = Vector3.ZERO
	$Particles.emitting = true
	$CollisionShape.disabled = true
	$afterOneSecond.start()

func die() -> void:
	queue_free()


func _physics_process(delta: float) -> void:
	global_transform.origin += dir
