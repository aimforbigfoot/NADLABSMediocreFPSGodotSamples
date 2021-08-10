extends Spatial

var headIsIn := false
var isUp := false

func moveHeadIn() -> void:
	$anim.play("moveinHead")
	$AudioStreamPlayer3D.play()
	headIsIn = true
	
func moveOutHead() -> void:
	$anim.play("moveOutHead")
	headIsIn = false

func moveDown() -> void:
	$anim.play("bodyDown")
	isUp = false

func moveUp() -> void:
	$anim.play("bodyUp")
	print("moved body up")
	$AudioStreamPlayer3D.play()
	isUp = true

func scare() -> void:
	if randf() < 0.5:
		if headIsIn:
			moveOutHead()
		else:
			moveHeadIn()
	else:
		if isUp:
			moveDown()
		else:
			moveUp()
