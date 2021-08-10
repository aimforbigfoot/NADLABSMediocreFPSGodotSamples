extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.connect("animation_finished",self,"backAnim")
	$ScrollContainer/VBoxContainer/backButton.connect("pressed",self,"back")
func back() -> void:
	$AnimationPlayer.play("moveOut")
func backAnim(animName:String) -> void:
	if animName == "moveOut":
		get_tree().change_scene("res://src/homeScreens/titleScreen/TitleScreen.tscn")
