extends "res://src/enemy/0base/enemy.gd"

var angToLookAt := 0.0

func _ready() -> void:
	canTakeDamage = false 
	$meshFolder/weakPoint.connect("weakPointGone",self,"weakPointHit")
	$meshFolder/weakPoint2.connect("weakPointGone",self,"weakPointHit")
	$weakPoint3.connect("weakPointGone",self,"weakPointHit")
	$weakPoint4.connect("weakPointGone",self,"weakPointHit")


func _physics_process(delta: float) -> void:
	look_at( player.global_transform.origin, Vector3.UP )
#	rotation.y = lerp_angle( rotation.y, angToLookAt, 0.2 )
#	lerpToPlayerAng()


func weakPointHit(damageAmt:float) -> void:
	print("Ahhrg I got hit by " + str(damageAmt) + " points")
	canTakeDamage = true
	hurt(damageAmt)


func bodyEntered(body:PhysicsBody) -> void:
	pass


func areaEntered(area:Area) -> void:
	pass

func lerpToPlayerAng() -> void:
	var playerVec := Vector2( player.global_transform.origin.x , player.global_transform.origin.z )
	var meVec := Vector2( global_transform.origin.x , global_transform.origin.z )
	angToLookAt = -playerVec.angle_to_point(meVec)

func everySecond() -> void:
	pass
