extends StaticBody

onready var spawnPointsArr := []

func _ready() -> void:
	for child in $spawnPoints.get_children():
		spawnPointsArr.append(child)
