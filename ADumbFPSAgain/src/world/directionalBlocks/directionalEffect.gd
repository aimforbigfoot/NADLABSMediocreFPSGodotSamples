extends Area

export var dirToShift := Vector3.ZERO

func _on_directionalEffect_area_entered(area: Area) -> void:
	if area.is_in_group("enemy") and !area.is_in_group("wallavoid"):
		area.dir = dirToShift
		
