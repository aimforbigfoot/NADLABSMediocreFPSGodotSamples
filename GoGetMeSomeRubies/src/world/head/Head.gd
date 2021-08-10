extends Spatial

var player : KinematicBody
var xAngToGoTo := 0.0

func _ready() -> void:
	$Timer.connect("timeout",self,"timeOut")
	$Timer.start()
	timeOut()
	player = get_parent().get_node("theSlayer")
#	print( get_parent().get_node("guideNoise").playing )
	get_parent().get_node("guideNoise").connect("finished",self,"doneTalking")
	if Global.arrOfLevelsBool[Global.rubiesCollected]:
		$Timer.stop()


func doneTalking() -> void:
	print("yes")
	$Timer.stop()
	xAngToGoTo = -30

func timeOut() -> void:
	print("timed out")
	if xAngToGoTo > 30:
		xAngToGoTo = rand_range(-40,-20)
	elif xAngToGoTo < 0: 
		xAngToGoTo = rand_range(30,70)
	else:
		xAngToGoTo = rand_range(-60,60)
	$Timer.start()

func _physics_process(delta: float) -> void:
	$Position3D.rotation_degrees.x = lerp ( $Position3D.rotation_degrees.x, xAngToGoTo, 0.05 )
	look_at(player.global_transform.origin, Vector3.UP)
