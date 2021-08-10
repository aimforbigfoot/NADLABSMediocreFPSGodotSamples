extends "res://src/enemy/enemyBase.gd"

export var xyz := "y"
var got := false
var startingPos : Vector3

func _ready() -> void:
	isSpecialPlacement = true
	isShotgunner = true
	startingPos = global_transform.origin
	$twop5timer.connect("timeout",self,"pickNewDir")
	$p5timer.connect("timeout",self,"checkIfOffWall")
	meantToLookAtPlayer = false
	if randf() < 0.33:
		global_transform.origin = Global.xPointsWall[ floor( randf()* Global.xPointsWall.size()  )   ].global_transform.origin
		rotation_degrees.y = -90
		xyz = "x"
	elif randf() < 0.66:
		queue_free()
	else:
		global_transform.origin.y = rand_range(50, 400)
		global_transform.origin.x = rand_range(-Global.maxSize*2, Global.maxSize*2)
		queue_free()
		xyz = "y"
	connect("died",self,"selfDied")

func selfDied() -> void:
	$laserArea.queue_free()
	$twop5timer.stop()
	$p5timer.stop()
	startingPos = global_transform.origin
func pickNewDir() -> void:
	if xyz == "x":
		var xRand := rand_range(-10,10)
		var zRand := rand_range(-10,10)
		dir = Vector3( xRand, zRand,0  ).normalized()
	elif xyz == "z":
		var xRand := rand_range(-10,10)
		var zRand := rand_range(-10,10)
		dir = Vector3( 0,zRand,xRand  ).normalized()
	elif xyz == "y":
		var xRand := rand_range(-10,10)
		var zRand := rand_range(-10,10)
		dir = Vector3( zRand,0,xRand  ).normalized()
	print(dir)

func checkIfOffWall() -> void:
	var onFloor := true
	for ray in $floorsChecker.get_children():
		if !ray.is_colliding():
			onFloor = false
	if not onFloor:
		var cp := global_transform.origin # cp = currentpos
		dir = -(cp - startingPos).normalized()

func _physics_process(delta: float) -> void:
	global_transform.origin += dir
