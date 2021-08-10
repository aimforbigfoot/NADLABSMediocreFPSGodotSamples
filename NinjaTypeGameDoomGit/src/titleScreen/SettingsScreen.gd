extends Node2D

signal settingsBackPressed 
var settingsArr := []
var defaultSettings := [false, true,true,0.2, true]

func _ready() -> void:
	if SettingsSaveScript.is_file_there():
		settingsArr = SettingsSaveScript.load_settings()
	else:
		SettingsSaveScript.save_settings(defaultSettings)
	print(settingsArr)

func _on_BackFromSettingsButton_pressed() -> void:
	save()
	emit_signal("settingsBackPressed")


func _on_testButton_pressed() -> void:
	Global.playAnimStarting = "toSettings"
	save()
	Global.gameMode = "test"
	get_tree().change_scene("res://src/world/World.tscn")


func save() -> void:
	var tempSavingArr := []
	tempSavingArr.append( $Control/Control/ScrollContainer/VBoxContainer/FullScreenOption/VBoxContainer/fullScreenToggle.pressed  )
	tempSavingArr.append( $Control/Control/ScrollContainer/VBoxContainer/SoundSetting/HBoxContainer/soundSettingToggle.pressed )
	tempSavingArr.append( $Control/Control/ScrollContainer/VBoxContainer/MusicSetting/HBoxContainer/musicToggle.pressed )
	tempSavingArr.append( $Control/Control/ScrollContainer/VBoxContainer/MouseSensitivitySetting/HBoxContainer/mouseSensitivitySlider.value )
	tempSavingArr.append( $Control/Control/ScrollContainer/VBoxContainer/ScreenShakeSetting/HBoxContainer/allowScreenShakeToggle.pressed )
	print(tempSavingArr)
	SettingsSaveScript.save_settings(tempSavingArr)
