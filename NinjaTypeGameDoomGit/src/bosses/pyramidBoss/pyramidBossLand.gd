extends "res://src/bosses/generalBossStuff/baseBossLand.gd"


func _ready() -> void:
	boss = $pyramidBoss


func _on_pyramidBoss_bossDie() -> void:
	$bossDiePlayer.play()
	pass # Replace with function body.
