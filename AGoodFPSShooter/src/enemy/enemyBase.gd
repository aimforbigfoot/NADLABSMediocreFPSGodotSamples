extends Area

signal enemyDied

onready var crosshair := $crossHair
onready var destructionNoisePlayer := $destructionNoisePlayer
onready var folderOfPoints := $folderOfPoints
onready var enemyParticles := $enemyParticles

var numOfPointsInFolder := 0
var color := "white"
var dead := false
var tileSize := 200
var canFly := false
var margin := 50
var lM := -tileSize+margin
var rM := tileSize-margin
var randStreamArr := [
	load("res://assets/sfx/jfxr/Explosion 17.wav"),
	load("res://assets/sfx/jfxr/Explosion 18.wav"),
	load("res://assets/sfx/jfxr/Explosion 19.wav"),
	load("res://assets/sfx/jfxr/Explosion 20.wav"),
	load("res://assets/sfx/jfxr/Explosion 21.wav"),
	load("res://assets/sfx/jfxr/Explosion 22.wav"),
	load("res://assets/sfx/jfxr/Explosion 25.wav"),
	load("res://assets/sfx/jfxr/Explosion 26.wav"),
	load("res://assets/sfx/jfxr/Explosion 27.wav"),
]


func _ready() -> void:
#	OS.window_fullscreen = true
	numOfPointsInFolder = folderOfPoints.get_child_count()
	connectAllBallsInFolder()
	enemyParticles.connect("finishedParticles",self,"enemyDie")
	destructionNoisePlayer.stream = randStreamArr[ floor( randf()*randStreamArr.size() )]

func rand_spot_on_map() -> Vector3:
	var ySpot := 0.0
	if canFly:
		ySpot = rand_range(50,250)
	return Vector3( rand_range(lM,rM),ySpot,rand_range(lM,rM))


func close_by_spot_on_map() -> Vector3:
	var randX :=  rand_range(lM,rM)
	var randZ :=  rand_range(lM,rM)
	
	if randX > rM or randX < lM:
		close_by_spot_on_map()
	
	if randZ > rM or randZ < lM:
		close_by_spot_on_map()
		
	var ySpot := 0.0
	if canFly:
		ySpot = rand_range(50,250)
	return Vector3(randX,ySpot,randZ)


func hit(colors) -> void:
#	this is when the enemy body has been hit
	pass

func amtOfPointsLeft() -> void:
	numOfPointsInFolder -= 1
	print(numOfPointsInFolder)
	if numOfPointsInFolder <= 0:
		enemyParticles.myStart()
		explode()
	print(numOfPointsInFolder, "here")

func explode() -> void:
	if not dead:
		dead = true
#		$meshFolder.hide()
		destructionNoisePlayer.play()
#		$folderOfPoints.hide()
#		$CollisionShape.disabled = true
		pass


func enemyDie() -> void:
#	pause_mode = Node.PAUSE_MODE_STOP
	emit_signal("enemyDied")
	pass
	


func connectAllBallsInFolder() -> void:
	for child in folderOfPoints.get_children():
		child.connect("pointGone",self,"amtOfPointsLeft")

