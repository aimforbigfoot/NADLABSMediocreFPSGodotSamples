extends "res://src/homeScreens/Base2DScene.gd"

func _ready() -> void:
	$ScrollContainer/VBoxContainer/fullscreenButton.connect("pressed",self,"fullscreenbutton")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func fullscreenbutton() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	OS.window_fullscreen = !OS.window_fullscreen
	pass
