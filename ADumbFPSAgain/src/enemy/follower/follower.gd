extends "res://src/enemy/enemyBase.gd"

var offset := Vector3.ZERO

func _ready() -> void:
	var randX := rand_range(0,100) if randf() < 0.5 else rand_range(-100,-0) 
	var randY := rand_range(50,200) 
	var randZ := rand_range(0,100) if randf() < 0.5 else rand_range(-100,-0) 
	offset = Vector3(randX, randY, randZ )*3


func _physics_process(delta: float) -> void:
	global_transform.origin = lerp( global_transform.origin, Global.player.global_transform.origin + offset, 0.005  )
	look_at(Global.player.global_transform.origin, Vector3.UP)
