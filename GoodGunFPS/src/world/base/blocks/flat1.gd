extends Spatial

func _ready() -> void:
	rotation.y = 0 if randf() < 0.5 else PI/2
