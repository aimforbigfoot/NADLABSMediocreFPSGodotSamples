extends "res://src/enemy/baseEnemy/baseEnemy.gd"

var dirToMove := Vector3.LEFT


func _ready() -> void:
	connect("body_entered",self,"bodyEneted")


func bodyEneted(body) -> void:
	if body:
		dirToMove *= -1
	pass

func _process(delta: float) -> void:
#	if fowardRay.is_colliding() :
#		dirToMove *= Vector3.BACK
#	elif backwardRay.is_colliding():
#		dirToMove *= Vector3.FORWARD
	if !floorChecker.is_colliding():
		dirToMove *= -1
#
	global_transform.origin += dirToMove
#	if leftRay.is_colliding():
#		print("left all working")

func hurt() -> void:
	anim_player.play("hurt")
