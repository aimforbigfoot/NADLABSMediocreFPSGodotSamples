extends "res://src/enemy/baseEnemy/baseEnemy.gd"

var jumpAmt := 100
onready var jumpTimer := $jumpTimer
onready var upMostArrow := $upMostArrow


func _on_jumpTimer_timeout() -> void:
	if not dead:
		$groundCol/Particles2.emitting = true
		if upMostArrow.is_colliding():
			$Tween.interpolate_property(self,"translation",translation,translation+Vector3(0,upMostArrow.get_collision_point().y-10,0),jumpAmt/100,Tween.TRANS_CUBIC,Tween.EASE_OUT)
		else:
			$Tween.interpolate_property(self,"translation",translation,translation+Vector3(0,jumpAmt,0),jumpAmt/100,Tween.TRANS_CUBIC,Tween.EASE_OUT)
		jumpAmt = rand_range(50,200)
		$Tween.start()
		$afterJumpTimer.start()
		$jumpTimer.wait_time = rand_range(3,5)


func _on_afterJumpTimer_timeout() -> void:
	$Tween2.interpolate_property(self,"translation",translation,Vector3(translation.x,10,translation.z),1,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$Tween2.start()



func _on_groundCol_body_entered(body: Node) -> void:
	if body.is_in_group("player") and body.has_method("die") :
		body.die()


func hurt() -> void:
	anim_player.play("hurt")

func _on_Tween2_tween_completed(object: Object, key: NodePath) -> void:
	if object and key and not dead:
		$groundCol/Particles2.emitting = true
