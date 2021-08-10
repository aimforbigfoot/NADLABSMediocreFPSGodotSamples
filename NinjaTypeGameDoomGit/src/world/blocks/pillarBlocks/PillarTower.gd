extends "res://src/world/blocks/pillarBlocks/BasePillar.gd"

func _ready() -> void:
	if randf() < 0.5:
		$MiniWall.queue_free()
	if randf() < 0.5:
		$MiniWall2.queue_free()
	if randf() < 0.5:
		$MiniWall3.queue_free()
	if randf() < 0.5:
		$MiniWall4.queue_free()
		
