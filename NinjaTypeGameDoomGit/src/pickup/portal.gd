extends Area

var disabled := false 

func _ready() -> void:
	hide()
	get_random_pos()


func get_random_pos() -> void:
	var randX := rand_range(50,350)
	var randY := rand_range(20,70)
	var randZ := rand_range(50,350)
	global_transform.origin = Vector3(randX, randY, randZ)

func _on_portal_body_entered(body: Node) -> void:
	hide()
	if body.is_in_group("player"):
		body.die("good")
		print("yes I got player col")
	else:
		get_random_pos()
			


func _on_Timer_timeout() -> void:
	if visible == false:
		show()
		$finishLevel.play()
	else:
		$Timer.start()
