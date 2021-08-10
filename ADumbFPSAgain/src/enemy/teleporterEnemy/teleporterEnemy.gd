extends "res://src/enemy/enemyBase.gd"


func _ready() -> void:
	isFlying = true
	$threeSecMoveTimer.connect("timeout",self,"moveAround")
	connect("firedBullet",self,"firedABullet")
#	moveAround()
	connect("died",self,"selfDied")

func selfDied() -> void:
	$threeSecMoveTimer.stop()
	$Tween.stop_all()
	$AnimationPlayer.stop()


func firedABullet() -> void:
	$firePartilc.emitting = true
	pass


func _physics_process(delta: float) -> void:
	look_at(Global.player.global_transform.origin, Vector3.UP)


func moveAround() -> void:
	var finalPos : Vector3 = Global.pointsAvaliable[ floor(Global.pointsAvaliable.size()*randf())  ].global_transform.origin
	finalPos.y = rand_range(50,400)
	$threeSecMoveTimer.wait_time = rand_range(2,5)
	$Tween.interpolate_property(self,"global_transform:origin",global_transform.origin,  finalPos, 2,Tween.TRANS_QUAD,Tween.EASE_IN_OUT,0)
	$Tween.start()
