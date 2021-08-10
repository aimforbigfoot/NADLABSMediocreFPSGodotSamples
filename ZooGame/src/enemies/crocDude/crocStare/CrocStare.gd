extends Spatial

func go() -> void:
	$body/head.go()
	$AnimationPlayer.play("in")
	$body/head/backwards.play()

func stop() -> void:
	$body/head/backwards.stop()
	$AnimationPlayer.stop()
	$body/head/OneSec.stop()
	$body.global_transform.origin = Vector3(5,14,-7)

	

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	stop()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("t"):
		go()

func _ready() -> void:
	GlobalSettings.safeLight.connect("toggleLight",self,"randChangeToGoAway")

func randChangeToGoAway(isOnBool:bool) -> void:
	if not isOnBool:
		stop()
		pass
	pass
