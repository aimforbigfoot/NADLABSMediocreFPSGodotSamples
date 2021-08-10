extends StaticBody


func _ready() -> void:
	var cylinder := CylinderMesh.new()
	var rad := rand_range(2,4)
	cylinder.radial_segments = 12
	cylinder.rings = 2
	cylinder.top_radius = rad
	cylinder.bottom_radius = rad
	var cylHegit := rand_range(2,16)
	cylinder.height = cylHegit
	$MeshInstance.mesh = cylinder
	var colCylinder := CylinderShape.new()
	colCylinder.radius = rad
	colCylinder.height = cylHegit
	$CollisionShape.shape = colCylinder
	global_transform.origin = Vector3( rand_range(-6,6), rand_range(0,2), rand_range(-6,6)  )
