extends Node2D

onready var animPlayer := $AnimationPlayer


func _ready() -> void:
	animPlayer.play(Global.playAnimStarting)
	print("title screen starting now")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_HomeScreen_settingsPressed() -> void:
	animPlayer.play("toSettings")


func _on_SettingsScreen_settingsBackPressed() -> void:
	animPlayer.play("toHome")
	pass # Replace with function body.


func _on_HomeScreen_playPressed() -> void:
	animPlayer.play("toDifficulty")

func goFromPowerupToGameSelect() -> void:
	animPlayer.play("powerupToGame")
	pass


func go_back_from_start() -> void:
	animPlayer.play("difficultyToHome")

func from_gameScreen_to_powerup() -> void:
	animPlayer.play("gameToPowerup")
