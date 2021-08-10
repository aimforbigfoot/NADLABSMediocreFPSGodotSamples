extends "res://src/enemy/enemyBase.gd"

var dirLerp := Vector3.ZERO
var colorsArr := [
	load("res://assets/colormaterials/blue.tres"),
	load("res://assets/colormaterials/green.tres"),
	load("res://assets/colormaterials/orange.tres"),
	load("res://assets/colormaterials/purple.tres"),
	load("res://assets/colormaterials/red.tres"),
	load("res://assets/colormaterials/yellow.tres"),
]

func _ready() -> void:
	$about3secTimer.connect("timeout",self,"moveToRandomPlace")
	global_transform.origin.y = 0.0
#	$MeshInstance.material_override = colorsArr[ floor( colorsArr.size() * randf() )  ]
	connect("died",self,"selfDied")

func selfDied() -> void:
	$about3secTimer.stop()

func moveToRandomPlace() -> void:
	var diff: Vector3 = ( Global.pointsAvaliable[ floor(randf()*Global.pointsAvaliable.size()) ].global_transform.origin - global_transform.origin ).normalized()*5
	diff.y = 0.0
	global_transform.origin.y = 0
	dirLerp = diff
	$about3secTimer.wait_time = rand_range(2,4)

func _physics_process(delta: float) -> void:
	dir = lerp(dir, dirLerp, 0.05)
	global_transform.origin += dir
