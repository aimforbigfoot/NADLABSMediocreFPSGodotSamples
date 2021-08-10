extends Area

export var dirToPush := Vector3.UP

func _ready() -> void:
	connect("body_entered",self,"bodyEntered")
	var sm := SpatialMaterial.new()
	sm.flags_transparent = true
	global_transform.origin.y = rand_range(0,100)
	var r := randf() 
	var v := 0.1
#	if r < 0.16:
#		dirToPush = Vector3.LEFT
#		sm.albedo_color = Color(1,0,0,v)
#		$arrow.rotation_degrees.z = 90
#		$MeshInstance.material_override = sm
#	elif r < 0.32:
#		$arrow.rotation_degrees.z = -90
#		dirToPush = Vector3.RIGHT
#		sm.albedo_color = Color(0,0,1,v)
#		$MeshInstance.material_override = sm
#	elif r < 0.48:
#		dirToPush = Vector3.FORWARD
#		$arrow.rotation_degrees.x = -90
#		sm.albedo_color = Color(0,1,0,v)
#		$MeshInstance.material_override = sm
#	elif r < 0.64:
#		$arrow.rotation_degrees.x = 90
#		dirToPush = Vector3.BACK
#		sm.albedo_color = Color(1,1,0,v)
#		$MeshInstance.material_override = sm
#	elif r < 0.8:
#		dirToPush = Vector3.DOWN
#		sm.albedo_color = Color(1,1,1,v)
#		$arrow.rotation_degrees.x = 180
#		$MeshInstance.material_override = sm
#	else:
#		dirToPush = Vector3.UP*2
#		sm.albedo_color = Color(0,1,1,v)
#		global_transform.origin.y = 6
#		$MeshInstance.material_override = sm


	if r < 0.2:
		dirToPush = Vector3.LEFT
		sm.albedo_color = Color(1,0,0,v)
		$arrow.rotation_degrees.z = 90
		$MeshInstance.material_override = sm
		$dashCollidedPlayer.pitch_scale = 0.5
	elif r < 0.4:
		$arrow.rotation_degrees.z = -90
		dirToPush = Vector3.RIGHT
		sm.albedo_color = Color(0,0,1,v)
		$dashCollidedPlayer.pitch_scale = 0.75
		$MeshInstance.material_override = sm
	elif r < 0.6:
		dirToPush = Vector3.FORWARD
		$dashCollidedPlayer.pitch_scale = 1.0
		$arrow.rotation_degrees.x = -90
		sm.albedo_color = Color(0,1,0,v)
		$MeshInstance.material_override = sm
	elif r < 0.8:
		$arrow.rotation_degrees.x = 90
		$dashCollidedPlayer.pitch_scale = 1.25
		dirToPush = Vector3.BACK
		sm.albedo_color = Color(1,1,0,v)
		$MeshInstance.material_override = sm
	else:
		$dashCollidedPlayer.pitch_scale = 1.5
		dirToPush = Vector3.UP*2
		sm.albedo_color = Color(0,1,1,v)
		global_transform.origin.y = 6
		$MeshInstance.material_override = sm



func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		$dashCollidedPlayer.play()
		body.extraVel = dirToPush * 300
		body.ySpeed = 0
		body.dashNum = 0
		body.jumpNum = 0
		queue_free()



