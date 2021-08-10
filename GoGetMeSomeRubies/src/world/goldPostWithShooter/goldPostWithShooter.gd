extends "res://src/world/grabPost/goldPost.gd"

var amtOfTime := 2

func _ready() -> void:
	$Timer.connect("timeout",self,"timeOut")
	amtOfTime = rand_range(2,5)
	$Timer.wait_time = amtOfTime
	$Tween.connect("tween_all_completed",self,"tween1Done")

func shootBullet() -> void:
	$rot/StaticBody/Particles.emitting = true
	$AudioStreamPlayer3D.play()
	var b :Spatial= preload("res://src/world/bulletbox/bullet.tscn").instance()
	b.dir = -( global_transform.origin - $rot/StaticBody/Position3D.global_transform.origin ).normalized()*2
	add_child(b)
	b.global_transform.origin = $rot/StaticBody/Position3D.global_transform.origin
func timeOut() -> void:
	shootBullet()
	$Tween.interpolate_property($rot/StaticBody/MeshInstance,"scale", Vector3(2,2,2), Vector3(3,2,3), amtOfTime-0.5, Tween.TRANS_ELASTIC,Tween.EASE_IN)
	$Tween.start()

func tween1Done() -> void:
	$Tween2.interpolate_property($rot/StaticBody/MeshInstance,"scale", Vector3(3,2,3), Vector3(2,2,2), 0.25, Tween.TRANS_CUBIC,Tween.EASE_IN)
	$Tween2.start()

func _physics_process(delta: float) -> void:
	$rot.rotation_degrees.y += 1
