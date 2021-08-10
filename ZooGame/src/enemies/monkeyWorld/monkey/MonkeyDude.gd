extends Spatial

var spot := "center"
func _ready() -> void:
	$AnimationPlayer.playback_speed = rand_range(0.5,2)

func monkeyMoved() -> void:
	if randf() < 0.5:
		$meshFolder/body/head/leftEye.visible = !$meshFolder/body/head/leftEye.visible
	if randf() < 0.5:
		$meshFolder/body/head/rightEye.visible = !$meshFolder/body/head/rightEye.visible


func playAnim(anim_name:String) -> void:
	$AnimationPlayer.play(anim_name)

