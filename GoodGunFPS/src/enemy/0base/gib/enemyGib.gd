extends RigidBody

var gibMesh : Mesh

func _ready() -> void:
	$fadeTimer.connect("timeout",self,"startFadeAnim")
	apply_central_impulse( Vector3( rand_range(-1,1) , rand_range(-1,1), rand_range(-1,1)).normalized() *rand_range(10,50))
#	$MeshInstance.mesh = gibMes

func startFadeAnim() -> void:
	$AnimationPlayer.play("fade")
	linear_damp = 10
	angular_damp = 10

func die() -> void:
	queue_free()
