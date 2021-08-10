extends Spatial

var isClimbing := false

func _ready() -> void:
	$AnimationPlayer.connect("animation_finished",self,"af")
	$checkingTimer.connect("timeout",self,"checkIfPlayerNearBy")
	GlobalSettings.safeLight.connect("toggleLight",self,"randChangeToGoAway")

func randChangeToGoAway(isOnBool:bool) -> void:
	if not isOnBool:
		$AnimationPlayer.stop()
		$reverseText.stop()
		global_transform.origin = Vector3.ZERO
		pass
	pass


func af(an) -> void:
	$AnimationPlayer.play("crawl")
	global_transform.origin.y += rand_range(0.01,0.1)


func startClimbing() -> void:
	$AnimationPlayer.play("crawl")
	$checkingTimer.start()
	$reverseText.pitch_scale = rand_range(0.3,0.5)
	$reverseText.play(0.0)
func stopClimbing() -> void:
	$checkingTimer.stop()
	$reverseText.stop()



func jumpscare() -> void:
	print("you just got jumpscared")
	pass

func checkIfPlayerNearBy() -> void:
	var dist : float = GlobalSettings.player.global_transform.origin.distance_squared_to(global_transform.origin)
	if dist < rand_range(25,30):
		jumpscare()


func _on_reverseText_finished() -> void:
	jumpscare()
