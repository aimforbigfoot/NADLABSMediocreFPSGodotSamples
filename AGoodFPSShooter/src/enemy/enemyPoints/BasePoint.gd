extends Area

signal pointGone

var color 
var arrOfColors := ["red","orange","yellow","green","blue","purple"]
onready var mesh := $MeshInstance
onready var particles := $exploisonEffects
onready var explodeNoise := $explodeNoise
var explodeNoiseArr := [
	load("res://assets/sfx/jfxr/hurt2.wav"),
	load("res://assets/sfx/jfxr/hurt3.wav"),
	load("res://assets/sfx/jfxr/hurt4.wav"),
	load("res://assets/sfx/jfxr/hurt5.wav"),
	load("res://assets/sfx/jfxr/hurt6.wav"),
	load("res://assets/sfx/jfxr/hurt7.wav"),
	load("res://assets/sfx/jfxr/hurt8.wav"),
]

func _ready() -> void:
	randomize()
	explodeNoise.stream = explodeNoiseArr[ floor( explodeNoiseArr.size()*randf() )]
	arrOfColors.shuffle()
	color = arrOfColors[3]
	mesh.material_override = load("res://assets/materials/colorMaterials/"+color+".tres")
	particles.material_override = load("res://assets/materials/colorMaterials/"+color+".tres")
	particles.connect("finishedParticles",self,"onFinishedParticles")

func hit(areaColor) -> void:
	if areaColor == "red" and (color == "purple" or color == "orange" or color == "red" ):
		explode()
	elif  areaColor == "blue" and (color == "purple" or color == "green" or color == "blue" ):
		explode()
	elif  areaColor == "yellow" and (color == "yellow" or color == "green" or color == "orange" ):
		explode()
	else:
#		print("nope get rekt")
		var bullet : Area = preload("res://src/enemy/enemyPoints/bullet/enemyBullet.tscn").instance()
		Global.enemyFolder.add_child(bullet)
		var diff : Vector3 = ( Global.player.global_transform.origin - global_transform.origin  ).normalized()*5
		bullet.dir = diff
		bullet.global_transform.origin =  global_transform.origin+ diff*9


func explode() -> void:
	$CollisionShape.disabled = true
	emit_signal("pointGone")
	mesh.hide()
	particles.myStart()
	explodeNoise.play()

func onFinishedParticles() -> void:
	queue_free()
	pass
