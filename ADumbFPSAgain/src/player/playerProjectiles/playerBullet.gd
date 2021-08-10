extends Area

var dir := Vector3.ZERO

func _ready() -> void:
	connect("area_entered",self,"enteredArea")
	connect("body_entered",self,"bodyEntered")
	$bulletDespawnTimer.connect("timeout",self,"explode")
	$particlesTimeWai.connect("timeout",self,"queFree")

func _physics_process(delta: float) -> void:
	global_transform.origin += dir

func bodyEntered(body:PhysicsBody) -> void:
	if body:
		explode()

func enteredArea(area) -> void:
	if area.is_in_group("enemy"):
		explode()
		area.hit()


func explode() -> void:
	dir = Vector3.ZERO
	$MeshInstance.hide()
	$Particles2.emitting = true
	$particlesTimeWai.start()

func queFree() -> void:
	queue_free()
