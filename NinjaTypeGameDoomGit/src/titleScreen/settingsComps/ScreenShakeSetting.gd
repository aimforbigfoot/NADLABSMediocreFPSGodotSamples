extends Control

var screenShakeVal := true

func _ready() -> void:
	if SettingsSaveScript.is_file_there():
		screenShakeVal = SettingsSaveScript.get_val_safley(4)
		$HBoxContainer/allowScreenShakeToggle.pressed = screenShakeVal
		Global.canShake = screenShakeVal

