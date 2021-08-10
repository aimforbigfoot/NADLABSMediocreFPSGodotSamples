extends Node2D

signal settingsPressed 
signal playPressed

func _ready() -> void:
	randomize() 
	var randAnim := str( floor(rand_range(1,7)) )
	$Sprite.play( str(randAnim)  )
	pass

func _on_playButton_pressed() -> void:
#	get_tree().change_scene("res://src/world/World.tscn")
	emit_signal("playPressed")

func _on_settingsButton_pressed() -> void:
	emit_signal("settingsPressed")


func _on_Timer_timeout() -> void:
	if randf() < 0.1:
		var randAnim := str( floor(rand_range(1,7)) )
		$Sprite.play( str(randAnim)  )
	else:
		if randf() < 0.5:
			$Sprite.scale.x *= -1
		else:
			$Timer.wait_time = rand_range(0,1)
