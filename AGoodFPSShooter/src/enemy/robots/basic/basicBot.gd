extends "res://src/enemy/robots/robotBase.gd"


func _ready() -> void:
	$meshFolder/body/shoulder/arms/EnemyShooter.cross = $crossHair
	$meshFolder/body/shoulder/arms/EnemyShooter2.cross = $crossHair
