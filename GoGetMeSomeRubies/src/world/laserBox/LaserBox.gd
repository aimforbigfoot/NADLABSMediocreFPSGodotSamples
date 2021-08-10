extends Spatial

var canHurtPlayer := false

func _ready() -> void:
	global_transform.origin.y = rand_range(50,1000)
	rotation_degrees.y = rand_range(0,360)
	$AnimationPlayer.play("shoot")
	$AnimationPlayer.connect("animation_finished",self,"af")
	$laserArea.connect("body_entered",self,"bodyEntered")
	$laserArea.hide()

func bodyEntered(body) -> void:
	if body.is_in_group("player") and canHurtPlayer:
		get_tree().reload_current_scene()


func af(an) -> void:
	if an == "shoot":
		$AnimationPlayer.play("fire")
		$laserArea.show()
		$AudioStreamPlayer3D.play()
		canHurtPlayer = true 
	if an == "fire":
		$AnimationPlayer.play("shoot")
		$laserArea.hide()
		canHurtPlayer = false
