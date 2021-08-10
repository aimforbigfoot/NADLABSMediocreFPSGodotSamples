extends Spatial

var num := 0.0

func _ready() -> void:
	$fowardPush.connect("body_entered",self,"push")
	$negativePush.connect("body_entered",self,"negativePush")

func negativePush(body) -> void:
	if body.is_in_group("player"):
		body.extraVel = -(  global_transform.origin-$fanMesh/Position3D.global_transform.origin ) *100
		body.fanEffect()


func push(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		body.extraVel = ( $fanMesh/Position3D.global_transform.origin - global_transform.origin ) * (10/( body.global_transform.origin - global_transform.origin ).length())*200
#		body.ySpeed = 0
		body.fanEffect()
#		body.dashNum = 0

func _physics_process(delta: float) -> void:
	num += 1
	$fanMesh.rotation.y = num
	if num > 7:
		num = 0 
