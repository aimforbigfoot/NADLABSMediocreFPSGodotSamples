extends "res://src/world/grabPost/goldPost.gd"

var randSpinAmt := rand_range(0.01,0.1)

func _ready() -> void:
	$spike.connect("body_entered",self,"bodyEntered")

func bodyEntered( body ) -> void:
	if body.is_in_group("player"):
		get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	$spike.rotation.y += randSpinAmt
	pass
