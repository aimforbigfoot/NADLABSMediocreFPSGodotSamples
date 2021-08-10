extends StaticBody


func _ready() -> void:
	randomize()
	global_transform.origin = Vector3(
		rand_range(-6,6),
		rand_range(0,2),
		rand_range(-6,6)
	)
	var r := randf()
	if r < 0.25:
		rotation_degrees.x = rand_range(-70,70)
	elif r < 0.5:
		rotation_degrees.y = rand_range(0,360)
	elif r < 0.75:
		rotation_degrees.z = rand_range(-70,70)
	else:
		pass
