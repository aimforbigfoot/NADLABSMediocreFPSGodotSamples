extends RigidBody


func _ready() -> void:
	connect("body_entered",self,"bodyEntered")
	$AnimationPlayer.connect("animation_finished",self,"af")

func af(an) -> void:
	if an:
		queue_free()

func bodyEntered(body) -> void:
	if body.is_in_group("cube"):
		$AnimationPlayer.play("lifeCycle")
