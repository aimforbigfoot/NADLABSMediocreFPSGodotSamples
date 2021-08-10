extends Control


func _ready() -> void:
	if SettingsSaveScript.is_file_there():
		$HBoxContainer/musicToggle.pressed = SettingsSaveScript.get_val_safley(2)


func _on_CheckButton_toggled(button_pressed: bool) -> void:
	Global.musicAllowed = button_pressed
	if button_pressed:
		$HBoxContainer/Label.text = "Turn Off Music"
	else:
		$HBoxContainer/Label.text = "Turn On Music"
		
