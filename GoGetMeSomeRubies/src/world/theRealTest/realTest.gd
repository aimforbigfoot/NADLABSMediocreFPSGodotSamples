extends Spatial

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
		$WorldBase/guideNoise.stream = load("res://assets/voiceLines/"+str(num+1)+"Level.wav")
		$WorldBase/guideNoise.play()
	elif Global.chanceOfErrorNoise > randf():
		print("getting try again noise")
		$WorldBase/guideNoise.stream = getTryAgainNoise()
		$WorldBase/guideNoise.play()
	Global.arrOfLevelsBool[num] = true
	Global.chanceOfErrorNoise += 0.02
	print(Global.chanceOfErrorNoise)

func _ready() -> void:
#	spawnRegular()
#	spawnDark()
#	spawnWithSomeSomeimtes()
#	spawnWithLasers()
#	spawnWithBulletBoxes()
#	spawnWithMovingOnes(0.9)
#	spawnFans()
	var de : Environment = load("res://default_env.tres")
	de.fog_enabled = false
	de.ambient_light_energy = 1.0
	extendedRange = true
	Global.rubiesCollected = 11
	speak(Global.rubiesCollected)
	spawnDark()
	spawnRegular(30)
	spawnSpikes()
	spawnWithSomeSomeimtes()
	spawnWithLasers()
	spawnWithBulletBoxes()
	spawnWithMovingOnes(0.9)
	spawnFans()
	spawnLongSpikes(50)

	
func spawnRegular(num:int = 30) -> void:
	for i in num:
		var gp := preload("res://src/world/grabPost/goldPost.tscn").instance()
		gp.extendedRange = true
		$worldStuff.add_child(gp)
		gp.global_transform.origin = Vector3( rand_range(-75,75),rand_range(20,3800),rand_range(-75,75) )
func spawnSpikes(num:int = 30) -> void:
	for i in num:
		var gp := preload("res://src/world/spikePost/spikePost.tscn").instance()
		gp.extendedRange = true
		$worldStuff.add_child(gp)
		gp.global_transform.origin = Vector3( rand_range(-75,75),rand_range(20,3800),rand_range(-75,75) )
func spawnLongSpikes(num:int = 30) -> void:
	for i in num:
		var gp := preload("res://src/world/spinningSpikePost/spinningSpikePost.tscn").instance()
		gp.extendedRange = true
		$worldStuff.add_child(gp)
		gp.global_transform.origin = Vector3( rand_range(-75,75),rand_range(20,3800),rand_range(-75,75) )
func spawnShooterPosts(num:int = 30) -> void:
	for i in num:
		var gp := preload("res://src/world/goldPostWithShooter/goldPostWithShooter.tscn").instance()
		gp.extendedRange = true
		$worldStuff.add_child(gp)
		gp.global_transform.origin = Vector3( rand_range(-75,75),rand_range(20,3800),rand_range(-75,75) )
func spawnWithSomeSomeimtes() -> void:
	for i in 30:
		if randf( ) < 0.5:
			var gp := preload("res://src/world/grabPost/goldPost.tscn").instance()
			gp.extendedRange = true
			$worldStuff.add_child(gp)
			gp.global_transform.origin = Vector3( rand_range(-75,75),rand_range(20,3800),rand_range(-75,75) )
		else:
			var gp := preload("res://src/world/goldPostSometimse/goldPostSometimes.tscn").instance()
			gp.extendedRange = true
			$worldStuff.add_child(gp)
			gp.global_transform.origin = Vector3( rand_range(-75,75),rand_range(20,3800),rand_range(-75,75) )
func spawnWithLasers(num:int = 30) -> void:
	for i in num:
		var laser := preload("res://src/world/laserBox/LaserBox.tscn").instance()
		$worldStuff.add_child(laser)
		laser.global_transform.origin.y = rand_range(20,3800)
func spawnWithBulletBoxes(num:int = 30) -> void:
	for i in num:
		var bullet := preload("res://src/world/bulletbox/BulletBox.tscn").instance()
		$worldStuff.add_child(bullet)
		bullet.global_transform.origin.y = rand_range(20,3800)

func spawnFans(num:int = 10) -> void:
	for i in num:
		var fan := preload( "res://src/world/fans/fans.tscn" ).instance()
		$worldStuff.add_child(fan)
		fan.global_transform.origin.y = rand_range(20,3800)

func spawnWithMovingOnes(amt:float) -> void:
	for i in 30:
		if randf() < amt:
			var gp := preload("res://src/world/grabPostMoving/movingPost.tscn").instance()
			gp.extendedRange = true
			$worldStuff.add_child(gp)
			gp.global_transform.origin = Vector3( rand_range(-75,75),rand_range(20,3800),rand_range(-75,75) )

		else:
			var gp := preload("res://src/world/grabPost/goldPost.tscn").instance()
			gp.extendedRange = true
			$worldStuff.add_child(gp)
			gp.global_transform.origin = Vector3( rand_range(-75,75),rand_range(20,3800),rand_range(-75,75) )

func spawnDark() -> void:
	var de : Environment = load("res://default_env.tres")
	de.fog_enabled = true
	de.ambient_light_energy = 0.15
	de.fog_height_max = 8000
	pass
