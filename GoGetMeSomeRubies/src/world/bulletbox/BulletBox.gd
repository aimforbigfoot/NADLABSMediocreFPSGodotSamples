extends Spatial

var amtOfTime : float

func _ready() -> void:
	global_transform.origin.y = rand_range(50,1000)
	rotation_degrees.y = rand_range(0,360)
	amtOfTime = rand_range(2,4)
	$Timer.connect("timeout",self,"timeOut")
	$Timer.wait_time = amtOfTime
	$Timer.start()
	$Tween.connect("tween_all_completed",self,"tween1Done")

func timeOut() -> void:
	fireBullet()
	$Tween.interpolate_property($StaticBody/MeshInstance,"scale", Vector3(10,10,10), Vector3(12,10,12), amtOfTime-0.5, Tween.TRANS_ELASTIC,Tween.EASE_IN)
	$Tween.start()

func tween1Done() -> void:
	$Tween2.interpolate_property($StaticBody/MeshInstance,"scale", Vector3(12,10,12), Vector3(10,10,10), 0.5, Tween.TRANS_CUBIC,Tween.EASE_IN)
	$Tween2.start()

func fireBullet() -> void:
	$AudioStreamPlayer3D.play()
	$StaticBody/Particles.emitting = true
	var b :Spatial= preload("res://src/world/bulletbox/bullet.tscn").instance()
	b.dir = ( global_transform.origin - $StaticBody/Position3D.global_transform.origin ).normalized()*2
	add_child(b)
	b.global_transform.origin = $StaticBody/Position3D.global_transform.origin
