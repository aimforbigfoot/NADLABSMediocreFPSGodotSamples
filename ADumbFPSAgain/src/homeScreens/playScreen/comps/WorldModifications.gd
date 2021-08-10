extends "res://src/homeScreens/playScreen/comps/Carosuel.gd"

func _ready() -> void:
	arrOfChoices = [
		"No changes",
		"Platforms spawn",
		"Wall Spawn",
		"No lasers",
		"Quiet Corners",
	]
	secondaryArr = [
		"Just an empty cube",
		"You can jump on them",
		"Enemies bullets are stopped by walls",
		"Laser enemies will not be allowed to spawn",
		'A colored cube will spawn where no one will be allowed to fire a new bullet'
	]
	arrOfImages = [
		load("res://assets/imgs/gunImgs/nothing.png"),
		load("res://assets/imgs/worldModifications/platforms.png"),
		load("res://assets/imgs/worldModifications/wallsSpawn.png"),
		load("res://assets/imgs/worldModifications/nolasers.png"),
		load("res://assets/imgs/worldModifications/quietCorners.png"),
	]
	setFromLastRun(2)
	setText()
