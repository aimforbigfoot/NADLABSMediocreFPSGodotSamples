extends "res://src/world/grabPost/goldPost.gd"


func _ready() -> void:
	$areaOfSpikes.connect("body_entered",self,"bodyEntered")

func bodyEntered(body) -> void:
	print("yes got body")
	if body.is_in_group("player"):
		print("yes got playert")
		get_tree().reload_current_scene()
		pass
