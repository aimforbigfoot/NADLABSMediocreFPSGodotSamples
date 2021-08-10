extends RigidBody

func _ready() -> void:
	randomize()
	var amt := 100
	var rx := rand_range(-amt,amt)
	var ry := rand_range(-amt,amt)
	var rz := rand_range(-amt,amt)
	angular_velocity = Vector3(rand_range(-10,10),rand_range(-10,10),rand_range(-10,10))
	var rand :Vector3= ((Global.player.global_transform.origin - get_parent().global_transform.origin + Vector3(rx,ry,rz) )).normalized()*10000
	apply_central_impulse(rand)
	$MeshInstance.mesh = load("res://assets/enemyObjs/gibs/gib"+str(floor(rand_range(1,2)))+".tres")
	$AudioStreamPlayer3D.stream = load("res://assets/ipadNoises/crunch"+ str(floor(rand_range(1,6))) +".wav")
	$AudioStreamPlayer3D.play()
	$Tween.interpolate_property(self,"scale",scale,Vector3.ZERO,5,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT,randf())
	$Tween.start()
	$Tween.connect("tween_all_completed",self,"done")

func done() -> void:
	queue_free()
	pass
