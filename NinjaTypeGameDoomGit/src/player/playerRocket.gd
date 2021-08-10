extends Area

onready var bulletDespawnTimer := $bulletTimer
var dir : Vector3
var waitTime := 3
var player : KinematicBody
var arrOfAreas := []
var exploded := false 
func _ready() -> void:
	bulletDespawnTimer.wait_time = waitTime

func _physics_process(_delta: float) -> void:
	global_transform.origin += dir
	look_at(player.global_transform.origin, Vector3.UP)

func _on_bulletTimer_timeout() -> void:
	dir = Vector3.ZERO
	exploded = true
	explode()


func _on_playerRocket_area_entered(area: Area) -> void:
	if area.is_in_group("enemy") and area.has_method("die"):
		print("hit enemy by a bullet")
#		area.die()
		explode()
	elif area.is_in_group("enemy"):
		explode()

func explode() -> void:
	dir = Vector3.ZERO
	$MeshInstance.hide()
	$explosionRadius/Particles2.emitting = true
	$afterExplosion.start(1)
	$explosionRadius/CollisionShape2.disabled = false
	$afterExplosion.start()
		

func _on_explosionRadius_area_entered(area: Area) -> void:
	if area != self and area.has_method("die") and !area.is_in_group("rocketImmune"):
		area.die()
#	if area and area.has_method("die"):
#		area.die()
#		arrOfAreas.append(area)
#	for thing in arrOfAreas:
#		if thing and thing.has_method("die") and thing.is_in_group("enemy"):
#			thing.die()


func _on_afterExplosion_timeout() -> void:
	for thing in arrOfAreas:
		if thing and thing.has_method("die") and thing.is_in_group("enemy") and !thing.is_in_group("rocketImmune"):
			thing.die()
	queue_free()

func _on_playerRocket_body_entered(body: Node) -> void:
	if body:
		explode()
