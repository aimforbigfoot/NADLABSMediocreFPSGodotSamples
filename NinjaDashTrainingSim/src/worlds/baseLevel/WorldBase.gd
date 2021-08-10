extends Spatial

export var numOfBlocksToSpawnInOneTile := 2
var spacer := 32
var minHeight := 15
var maxHeight := 235
const cubesToSpawnArr := [
	preload("res://src/worlds/comps/bumperComps/disapperBumper/disapperBumper.tscn"),
	preload("res://src/worlds/comps/bumperComps/baseBumper.tscn"),
	preload("res://src/worlds/comps/bumperComps/fasterBumper/fasterBumper.tscn"),
	preload("res://src/worlds/comps/bumperComps/movingBumper/movingBumper.tscn")
]

func _ready() -> void:
#	spawnCubesMatrix(7,7,7)
#	OS.window_fullscreen = true
#	spawnXAmtOfCubeOnePerSquare(7,7,numOfBlocksToSpawnInOneTile)
	spawnWithFans(7,7,numOfBlocksToSpawnInOneTile)
#	spawnWithBoosters(7,7,numOfBlocksToSpawnInOneTile)
#	spawnCubesAlongEdges(7,7,numOfBlocksToSpawnInOneTile*4)
#	spawnCubesInMiddle(7,7,numOfBlocksToSpawnInOneTile)
	$key.connect("gotKey",self,"gotKey")
func getCube():
#	return cubesToSpawnArr[ floor( randf()*cubesToSpawnArr.size() )  ].instance()
	return cubesToSpawnArr[ 1  ].instance()
	
func gotKey() -> void:
	$ninjaPlayer.gotKey()

func spawnCubesAlongEdges(xInt:int, yInt:int,amtOfCubes) -> void:
	var xProp := xInt/2
	var zProp := yInt/2
	var v := 2
	for x in range( -xProp , xProp ):
		for z in range( -zProp, zProp ):
			print(x, " ",z)
			if ((x < v and x > -v) and ( z < v and z > -v )):
				pass
			else:
				for i in amtOfCubes:
					var cube :Area= getCube()
					$bumperNode.add_child(cube)
					cube.global_transform.origin = Vector3( x*spacer, rand_range(minHeight, maxHeight), z*spacer )


func spawnCubesInMiddle(xInt:int, yInt:int,amtOfCubes) -> void:
	var xProp := xInt/2
	var zProp := yInt/2
	var v := 2
	for x in range( -xProp , xProp ):
		for z in range( -zProp, zProp ):
			print(x, " ",z)
			if not((x < v and x > -v) and ( z < v and z > -v )):
				pass
			else:
				for i in amtOfCubes:
					var cube :Area= getCube()
					$bumperNode.add_child(cube)
					cube.global_transform.origin = Vector3( x*spacer, rand_range(minHeight, maxHeight), z*spacer )

func spawnInCorners(xInt:int, yInt:int,amtOfCubes) -> void:
	var xProp := xInt/2
	var zProp := yInt/2
	var v := 2
	for x in range( -xProp , xProp ):
		for z in range( -zProp, zProp ):
			print(x, " ",z)
			if ((x < v and x > -v) or ( z < v and z > -v )):
				pass
			else:
				for i in amtOfCubes:
					var cube :Area= getCube()
					$bumperNode.add_child(cube)
					cube.global_transform.origin = Vector3( x*spacer, rand_range(minHeight, maxHeight), z*spacer )


func spawnXAmtOfCubeOnePerSquare(xInt:int, yInt:int,amtOfCubes) -> void:
	var xProp := xInt/2
	var zProp := yInt/2
	for x in range( -xProp , xProp ):
		for z in range( -zProp, zProp ):
			for i in amtOfCubes:
				var cube :Area= getCube()
				$bumperNode.add_child(cube)
				cube.global_transform.origin = Vector3( x*spacer, rand_range(minHeight, maxHeight), z*spacer )

func spawnWithBoosters(xInt:int, yInt:int,amtOfCubes) -> void:
	var xProp := xInt/2
	var zProp := yInt/2
	for x in range( -xProp , xProp ):
		for z in range( -zProp, zProp ):
			for i in amtOfCubes:
				var thing
				var isRot := false
				if not randf() < 0.1:
					thing  = getCube()
				else:
					isRot = true
					thing = preload("res://src/worlds/comps/interactiveComps/booster/booster.tscn").instance()
				$bumperNode.add_child(thing)
				if isRot:
					thing.rotation_degrees = Vector3( rand_range(0,180),rand_range(0,360),rand_range(0,180)  )
					
				thing.global_transform.origin = Vector3( x*spacer, rand_range(minHeight, maxHeight), z*spacer )


func spawnWithFans(xInt:int, yInt:int,amtOfCubes) -> void:
	var xProp := xInt/2
	var zProp := yInt/2
	for x in range( -xProp , xProp ):
		for z in range( -zProp, zProp ):
			for i in amtOfCubes:
				var thing
				var isRot := false
				if not randf() < 0.1:
					thing  = getCube()
				else:
					isRot = true
					thing = preload("res://src/worlds/comps/interactiveComps/fan/Fan.tscn").instance()
				$bumperNode.add_child(thing)
				if isRot:
					thing.rotation_degrees = Vector3( rand_range(0,180),rand_range(0,360),rand_range(0,180)  )
					
				thing.global_transform.origin = Vector3( x*spacer, rand_range(minHeight, maxHeight), z*spacer )

func spawnCubesMatrix(xInt:int, yInt:int, zInt:int) -> void:
	var xProp := xInt/2
#	var yProp := yInt/2
	var zProp := zInt/2
	for x in range ( -xProp +1, xProp  ):
		for y in (yInt-1):
			for z in range( -zProp+1, zProp):
				var cube :Area= getCube()
				$bumperNode.add_child(cube)
				cube.global_transform.origin = Vector3( x*spacer, (y+1)*spacer, z*spacer )

