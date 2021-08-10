extends Spatial

func _ready() -> void:
	$AudioStreamPlayer3D.play()
	$AudioStreamPlayer3D.connect("finished",self,"done1")
	$AudioStreamPlayer3D2.connect("finished",self,"done2")

func done1() -> void:
	$AudioStreamPlayer3D2.play()

func done2() -> void:
	get_tree().quit()

func _on_Timer_timeout() -> void:
	$Sprite3D.show()
	$Sprite3D2.show()
	$Sprite3D3.show()
	$Sprite3D4.show()
