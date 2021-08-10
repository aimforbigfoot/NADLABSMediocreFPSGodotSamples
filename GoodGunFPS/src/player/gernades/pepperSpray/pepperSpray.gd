extends RigidBody


func _ready() -> void:
	connect("body_entered",self,"bodyEntered")
	$Timer.connect("timeout",self,"timeOut")
	$start.play()
	$pepperAreas.connect("body_entered",self,"bodyEnteredPeperes")
	$pepperAreas.connect("body_exited",self,"bodyExitPeperes")

func bodyEnteredPeperes(body) -> void:
	if body.is_in_group("player"):
#		print("area got it")
		body.setCamToColor(Color(1,0,0,0.5),0)

func bodyExitPeperes(body) -> void:
	if body.is_in_group("player"):
		body.setCamToColor(Color(0,0,0,0.0),0)

func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("cube") and not body.is_in_group("player"):
		linear_damp = 1000
		sleeping = true
		$CollisionShape.disabled = true
		$pepperAreas/MeshInstance.show()
		$pepperAreas/Particles.emitting = true
		$AnimationPlayer.play("start")
		$pepperAreas.show()
		$Timer.start()
		$leave.play()

func timeOut() -> void:
	queue_free()
