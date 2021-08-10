extends "res://src/enemy/0base/enemy.gd"

var state := ""
var stateArr := ["stopped", "spinning", "swinging"]

func _ready() -> void:
	global_transform.origin = Vector3( rand_range(-95,95), 10, rand_range(-95,95) )
	$Tween.connect("tween_all_completed",self,"tweenFro")
	$Tween2.connect("tween_all_completed",self,"tweenFro")
	$damageArea.connect("area_entered",self,"damageAreaEntered")
	speed /= 2

func damageAreaEntered(area: Area) -> void:
	if area.is_in_group("playerBullet"):
		print("yes bulett ghurt me")

func bodyEntered(body:PhysicsBody) -> void:
	pass
func tweenTo() -> void:
	$Tween2.interpolate_property($sawBlade, "rotation_degrees:y", $sawBlade.rotation_degrees.y , $sawBlade.rotation_degrees.y + 90, 0.5,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$Tween2.start()
func tweenFro() -> void:
	$Tween.interpolate_property($sawBlade, "rotation_degrees:y", $sawBlade.rotation_degrees.y, $sawBlade.rotation_degrees.y - 90, 0.5,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$Tween.start()
	pass

func chooseState() -> void:
	state = stateArr[ floor( stateArr.size() * randf() ) ]

func everySecond() -> void:
	chooseState()
	match state:
		"stopped":
			$Tween.stop_all()
			$Tween2.stop_all()
			mainAnimPlayer.play("spinHead")
			dir = Vector3( rand_range(-1,1), 0, rand_range(-1,1) ).normalized() * speed 
			$CollisionShape.disabled = true 
			$everySecond.wait_time = 3
		"swinging":
			$CollisionShape.disabled = false
			mainAnimPlayer.play("closeLid")
			tweenTo()
			var newDir : Vector3 =  ( player.global_transform.origin - global_transform.origin ).normalized()
			newDir.y = 0
			dir = newDir
			$everySecond.wait_time = 1
		"spinning":
			mainAnimPlayer.play("closeLid")
			$CollisionShape.disabled = false
			$Tween.stop_all()
			$Tween2.stop_all()
			$everySecond.wait_time = 2
			var newDir : Vector3 =  ( player.global_transform.origin - global_transform.origin ).normalized()
			newDir.y = 0
			dir = newDir

func _physics_process(delta: float) -> void:
	if state == "spinning":
		$sawBlade.rotation.y += 0.2
		pass



func af(an) -> void:
	pass
