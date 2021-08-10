extends MeshInstance


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
func go() -> void:
	$OneSec.start()

	pass



func _on_OneSec_timeout() -> void:
	rotation_degrees.y = rand_range(-50,40)
	$OneSec.wait_time = rand_range(0.1,0.3)
	pass # Replace with function body.
