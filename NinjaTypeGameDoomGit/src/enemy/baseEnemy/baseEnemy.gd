extends Area

signal enemyDied

export var enemyType := ""
var bulletSpeed := 2
var canShoot = true
var health := 40.0
var maxHealth := 40.0
var dead := false
var notFixedBulletTime := true
var player : KinematicBody
onready var rayFolder := $rayFolder
onready var rotObjs := $rotationalObjects
onready var playerCast := $rotationalObjects/playerCast
onready var shootTimer := $shootTimer
onready var moveTimer := $moveTimer
onready var shootNoisePlayer := $shootNoisePlayer
onready var bulletSpawnPos := $rotationalObjects/bulletSpawnPos
onready var animSprite := $rotationalObjects/AnimatedSprite3D
onready var floorChecker : RayCast = $floorChecker
onready var leftRay : RayCast = $rayFolder/LeftRay
onready var rightRay : RayCast = $rayFolder/RightRay
onready var particles := $Particles
onready var fowardRay : RayCast = $rayFolder/FowardRay
onready var backwardRay : RayCast = $rayFolder/BackWardRay
onready var anim_player := $animPlayer
var maxDamage := 2
var minDamage := 0

var explosionNoises := [
	preload("res://assets/audio/sfx/explosions/explode1.wav"),
	preload("res://assets/audio/sfx/explosions/explode2.wav"),
	preload("res://assets/audio/sfx/explosions/explode3.wav"),
	preload("res://assets/audio/sfx/explosions/explode4.wav"),
	preload("res://assets/audio/sfx/explosions/explode5.wav"),
	preload("res://assets/audio/sfx/explosions/explode6.wav"),
	preload("res://assets/audio/sfx/explosions/explode7.wav"),
	preload("res://assets/audio/sfx/explosions/explode8.wav"),
]
var enemyTypeArr := ["dumbEnemy","yEnemyBat","xEnemyBat","xEnemy","yEnemy"]
var canMove := false
var randYAmtToMove := 0.0
var bulletAmt := 1
func _ready() -> void:
	player = get_parent().get_node("player")
	maxDamage *= Global.difficulty+1
	minDamage *= Global.difficulty+1
	var animNum := str(floor((randi()%3+1)))
	$rotationalObjects/AnimatedSprite3D.play(animNum)
	if enemyType == "dumbEnemy":
#		shootNoisePlayer.stream = preload("res://assets/audio/sfx/kennyTests/impactPlank_medium_000.ogg")
		shootNoisePlayer.stream = preload("res://assets/audio/sfx/shootNoise/shootNoiseNew/shoot1.wav")
	elif enemyType == "yEnemyBat":
#		shootNoisePlayer.stream = preload("res://assets/audio/sfx/kennyTests/impactPlate_heavy_002.ogg")
		shootNoisePlayer.stream = preload("res://assets/audio/sfx/shootNoise/shootNoiseNew/shoot2.wav")
	elif enemyType == "xEnemyBat":
#		shootNoisePlayer.stream = preload("res://assets/audio/sfx/kennyTests/impactPlate_light_004.ogg")
		shootNoisePlayer.stream = preload("res://assets/audio/sfx/shootNoise/shootNoiseNew/shoot3.wav")
	elif enemyType == "xEnemy":
#		shootNoisePlayer.stream = preload("res://assets/audio/sfx/kennyTests/impactPunch_heavy_000.ogg")
		shootNoisePlayer.stream = preload("res://assets/audio/sfx/shootNoise/shootNoiseNew/shoot4.wav")
	elif enemyType == "yEnemy":
#		shootNoisePlayer.stream = preload("res://assets/audio/sfx/kennyTests/impactPunch_heavy_001.ogg")
		shootNoisePlayer.stream = preload("res://assets/audio/sfx/shootNoise/shootNoiseNew/shoot5.wav")
	elif enemyType == "xEnemyBunny":
#		shootNoisePlayer.stream = preload("res://assets/audio/sfx/kennyTests/impactPunch_medium_002.ogg")
		shootNoisePlayer.stream = preload("res://assets/audio/sfx/shootNoise/shootNoiseNew/shoot6.wav")
	elif enemyType == "yEnemyBunny":
#		shootNoisePlayer.stream = preload("res://assets/audio/sfx/kennyTests/impactPunch_medium_004.ogg")
		shootNoisePlayer.stream = preload("res://assets/audio/sfx/shootNoise/shootNoiseNew/shoot7.wav")
	elif enemyType == "bulletEnemy":
#		shootNoisePlayer.stream = preload("res://assets/audio/sfx/kennyTests/impactWood_light_002.ogg")
		shootNoisePlayer.stream = preload("res://assets/audio/sfx/shootNoise/shootNoiseNew/shoot8.wav")
	elif enemyType == "turtleEnemy":
