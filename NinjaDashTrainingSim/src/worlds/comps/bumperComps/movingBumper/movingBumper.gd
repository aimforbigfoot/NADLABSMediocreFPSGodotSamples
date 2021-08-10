extends "res://src/worlds/comps/bumperComps/baseBumper.gd"

var moveAmt := rand_range(20,100)

func _ready() -> void:
	$Tween.connect("tween_all_completed",self,"goBack")
	$Tween2.connect("tween_all_completed",self,"goFoward")
	$Timer.connect("timeout",self,"move")
#	goBack()

func goFoward() -> void:
	$Tween.interpolate_property(self,"global_transform:origin",global_transform.origin, global_transform.origin - dirToPush*moveAmt, 4,Tween.TRANS_BOUNCE, Tween.EASE_OUT_IN)
	$Tween.start()
	pass

func goBack() -> void:
	$Tween2.interpolate_property(self,"global_transform:origin",global_transform.origin, global_transform.origin + dirToPush*moveAmt, 4,Tween.TRANS_BOUNCE, Tween.EASE_OUT_IN)
	$Tween2.start()

func move() -> void:
	goFoward()
	$Timer.stop()
