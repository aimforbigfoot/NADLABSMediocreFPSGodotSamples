extends "res://src/bosses/generalBossStuff/baseBossLand.gd"


func _ready() -> void:
	boss = $CylinderBoss


func _on_CylinderBoss_hitGround() -> void:
	if Global.canShake:
		player.shakeCam()
