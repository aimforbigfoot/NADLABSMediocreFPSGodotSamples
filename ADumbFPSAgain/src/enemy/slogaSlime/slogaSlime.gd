extends "res://src/enemy/enemyBase.gd"


func _ready() -> void:
	dir = Vector3(randf(),0,randf())


func _physics_process(delta: float) -> void:
	global_transform.origin += dir
	rotation.y = lerp_angle( rotation.y, angToLookTo, 0.1 )


