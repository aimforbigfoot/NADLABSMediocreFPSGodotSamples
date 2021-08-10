extends Spatial

onready var gN := $guideNoise
var extendedRange := false
var tryAgain := [ 
	load("res://assets/voiceLines/keepTrying.wav"),
	load("res://assets/voiceLines/tryAgain.wav"),
	load("res://assets/voiceLines/yourluckyTryAgain.wav")
 ]

func getTryAgainNoise():
	return tryAgain[ floor( tryAgain.size() * randf() ) ]

func speak(num:int):
	if not Global.arrOfLevelsBool[num]:
		gN.stream = load("res://assets/voiceLines/"+str(num+1)+"Level.wav")
		gN.play()
	elif Global.chanceOfErrorNoise > randf():
		print("getting try again noise")
		gN.stream = getTryAgainNoise()
		gN.play()
	Global.arrOfLevelsBool[num] = true
	Global.chanceOfErrorNoise += 0.02
	print(Global.chanceOfErrorNoise)

func doneNoise() -> void:
	print("done noise")
	gN.stop()

func _ready() -> void:
#	Global.rubiesCollected = 11
#	spawnRegular()
#	spawnDark()
#	spawnWithSomeSomeimtes()
#	spawnWithLasers()
#	spawnWithBulletBoxes()
#	spawnWithMovingOnes(0.9)
#	spawnFans()
	gN.connect("finished",self,"doneNoise")
	var de : Environment = load("res://default_env.tres")
	de.fog_enabled = false
	de.ambient_light_energy = 1.0
	if Global.rubiesCollected < 11:
		speak(Global.rubiesCollected)
	match Global.rubiesCollected:
		0:
			spawnRegular()
		1:
			spawnRegular()
			spawnDark()
		2:
			spawnRegular()
			spawnWithBulletBoxes(15)
		3:
			spawnWithSomeSomeimtes()
		4:
			spawnWithBulletBoxes(15)
			spawnWithLasers(15)
			spawnWithSomeSomeimtes()
			spawnRegular(20)
		5:
			spawnFans(10)
			spawnWithLasers(15)
			spawnWithMovingOnes(0.5)
		6:
			spawnDark()
			spawnRegular()
			spawnWithBulletBoxes(30)
		7:
#			spawnDark()
			spawnFans(10)
			spawnWithMovingOnes(0.6)
			spawnWithLasers(30)
		8:
			spawnSpikes(30)
		9:
			spawnLongSpikes(50)
		10:
			spawnWithBulletBoxes(15)
			spawnWithLasers(15)
			spawnRegular()
			spawnShooterPosts(20)
			spawnDark()
		11:
			get_tree().change_scene("res://src/world/theRealTest/realTest.tscn")

			

	
func spawnRegular(num:int = 30) -> void:
	for i in num:
		var gp := preload("res://src/world/grabPost/goldPost.tscn").instance()
		gp.extendedRange = true
		$worldStuff.add_child(gp)
func spawnSpikes(num:int = 30) -> void:
	for i in num:
		var gp := preload("res://src/world/spikePost/spikePost.tscn").instance()
		gp.extendedRange = true
		$worldStuff.add_child(gp)
func spawnLongSpikes(num:int = 30) -> void:
	for i in num:
		var gp := preload("res://src/world/spinningSpikePost/spinningSpikePost.tscn").instance()
		gp.extendedRange = true
		$worldStuff.add_child(gp)
func spawnShooterPosts(num:int = 30) -> void:
	for i in num:
		var gp := preload("res://src/world/goldPostWithShooter/goldPostWithShooter.tscn").instance()
		gp.extendedRange = true
		$worldStuff.add_child(gp)
func spawnWithSomeSomeimtes() -> void:
	for i in 30:
		if randf( ) < 0.1:
			var gp := preload("res://src/world/grabPost/goldPost.tscn").instance()
			gp.extendedRange = true
			$worldStuff.add_child(gp)
		else:
			var gp := preload("res://src/world/goldPostSometimse/goldPostSometimes.tscn").instance()
			gp.extendedRange = true
			$worldStuff.add_child(gp)
func spawnWithLasers(num:int = 30) -> void:
	for i in num:
		var laser := preload("res://src/world/laserBox/LaserBox.tscn").instance()
		$worldStuff.add_child(laser)
func spawnWithBulletBoxes(num:int = 30) -> void:
	for i in num:
		var bullet := preload("res://src/world/bulletbox/BulletBox.tscn").instance()
		$worldStuff.add_child(bullet)

func spawnFans(num:int = 10) -> void:
	for i in num:
		var fan := preload( "res://src/world/fans/fans.tscn" ).instance()
		$worldStuff.add_child(fan)

func spawnWithMovingOnes(amt:float) -> void:
	for i in 30:
		if randf() < amt:
			var gp := preload("res://src/world/grabPostMoving/movingPost.tscn").instance()
			gp.extendedRange = true
			$worldStuff.add_child(gp)

		else:
			var gp := preload("res://src/world/grabPost/goldPost.tscn").instance()
			gp.extendedRange = true
			$worldStuff.add_child(gp)

func spawnDark() -> void:
	var de : Environment = load("res://default_env.tres")
	de.fog_enabled = true
	de.ambient_light_energy = 0.15
	de.fog_height_max = 1500
