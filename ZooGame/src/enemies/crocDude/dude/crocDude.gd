extends KinematicBody

var isPlayingNoises := false
var vel : Vector3 = Vector3.ZERO
var targetAng := 0.0

func _ready() -> void:
	$AnimationPlayer.connect("animation_finished",self,"af")

func af(an:String):
	if an:
		if randf() < 0.7:
			$AnimationPlayer.play("walking1")
		else:
			$AnimationPlayer.play("walking2")
		targetAng = rand_range(0,PI*2)

func _physics_process(delta: float) -> void:
	move_and_slide(vel, Vector3.UP)
	$meshFolder.rotation.y = lerp_angle( $meshFolder.rotation.y, targetAng, 0.05  )

func flee() -> void:
	isPlayingNoises = true
	if not isPlayingNoises:
		$meshFolder/fleePlayer.play()
	get_parent().getFleeVec()
	
	pass


func _on_fleePlayer_finished() -> void:
	isPlayingNoises = false
