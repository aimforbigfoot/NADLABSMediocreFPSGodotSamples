extends RigidBody


func _ready() -> void:
	$start.play()
	connect("body_entered",self,"bodyEntered")
	$Timer.connect("timeout",self,"time")
	$AnimationPlayer.connect("animation_finished",self,"af")

	$convertor.connect("body_entered",self,"bodyEnteredPeperes")
	$convertor.connect("body_exited",self,"bodyExitPeperes")

func bodyEnteredPeperes(body) -> void:
	if body.is_in_group("player"):
#		print("area got it")
		body.setCamToColor(Color(1,0,0,0.5),0)

func bodyExitPeperes(body) -> void:
	if body.is_in_group("player"):
		body.setCamToColor(Color(0,0,0,0.0),0)

func time() -> void:
	$AnimationPlayer.play("bie")
	$leave.play()

func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("enemy"):
		body.state = "hpGrab"
	if body.is_in_group("cube"):
		$Timer.start()
		linear_damp = 100

func af(an) -> void:
	if an:
		queue_free()
