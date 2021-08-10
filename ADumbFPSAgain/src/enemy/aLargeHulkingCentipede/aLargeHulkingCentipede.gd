extends "res://src/enemy/enemyBase.gd"

var radius : float
var dirAgain := Vector3.ZERO
var rx : float
var ry : float
var rz : float


func _ready() -> void:
	rx = randf()
	ry = randf()
	rz = randf()
	radius = rand_range(50,100)
	isFlying = true
	connect("body_entered",self,"bodyEntered")

func bodyEntered(body) -> void:
	if body:
		global_transform.origin = Vector3(rand_range(-Global.maxSize,Global.maxSize), 0,rand_range(-Global.maxSize,Global.maxSize) )
		$reAppearParticles.emitting = true

func _physics_process(delta: float) -> void:
	global_transform.origin = ( global_transform.origin + Vector3(rx,ry,rz  ))
	look_at(Global.player.global_transform.origin, Vector3.UP)
	
