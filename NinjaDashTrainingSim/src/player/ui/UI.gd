extends Node2D


func dash() -> void:
	$AnimationPlayer.play("dash")
func dashDark() -> void:
	$AnimationPlayer.play("dashBack")

func numOfBarsToShow(num:int) -> void:
	match num:
		0:
			$Sprite.hide()
			$Sprite2.hide()
			$Sprite3.hide()
		1:
			$Sprite.show()
		2:
			$Sprite.show()
			$Sprite2.show()
		3:
			$Sprite.show()
			$Sprite2.show()
			$Sprite3.show()
			
			
func gotKey() -> void:
	$colorRectController.play("keyGot")
