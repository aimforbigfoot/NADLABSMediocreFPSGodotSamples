extends Node2D

var stringPressed := ""

func _ready() -> void:
	$ScrollContainer/VBoxContainer/play.connect("pressed",self,"play")
	$ScrollContainer/VBoxContainer/settings.connect("pressed",self,"settings")
	$ScrollContainer/VBoxContainer/about.connect("pressed",self,"about")
	$AnimationPlayer.connect("animation_finished",self,"backAnim")

func backAnim(_animName:String) -> void:
	print("got here")
	if _animName == "moveOut":
		print("got here as well")
		print(stringPressed)
		match stringPressed:
			"play":
				get_tree().change_scene("res://src/homeScreens/playScreen/PlayScreen.tscn")
				pass
			"settings":
				get_tree().change_scene("res://src/homeScreens/settingsScreen/SettingsScreen.tscn")
				pass
			"about":
				get_tree().change_scene("res://src/homeScreens/aboutScreen/AboutScene.tscn")
				print("got to about")
#	

func play() -> void:
	commonFunc("play")

func settings() -> void:
	commonFunc("settings")

func about() -> void:
	commonFunc("about")

func commonFunc(string:String) -> void:
	stringPressed = string
	$AnimationPlayer.play("moveOut")
