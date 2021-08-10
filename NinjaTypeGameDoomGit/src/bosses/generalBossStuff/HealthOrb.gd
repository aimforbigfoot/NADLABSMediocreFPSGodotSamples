extends Area

var disabled := false 
onready var particles := $Particles

func die() -> void:
	if not disabled:
		explode()
	pass


func _on_HealthOrb_area_entered(area: Area) -> void:
	if not disabled:
		shootAt(area)


func _on_HealthOrb_body_entered(body: Node) -> void:
	if not disabled:
		shootAt(body)


func shootAt(thing) -> void:
	if thing.is_in_group("bullet") or thing.is_in_group("shell"):
		explode()

func explode() -> void:
	particles.emitting = true 
	$AudioStreamPlayer3D.play()
	$CollisionShape.disabled = true
	$MeshInstance.hide()
	$Timer.start()

func _on_Timer_timeout() -> void:
	queue_free()
