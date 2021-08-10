extends Node

var settingsPath := "user://settings.dat"
var file := File.new()


func save_settings(settingsArr : Array):
	file.open(settingsPath, File.WRITE)
	file.store_var(settingsArr)
	file.close()


func load_settings() -> Array:
	var temp_int = []
	file.open(settingsPath, File.READ)
	temp_int = file.get_var()
	file.close()
	return temp_int


func is_file_there() -> bool:
	var state : bool = false
	if file.file_exists(settingsPath):
		state = true
	return state

func get_val_safley( pos:int ):
	if is_file_there():
		return load_settings()[pos]
	return null
