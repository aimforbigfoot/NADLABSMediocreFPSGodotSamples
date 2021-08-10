extends Spatial

var player : KinematicBody
var talking := false 
var handRot := 0.0
var mouthRot := 0.0

func _ready() -> void:
	player = get_parent().get_node("theSlayer")
	playSound()
	$Timer.connect("timeout",self,"newPoss")


func playSound() -> void:
	pass

func _physics_process(delta: float) -> void:
	look_at(player.global_transform.origin, Vector3.UP)
	if talking:
		$AnimationPlayer.stop()
		$mouth.rotation.x = lerp_angle($mouth.rotation.x, mouthRot, 0.1)
		$hands.rotation.x = lerp_angle($hands.rotation.x, handRot, 0.1)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_page_down"):
		$AnimationPlayer.play("talking")
	
func newPoss() -> void:
	print('aappened')
	handRot = rand_range(-10000, 150)
	mouthRot = rand_range(-150, 150)
	
