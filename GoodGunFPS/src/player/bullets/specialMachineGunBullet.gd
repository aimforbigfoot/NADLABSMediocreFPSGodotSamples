extends Area

var pushBackValue := 1.0
var damageValue := 500.0
var used := false
var dir : Vector3

func _ready() -> void:
	$Timer.connect("timeout",self,"timeOut")
	connect("body_entered",self,"bodyEntered")

func explode() -> void:
	dir = Vector3.ZERO
	$MeshInstance.hide()
	used = true
	var part : Particles = preload("res://src/player/efx/sniperParticles.tscn").instance()
	add_child(part)
	part.scale = Vector3(5,5,5)
	part.connect("done",self,"queFree")

func bodyEntered(body:PhysicsBody) -> void:
	if not body.is_in_group("player") and not body.is_in_group("wind") and not used:
		explode()

func queFree() -> void:
	queue_free()


func timeOut() -> void:
	queue_free()



func _physics_process(delta: float) -> void:
	global_transform.origin += dir
