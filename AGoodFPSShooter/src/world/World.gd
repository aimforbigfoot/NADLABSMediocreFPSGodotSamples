extends Spatial

var arrOfTiles := [
#	preload("res://src/world/worldTiles/floorMiddlePlatforms.tscn"),
#	preload("res://src/world/worldTiles/floorPlusMiddle.tscn"),
#	preload("res://src/world/worldTiles/floorPlatformSides.tscn"),
#	preload("res://src/world/worldTiles/bridges.tscn"),
#	preload(),
	preload("res://src/world/floor.tscn"),
]

var enemyArr := [ 
	preload("res://src/enemy/jumpingEnemy/jumpingEnemy.tscn"),
	preload("res://src/enemy/devilFace/devilFaceEnemy.tscn"),
	preload("res://src/enemy/robots/basic/basicBot.tscn"),
	preload("res://src/enemy/octaEnemy/octaEnemy.tscn"),
	preload("res://src/enemy/torusEnemy/torusEnemy.tscn")
	
 ]

var spawnSpots := []


func _ready() -> void:
#	OS.window_fullscreen = true
	Global.enemyFolder = $enemyFolder
#	chooseAGround()
	for spot in 10:
		print(spot)
#		spawnEnemyAtGivenPos( spot.global_transform.origin  )
		spawnEnemyRandomly()

func chooseAGround() -> void:
	var ground :StaticBody= arrOfTiles[ floor( randf()*arrOfTiles.size() )  ].instance()
	$worldStuff.add_child(ground)
	spawnSpots = ground.spawnPointsArr
	pass

func spawnEnemyAtGivenPos( spot: Vector3 ) -> void:
	var enemy :Area= enemyArr[ floor( enemyArr.size()*randf()  )  ].instance()
	$enemyFolder.add_child(enemy)
	enemy.global_transform.origin = spot
	pass


func spawnEnemyRandomly() -> void:
	var enemy :Area= enemyArr[ floor( enemyArr.size()*randf()  )  ].instance()
	$enemyFolder.add_child(enemy)
