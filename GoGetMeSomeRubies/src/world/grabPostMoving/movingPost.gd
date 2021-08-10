extends "res://src/world/grabPost/goldPost.gd"

var ammt :  Vector3
func _ready() -> void:
	ammt = Vector3(
		rand_range(-50,50),
		rand_range(-50,50),
		rand_range(-50,50)
	)
	$Tween.connect("tween_all_completed",self,"moveBack")
	$Tween2.connect("tween_all_completed",self,"moveFoward")
	moveBack()

func moveBack() -> void:
	$Tween2.interpolate_property(self,"global_transform:origin",global_transform.origin, global_transform.origin + ammt, 2,Tween.TRANS_CIRC,Tween.EASE_IN_OUT)
	$Tween2.start()

func moveFoward() -> void:
	$Tween.interpolate_property(self,"global_transform:origin",global_transform.origin, global_transform.origin - ammt, 2,Tween.TRANS_CIRC,Tween.EASE_IN_OUT)
	$Tween.start()
