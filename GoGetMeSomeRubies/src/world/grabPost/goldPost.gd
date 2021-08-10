extends Spatial

var extendedRange := false 
export var randPos := true

func _ready() -> void:
	if randPos:
		randomize()
		if extendedRange:
			global_transform.origin = Vector3( 
				rand_range(-75,75),
				rand_range(20,1000),
				rand_range(-75,75) )
		else:
			global_transform.origin = Vector3( 
			rand_range(-75,75),
			rand_range(20,3800),
			rand_range(-75,75) )
		var r := randf()
		if r < 0.25:
			rotation.x = rand_range(0,2*PI)
			pass
		elif r < 0.5:
			rotation.z = rand_range(0,2*PI)
		elif r < 0.75:
			rotation.y = rand_range(0,2*PI)
	

