extends Spatial

var cross : Position3D
onready var shootTimer := $shootTimer
onready var shootNoisePlayer := $shootNoisePlayer
export var isAutoAimBot := false
var bulletSpeed := 2.0

var arrOfShootNoises := [
	load("res://assets/sfx/jfxr/Laser_shoot 3.wav"),
	load("res://assets/sfx/jfxr/Laser_shoot 4.wav"),
	load("res://assets/sfx/jfxr/Laser_shoot 8.wav"),
	load("res://assets/sfx/jfxr/Laser_shoot 10.wav"),
	load("res://assets/sfx/jfxr/Laser_shoot 11.wav"),
	load("res://assets/sfx/jfxr/Laser_shoot 12.wav"),
	load("res://assets/sfx/jfxr/Laser_shoot 13.wav"),
	load("res://assets/sfx/jfxr/Laser_shoot 14.wav"),
	load("res://assets/sfx/jfxr/Laser_shoot 16.wav"),
]



func _ready() -> void:
	shootNoisePlayer.stream = arrOfShootNoises[ floor( arrOfShootNoises.size()* randf()  ) ]
	shootTimer.connect("timeout",self,"shootBullet")
	shootTimer.wait_time = rand_range(1,3)
	shootBullet()


func shootBullet() -> void:
	if cross:
		bulletSpeed += 0.5
		shootNoisePlayer.play()
#		print("shot bullet")
		var diff :Vector3
		if isAutoAimBot:
			diff = (Global.player.global_transform.origin - global_transform.origin).normalized()*bulletSpeed
			look_at(Global.player.global_transform.origin,Vector3.RIGHT)
		else:
			diff = (Global.player.global_transform.origin - cross.global_transform.origin).normalized()*bulletSpeed
		var bullet :Area= preload("res://src/enemy/enemyPoints/bullet/enemyBullet.tscn").instance()
		Global.enemyFolder.add_child(bullet)
		bullet.global_transform.origin = global_transform.origin
		bullet.dir = diff
		shootTimer.start()
