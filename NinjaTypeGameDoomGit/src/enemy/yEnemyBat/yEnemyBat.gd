extends "res://src/enemy/baseEnemy/baseEnemy.gd"

func _physics_process(delta: float) -> void:
	randYAmtToMove = lerp(randYAmtToMove, 0,0.01)
	global_transform.origin.y += randYAmtToMove/10
	if randYAmtToMove <= 3:
		canMove = false
	if floorChecker.is_colliding():
		randYAmtToMove = 10
#	if canMove:
