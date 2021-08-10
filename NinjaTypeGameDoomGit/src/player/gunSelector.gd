extends Control

var myPaused := false
func _ready() -> void:
	hide()
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("rClick") and not myPaused and not get_tree().paused :
		myPaused = true
		get_tree().paused = true 
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		show()
	elif Input.is_action_just_pressed("rClick") and myPaused and get_tree().paused:
		myPaused = false
		hide()
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				

func doTheUnPause() -> void:
	myPaused = false
	hide()
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
