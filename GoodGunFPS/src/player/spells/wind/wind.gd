extends RigidBody
var lookAtStart := false

var lookAtTrue := false
var player : KinematicBody

func _ready() -> void:
	if lookAtStart :
		look_at(player.global_transform.origin, Vector3.UP)
	connect("body_entered",self,"bodyEntered")
	$wind.play()

func _physics_process(delta: float) -> void:
	if lookAtTrue:
		look_at(player.global_transform.origin, Vector3.UP)

func bodyEntered(body) -> void:
	if body.is_in_group("cube"): 
#		queue_free()
		pass


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "die":
		queue_free()
	if anim_name == "spawn" and lookAtStart :
		look_at(player.global_transform.origin, Vector3.UP)
		apply_central_impulse( (player.global_transform.origin - global_transform.origin).normalized() * 500  )
func _on_Timer_timeout() -> void:
	$AnimationPlayer.play("die")
	$wind.play()
