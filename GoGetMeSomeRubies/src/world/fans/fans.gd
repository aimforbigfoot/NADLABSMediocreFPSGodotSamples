extends Spatial

var randAng := 0.0

func _ready() -> void:
	randomize()
	$Spatial/Timer.connect("timeout",self,"newRandAng")
	global_transform.origin.y = rand_range(100,1000)
#	if randf() < 0.5:
	rotation_degrees.y = rand_range(0,360)
#	else:
#		rotation_degrees.z = rand_range(0,360)
	$Spatial/Area.connect("body_entered",self,"bodyEnterFan")
	$Spatial/fanArea.connect("body_entered",self,"bodyEnteredTheFanItself")
	
	
#	look_at( Vector3( 0, global_transform.origin.y, 0 ), Vector3.UP )
func bodyEnteredTheFanItself(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
func bodyEnterFan(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		body.extraVel = -( body.global_transform.origin - global_transform.origin ).normalized() * 500
		body.ySpeed = 0
		body.jumpNum = 0


func newRandAng() -> void:
	randAng = rand_range(0, 2*PI)
	$Spatial/Timer.wait_time = rand_range(0.05,0.15)

func _physics_process(delta: float) -> void:
	$Spatial/MeshInstance.rotation.x = lerp( $Spatial/MeshInstance.rotation.x ,randAng, randf()/2  )
	
