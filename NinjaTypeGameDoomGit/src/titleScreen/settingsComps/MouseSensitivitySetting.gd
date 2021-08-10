extends Control

onready var label2 := $HBoxContainer/Label2
var mouseSens : float

func _ready() -> void:
	if SettingsSaveScript.is_file_there():
		mouseSens =  SettingsSaveScript.get_val_safley(3)
		$HBoxContainer/mouseSensitivitySlider.value = mouseSens
		Global.mouseSensitivty = mouseSens


func _on_HSlider_value_changed(value: float) -> void:
	label2.text = str(value)
	Global.mouseSensitivty = value
