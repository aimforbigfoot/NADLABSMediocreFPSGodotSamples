extends "res://src/enemy/enemyBase.gd"

onready var startJumpTween := $startJumpTween
onready var finishJumpTween := $finishJumpTween

var jumpingTo := Vector3.ZERO
var difficulty := 5

func _on_startJump_timeout() -> void:
	jumpingTo = close_by_spot_on_map()
#	print(jumpingTo)
	makeAJump()


func makeAJump() -> void:
	if not dead:
		var jumpMid := jumpingTo
		jumpMid.y = rand_range(100,250)
		jumpMid.z = jumpMid.z/2
		jumpMid.x = jumpMid.x/2
		
		startJumpTween.interpolate_property(self,"global_transform:origin",global_transform.origin,jumpMid,2,Tween.TRANS_EXPO,Tween.EASE_OUT)
		startJumpTween.start()
		pass


func _on_startJumpTween_tween_all_completed() -> void:
#	jumpingDown
	finishJumpTween.interpolate_property(self,"global_transform:origin",global_transform.origin,jumpingTo,0.5,Tween.TRANS_QUART,Tween.EASE_IN)
	finishJumpTween.start()
