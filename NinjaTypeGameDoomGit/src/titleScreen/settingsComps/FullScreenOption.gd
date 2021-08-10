extends Control


func _ready() -> void:
	if SettingsSaveScript.is_file_there():
		$VBoxContainer/fullScreenToggle.pressed = SettingsSaveScript.get_val_safley(0)

func _on_CheckButton_toggled(button_pressed: bool) -> void:
	OS.window_fullscreen = button_pressed
