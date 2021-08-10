extends StaticBody


func _ready() -> void:
	$Timer.connect("timeout",self,"fire")
	$booster.connect("body_entered",self,"bodyEntered")

func fire() -> void:
	pass

func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		yield(get_tree().create_timer(0.25), "timeout")
		body.extraVel = ( $Position3D.global_transform.origin - global_transform.origin ) * 200
		body.dashNum = 0
