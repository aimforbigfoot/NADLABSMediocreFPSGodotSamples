extends KinematicBody
var player : KinematicBody
var health := 100.0
var canTakeDamage := true
export var meRandPos := true
onready var mainAnimPlayer := $meshFolder/idleAndDeath
var gravity := -3
var speed := 40
var dir := Vector3.ZERO
var ySpeed := 0.0
var flyingEnemy := false
var dead := false

func _ready() -> void:
	randomize()
	if meRandPos:
		global_transform.origin = Vector3( rand_range(-95,95), rand_range(0,95), rand_range(-95,95) )
	$mainChecker.connect("body_entered",self,"bodyEntered")
	$mainChecker.connect("area_entered",self,"areaEntered")
	$everySecond.connect("timeout",self,"everySecond")
	mainAnimPlayer.connect("animation_finished",self,"af")
	player = get_parent().get_parent().get_node("ninjaPlayer")

func die() -> void:
	queue_free()
	pass

func rand1by1by1() -> Vector3:
	return (Vector3( rand_range(-1,1) , rand_range(-1,1), rand_range(-1,1)).normalized()  )

func explode() -> void:
	$deathParticles.scale = Vector3.ONE
	for i in 10:
		var gib :RigidBody= preload("res://src/enemy/0base/gib/enemyGib.tscn").instance()
		get_parent().add_child(gib)
		gib.gibMesh = load("res://assets/objs/enemies/effects/blueGib1.tres")
		gib.global_transform.origin = ( global_transform.origin + rand1by1by1()  )
	$deathParticles.emitting = true
	$meshFolder.hide()
	$CollisionShape.disabled = true
	$mainChecker.queue_free()
	$dieTimer.connect("timeout",self,"die")
	$dieTimer.start()
	$everySecond.stop()
	speed = 0
	dir = Vector3.ZERO

func hurt(amt : int )->void:
	if canTakeDamage:
		health -= amt
		if health <= 0.0 and not dead:
			explode()
			dead = true


func areaEntered(area:Area) -> void:
	print("yes")
	if area.is_in_group("playerBullet"):
		hurt(area.damageValue)
		dir = (area.global_transform.origin - global_transform.origin) * area.damageValue *2 * area.pushBackValue

func _physics_process(delta: float) -> void:
#	if not is_on_floor() and not flyingEnemy:
#		ySpeed += gravity
#	dir.y = ySpeed
	dir = move_and_slide(dir, Vector3.UP)
