extends Spatial

signal gotKey

var nextPos := Vector3.ZERO
var pitches := 1.0
var amt := 0.0
var playerCollected := true
var player : KinematicBody
func _ready() -> void:
	$Timer.connect("timeout",self,"timeOut")
	getNextPos()
	$Timer.start()
	$keyArea.connect("body_entered",self,"bodyEntered")

func bodyEntered(body) -> void:
	if body.is_in_group("player"):
		player = body
		if pitches < 2:
			pitches += 0.1
		else:
			pitches += 0.01
		emit_signal("gotKey")
		$keyArea/keyCollected.play()
		$keyArea/keyCollected.pitch_scale = pitches
		timeOut()
		$Timer.start()
		playerCollected = true
		amt = 0.0
		$AnimationPlayer.seek(0)

func timeOut() -> void:
	if not playerCollected:
		$keyArea/keyMoved.play()
	playerCollected = false
	amt = 0.0
	$keyArea.global_transform.origin = nextPos
	$keyArea/realKey.rotation_degrees = Vector3( rand_range(0,360) , rand_range(0,360), rand_range(0,360) )
	$fakeKey.rotation_degrees = Vector3( rand_range(0,360) , rand_range(0,360), rand_range(0,360) )
	getNextPos()
	$Timer.start()

func getNextPos() -> void:
	nextPos = Vector3( 
		rand_range(-100,100),
		rand_range(100,230),
		rand_range(-100,100)
	)
	$fakeKey.global_transform.origin = nextPos


#func _physics_process(delta: float) -> void:
#	var mat :SpatialMaterial= $keyArea/realKey.material_override
#	mat.emission_energy = amt
#	$keyArea/realKey.material_override = mat
##	mat.set_shader_param("amt",amt/6.0)
#	amt += delta
#	print(amt/6.0)
#	if player:
#		$fakeKey.look_at(player.transform.origin,Vector3.UP)
#		$keyArea.look_at(player.global_transform.origin,Vector3.UP)
#