#		shootNoisePlayer.stream = preload("res://assets/audio/sfx/kennyTests/impactWood_medium_002.ogg")
		shootNoisePlayer.stream = preload("res://assets/audio/sfx/shootNoise/shootNoise11.wav")

	if !$rotationalObjects/AnimatedSprite3D.visible:
		queue_free()

func _physics_process(_delta: float) -> void:
	rotObjs.look_at(player.global_transform.origin, Vector3.UP)
	$rotationalObjects/AnimatedSprite3D.visible = true




func _on_shootTimer_timeout() -> void:
	if playerCast.is_colliding() and !get_parent().didPlayerDie:
		if playerCast.get_collider().is_in_group("player"):
#			this might become an issue later on
			for i in bulletAmt:
				shoot_bullet()
			if notFixedBulletTime:
				shootTimer.wait_time = rand_range(0,5)

func _on_moveTimer_timeout() -> void:
	randYAmtToMove = rand_range(-5,5)
	canMove = true
	moveTimer.wait_time = rand_range(0,5)






func shoot_bullet() -> void:
	if canShoot:
		var bullet :Area= preload("res://src/enemy/baseEnemy/enemyBullet.tscn").instance()
		var randX := rand_range(-10,10)  * Global.monsterBulletSpread
		var randY := rand_range(-10,10)  * Global.monsterBulletSpread 
		var randZ := rand_range(-10,10)  * Global.monsterBulletSpread
		var diff : Vector3 = player.global_transform.origin - bulletSpawnPos.global_transform.origin + Vector3(randX, randY,randX)
		bullet.dir = diff.normalized() * bulletSpeed
		get_parent().add_child(bullet)
		bullet.global_transform.origin = global_transform.origin
		if Global.soundAllowed:
			shootNoisePlayer.play()






func _on_baseEnemy_body_entered(body: Node) -> void:
	if body.is_in_group("player") and body.has_method("die"):
		print("hit player", self)
		player.die()

func _on_baseEnemy_area_entered(area: Area) -> void:
	if not dead:
		if area.is_in_group("player") and !area.is_in_group("enemy"):
			anim_player.play("hurt")
			match enemyType:
				"areaEffectEnemy":
					if area.is_in_group("shell") and !area.is_in_group("rockets"):
						area.queue_free()
						die()
					else:
						health = health - floor(rand_range(minDamage,maxDamage))
#						print("subbing health from slime", health," ", randi() % maxDamage + minDamage  )
				"bulletEnemy":
					health -= floor(rand_range(minDamage,maxDamage))
				"xEnemyBunny","yEnemyBunny":
					if area.is_in_group("shell"):
						area.queue_free()
						die()
					else:
						health -= floor(rand_range(minDamage,maxDamage))
				"turtleEnemy":
					if area.is_in_group("rockets"):
						area.queue_free()
						die()
					else:
						health -= floor(rand_range(minDamage,maxDamage))
						print(health)
				"dumbEnemy":
					if area.is_in_group("shell") and !area.is_in_group("bullet"):
						area.queue_free()
						die()
					else:
						health -= floor(rand_range(minDamage,maxDamage))
				"xEnemyBat","yEnemyBat":
					if area.is_in_group("bullet"):
						area.queue_free()
						die()
					else:
						health -= floor(rand_range(minDamage,maxDamage))
				"yEnemy","xEnemy":
					if !area.is_in_group("shell"):
						area.queue_free()
						die()
					else:
						health -= floor(rand_range(minDamage,maxDamage))
				"*":
					area.queue_free()
					die()
		if health <= 0:
			die()
#	only damage from rockets and snipers
#	if enemyType == "areaEffectEnemy" and area.is_in_group("rocket"):
#		pass
#
#	elif enemyType == "dumbEnemy" and area.is_in_group("shells") and area.is_in_group("player"):
#		print("dumb NOT GINVGIN A SHIT")
#
#	elif area.is_in_group("bullet") and !area.is_in_group("enemy") and area.is_in_group("player"):
#
#		area.queue_free()
#		die()

func die() -> void:
	if not dead:
		emit_signal("enemyDied")
		dead = true 
		if Global.soundAllowed:
			shootNoisePlayer.stream = explosionNoises[enemyTypeArr.find(enemyType)]
			shootNoisePlayer.play()
		$rotationalObjects/AnimatedSprite3D.hide()
		$CollisionShape.disabled = true
		$CollisionShape.queue_free()
		set_process(false)
		set_physics_process(false)
		
		particles.emitting = true
		$deathTimer.start()


func _on_deathTimer_timeout() -> void:
	queue_free()


		


func _on_boxyColider_body_entered(body: Node) -> void:
	if body:
#		animSprite.modulate = Color.blue
		queue_free()


func _on_animPlayer_animation_finished(anim_name: String) -> void:
	if anim_name:
		var num :float= health/maxHealth
		print(Color( 1, num,num,1  ))
		animSprite.modulate=  Color( 1, num,num,1  )
