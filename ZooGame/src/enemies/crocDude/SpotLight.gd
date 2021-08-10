extends SpotLight

var croc : KinematicBody

func _ready() -> void:
	croc = get_parent().get_node("crocDude")

func click() -> void:
	var dist :float=  croc.global_transform.origin.distance_squared_to($Position3D.global_transform.origin)
	print(dist)
	if dist < 100:
		croc.flee()

