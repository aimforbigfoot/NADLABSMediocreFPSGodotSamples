extends Control

func _ready() -> void:
	if SettingsSaveScript.is_file_there():
		$HBoxContainer/soundSettingToggle.pressed = SettingsSaveScript.get_val_safley(1)


func _on_CheckButton_toggled(button_pressed: bool) -> void:
	Global.soundAllowed = button_pressed
	if button_pressed:
		$HBoxContainer/Label.text = "Turn Off Sound"
	else:
		$HBoxContainer/Label.text = "Turn On Sound"
