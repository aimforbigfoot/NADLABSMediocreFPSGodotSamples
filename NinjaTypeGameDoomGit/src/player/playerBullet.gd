extends Area

onready var bulletDespawnTimer := $bulletTimer
var dir : Vector3
var waitTime := 3
var player : KinematicBody

func _ready() -> void:
	bulletDespawnTimer.wait_time = waitTime

func _physics_process(_delta: float) -> void:
	global_transform.origin += dir
	look_at(player.global_transform.origin, Vector3.UP)

func _on_bulletTimer_timeout() -> void:
	queue_free()


func _on_playerBullet_area_entered(area: Area) -> void:
	if area.is_in_group("enemy"):
		print("hit enemy by a bullet")
		queue_free()
#		area.die()


func _on_playerBullet_body_entered(body: Node) -> void:
	if body:
		queue_free()
