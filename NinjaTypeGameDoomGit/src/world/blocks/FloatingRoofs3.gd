extends "res://src/world/blocks/BaseFloor.gd"



func _on_Timer_timeout() -> void:
	if randf() < 0.5:
		$WallRegular3.queue_free()
	if randf() < 0.5:
		$WallRegular2.queue_free()
	if randf() < 0.5:
		$WallRegular1.queue_free()

