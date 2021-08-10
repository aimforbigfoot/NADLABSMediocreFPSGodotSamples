extends "res://src/enemy/baseEnemy/baseEnemy.gd"

func _ready() -> void:
	global_transform.origin.y = rand_range(30,50)
	pass


func _physics_process(delta: float) -> void:
	randYAmtToMove = lerp(randYAmtToMove, 0,0.01)
	if randf() < 0.5:
		transform.origin.x += randYAmtToMove/10
	else:
		transform.origin.z += randYAmtToMove/10
	if randYAmtToMove <= 3:
		canMove = false
	if floorChecker.is_colliding():
		randYAmtToMove = 10
#	if canMove:
