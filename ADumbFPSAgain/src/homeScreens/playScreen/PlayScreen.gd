extends "res://src/homeScreens/Base2DScene.gd"

func _ready() -> void:
	$ScrollContainer/VBoxContainer/playBtn.connect("pressed",self,"playBtn")
	$AnimationPlayer.connect("animation_finished",self,"change")

func playBtn() -> void:
	$AnimationPlayer.play("moveOut")

func change(animName:String) -> void:
	if animName =="moveOut":
		get_tree().change_scene("res://src/homeScreens/playScreen/RealGameScene.tscn")
