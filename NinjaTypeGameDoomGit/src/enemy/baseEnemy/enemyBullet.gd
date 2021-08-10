extends Area

onready var bulletDespawnTimer := $bulletDespawnTimer
var dir : Vector3
var waitTime := 2

func _ready() -> void:
	bulletDespawnTimer.wait_time = waitTime

func _physics_process(_delta: float) -> void:
	global_transform.origin += dir


func _on_bulletDespawnTimer_timeout() -> void:
	queue_free()


func _on_enemyBullet_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
#		body.speed = 0.0
#		get_tree().reload_current_scene()
		
		body.die()
		print("player hit by a bullet")
		pass
	else:
		queue_free()


func _on_enemyBullet_area_entered(area: Area) -> void:
	if area.is_in_group("enemy"):
		area.die()
		

