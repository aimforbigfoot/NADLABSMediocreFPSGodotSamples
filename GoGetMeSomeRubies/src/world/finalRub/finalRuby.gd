extends Spatial


func _ready() -> void:
	$ruby.connect("body_entered",self,"be")

func be(body) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene("res://src/world/done/done.tscn")
