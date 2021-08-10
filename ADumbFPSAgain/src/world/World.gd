extends Spatial

var enemyArr := [
	preload("res://src/enemy/teleporterEnemy/teleporterEnemy.tscn"),
	preload("res://src/enemy/lostMold/lostMold.tscn"),
	preload("res://src/enemy/bandit/bandit.tscn"),
	preload("res://src/enemy/bouncer/bouncer.tscn"),
	preload("res://src/enemy/slogaSlime/slogaSlime.tscn"),
	preload("res://src/enemy/stupidSkull/stupidSkull.tscn"),
	preload("res://src/enemy/follower/follower.tscn"),
#	preload("res://src/enemy/wallCritter/wallCritter.tscn"),
	preload("res://src/enemy/aLargeHulkingCentipede/aLargeHulkingCentipede.tscn"),
#	preload("res://src/enemy/orbo/orbo.tscn") this one doesn't fit the feel of the game
]
var spawnArr := []
var colorArr := [
	"e7d4b5",
	"3d84b8",
	"00f4ff",
	"c6ffc1",
	"890596",
	"ff79cd",
	"fdca40",
	"40edfd",
	"f5f7b2",
	"fcecdd",
	"2be3bb",
	"ff79cd",
	"eeeeee",
	"d8f8b7",
	"8ab6d6",
	"d8e3e7",
]


func _ready() -> void:
	var posOfFloor := Vector3(0,-20.1,0)
	Global.xPointsWall = $worldItems/wallPointsx.get_children()
	match Global.arrOfSettings[2]:
		0:
			var floord :StaticBody= preload("res://src/world/blocks/largeWall.tscn").instance()
			$worldItems.add_child(floord)
			floord.global_transform.origin = posOfFloor
		1:
			var floord :StaticBody= preload("res://src/world/blocks/largeWallWithPlatforms.tscn").instance()
			$worldItems.add_child(floord)
			floord.global_transform.origin = posOfFloor
		2:
			var floord :StaticBody= preload("res://src/world/blocks/largeWallWith4SmallerWalls.tscn").instance()
			$worldItems.add_child(floord)
			floord.global_transform.origin = posOfFloor
	randomize()
	print(Global.arrOfSettings)
	var temp1 :SpatialMaterial= load("res://Material.material")
	var mat1 := SpatialMaterial.new()
	var temp2 : = load("res://default_env.tres")
	temp2.background_energy = 0.0
	var colChosen := Color(colorArr[ floor( randf()*colorArr.size() )  ])
	Global.colorChosen = colChosen
	temp1.emission = colChosen
	temp1.albedo_color= colChosen
	Global.pointsAvaliable = $worldItems/floorPoints.get_children()
	enemyArr.shuffle()
	for i in 3:
		spawnArr.append(enemyArr[ floor(randf()*enemyArr.size()  ) ])
	for i in 20:
		spawnEnemy()
	


func spawnEnemy() -> void:
	var enemy :Area= enemyArr[ floor( enemyArr.size() * randf() ) ].instance()
#	var enemy :Area= spawnArr[ floor( spawnArr.size() * randf() ) ].instance()
	$enemyFolder.add_child(enemy)
	var pointNum := randf() * Global.pointsAvaliable.size()
	if enemy.isFlying == true:
		enemy.global_transform.origin.y = rand_range(100,300)
	if enemy.isSpecialPlacement == false:
		print("true")
		enemy.global_transform.origin = Global.pointsAvaliable[ floor( pointNum ) ].global_transform.origin
#	enemy.global_transform.origin.y = 0.0
	
