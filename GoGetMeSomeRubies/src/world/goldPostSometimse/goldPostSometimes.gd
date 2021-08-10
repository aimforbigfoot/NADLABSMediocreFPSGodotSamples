extends "res://src/world/grabPost/goldPost.gd"

var angToGoTo := 0.0

func _ready() -> void:
	angToGoTo = rand_range(0.05, 0.2)

func _physics_process(delta: float) -> void:
	rotation.y += angToGoTo
