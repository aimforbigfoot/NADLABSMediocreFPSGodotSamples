extends Spatial

var player : KinematicBody
var newZAng := 0.0
var toLookAt := Vector3.ZERO
onready var pos3d := $Position3D

func _ready() -> void:
	player = get_parent().get_parent().get_node("player")


func _physics_process(delta: float) -> void:
	look_at(player.global_transform.origin,Vector3.UP)
#	rotation.z = lerp_angle( rotation.z, newZAng, 0.05  )


func _on_oneSecondTimer_timeout() -> void:
	if not get_parent().dead:
		for i in floor(rand_range(1,10)):
			var bullet : Area = preload("res://src/enemy/baseEnemy/enemyBullet.tscn").instance()
			get_parent().get_parent().add_child(bullet)
			bullet.global_transform.origin = pos3d.global_transform.origin
			var randVec := Vector3.UP*3
			if randf() < 0.4:
				randVec = Vector3.DOWN*3
			elif randf() < 0.6:
				randVec = Vector3.LEFT*3
			else:
				randVec = Vector3.RIGHT*3
				
			bullet.dir = ((((player.global_transform.origin - pos3d.global_transform.origin)+randVec).normalized()))*10
		$oneSecondTimer.wait_time = rand_range(0,3)
		newZAng = rand_range(0, TAU)
		toLookAt = player.global_transform.origin
