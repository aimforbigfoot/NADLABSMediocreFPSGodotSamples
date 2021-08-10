extends Spatial

var enemyArr := [
	preload("res://src/enemy/charger/charger.tscn"),
#	preload("res://src/enemy/spikeySawster/spikeySawster.tscn")
]

func _ready() -> void:
	randomize()
#	spawnCubeMaze()
#	spawn4Walls()
#	for i in 20:
#		spawnMonster()

func spawnCubeMaze() -> void:
	var arrOfBlocks := [
		preload("res://assets/objs/ramps/rampFloorBlock.tscn"),
		preload("res://src/world/base/blocks/flat1.tscn"),
		preload("res://src/world/base/blocks/flat2.tscn"),
		preload("res://src/world/base/blocks/flat3.tscn"),
	]
	for x in 5:
		for y in 5:
			for z in 5:
				if randf() < 0.5:
					var posOfWall := Vector3( (x-2)*32 , (y+1)*32 , (z-2)*32  )
					var floorBlock = arrOfBlocks[ floor(  randf() * arrOfBlocks.size() ) ]  .instance()
					$Cube/nodeOfGeneratedObjects.add_child(floorBlock)
					floorBlock.global_transform.origin = posOfWall
	var varOfUsedPoss := []
	for x in 6:
		for y in 6:
			for z in 6:
				if randf() < 0.1:
					var isPosThere := false
					var randPos := Vector3( (16 + ( 32 * (x-3)  )) , ( 16*(y+2) ) , (16 + ( 32 * (z-3)  ))  )+Vector3( rand_range(-1,1), 0, rand_range(-1,1) )
					for pos in varOfUsedPoss:
						if pos == randPos:
							isPosThere = true
					if not isPosThere:
						varOfUsedPoss.append(randPos)
						var floorBlock :StaticBody= preload("res://assets/objs/ramps/rampFloorBlock.tscn").instance()
						$Cube.add_child(floorBlock)
						floorBlock.global_transform.origin = randPos
						floorBlock.rotation_degrees.x = 90
	print(varOfUsedPoss)
func spawnMonster() -> void:
	var enemy = enemyArr[ floor( enemyArr.size() * randf()  )  ].instance()
	$enemyFolder.add_child(enemy)


func spawn4Walls() -> void:
	for i in 4:
		var wall :StaticBody= preload("res://src/world/base/wall.tscn").instance()
		$Cube.add_child(wall)
		wall.global_transform.origin = Vector3(rand_range(-95,95), rand_range(10,60), rand_range(-95,95)  )
	pass

