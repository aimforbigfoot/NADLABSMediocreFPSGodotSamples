extends "res://src/enemy/enemyBase.gd"

onready var shootTimer := $shootTimer
onready var head := $meshFolder/head
onready var body := $meshFolder/body
onready var arms := $meshFolder/body/shoulder/arms
onready var legs := $meshFolder/legs
var lookAtAng : = 0.0

var headMeshes := [
	load("res://assets/enemies/robots/head/emptyHead.tres"),
	load("res://assets/enemies/robots/head/hammerHead.tres"),
	load("res://assets/enemies/robots/head/headRobotBase.tres"),
]
var bodyMeshes := [
	load("res://assets/enemies/robots/body/basicBody.tres"),
	load("res://assets/enemies/robots/body/circleBody.tres"),
	load("res://assets/enemies/robots/body/plumpBody.tres"),
	load("res://assets/enemies/robots/body/triangleBody.tres"),
]
var armsMeshes := [
	load("res://assets/enemies/robots/arms/ballHolderArms.tres"),
	load("res://assets/enemies/robots/arms/machineGunArms.tres"),
]
var legsMeshes := [
	load("res://assets/enemies/robots/legs/doomHunterSled.tres"),
	load("res://assets/enemies/robots/legs/legRobotBase.tres"),
	load("res://assets/enemies/robots/legs/skirtType.tres"),
]

func _ready() -> void:
#	OS.window_fullscreen = true
	shootTimer.connect("timeout",self,"fire_at_play")
	global_transform.origin = rand_spot_on_map()
	fire_at_play()
	head.mesh = headMeshes[ floor(headMeshes.size()*randf()) ]
	body.mesh = bodyMeshes[ floor(bodyMeshes.size()*randf()) ]
	arms.mesh = armsMeshes[ floor(armsMeshes.size()*randf()) ]
	legs.mesh = legsMeshes[ floor(legsMeshes.size()*randf()) ]


func fire_at_play() -> void:
	if not dead:
		shootTimer.start(rand_range(0,1)) 
		$shootAnims.play("shoot")
		var playerVec := Vector2(  Global.player.global_transform.origin.x,Global.player.global_transform.origin.z  )
		var myVec := Vector2(  global_transform.origin.x,global_transform.origin.z  )
		lookAtAng = -myVec.angle_to_point(playerVec)+(PI/2)
	#	print(lookAtAng)


func _physics_process(delta: float) -> void:
	rotation.y = lerp_angle( rotation.y, lookAtAng,0.1 )






