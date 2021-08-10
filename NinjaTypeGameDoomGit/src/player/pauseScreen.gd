extends Control
var paused := false
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused == paused:
			paused = !paused
			if paused and not get_tree().paused:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				show()
				get_tree().paused = true 
			elif not paused and get_tree().paused:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				hide()
				get_tree().paused = false
		print(paused, " ", get_tree().paused)
	if Input.is_action_pressed("q") and paused:
		get_tree().paused = false
		get_tree().change_scene("res://src/titleScreen/TitleScreen.tscn")
