extends Spatial

var floorComps := [
	preload("res://src/world/comps/baseFloor.tscn"),
#	preload("res://src/world/comps/bumperUpper.tscn"), # DO NOT MOVE THIS LINE OR THE DASHES BREAK
	preload("res://src/world/comps/floorWithWall.tscn"),
	preload("res://src/world/comps/floorWithWallUpHigh.tscn"),
	preload("res://src/world/comps/floorWithPillar.tscn"),
#	preload("res://src/world/comps/baseFloorWithBox.tscn"),
#	preload("res://src/world/comps/baseFloorWithGate.tscn"),
#	preload("res://src/world/comps/floorWithRamp.tscn")
]
var enemyArr := [
	preload("res://src/enemy/groundCharger/bounceVersion/groundChargerBounce.tscn"),
	preload("res://src/enemy/stupidSouls/stupidSouls.tscn"),
	preload("res://src/enemy/bandit/bandit.tscn"),
	preload("res://src/enemy/hider/hider.tscn"),
	preload("res://src/enemy/telePorter/telePorter.tscn"),
	preload("res://src/enemy/playerVelEnemy/playerVelEnemy.tscn"),
	preload("res://src/enemy/groundCharger/groundCharger.tscn"),
	preload("res://src/enemy/groundBandit/groundBandit.tscn"),
	preload("res://src/enemy/painElomental/painElomental.tscn"),
	preload("res://src/enemy/sensora/sensora.tscn"),
#smaller but more frequent AOE
	preload("res://src/enemy/jumpingEnemy/jumpingEnemy.tscn"),
#larger but less frequent AOE
	preload("res://src/enemy/nightHell/nightHell.tscn")
	
]


var xSizeOfMap : int = 7
var tileSize := 16.0
var ySizeOfMap : int = 7

func _ready() -> void:
#	OS.window_fullscreen = true
	randomize()
	spawnMap()
	for i in 50:
		print(i)
		spawnEnemy()


func spawnMap() -> void:
#	xSizeOfMap = 8
#	ySizeOfMap = 8
	xSizeOfMap = rand_range(6,10)
	ySizeOfMap = rand_range(6,10)
	Global.mapSize = Vector2(xSizeOfMap,ySizeOfMap)
	for x in range( -xSizeOfMap,xSizeOfMap ):
		for y in range( -ySizeOfMap, ySizeOfMap ):
			var floorInst : StaticBody
			var spot := floor( floorComps.size()*randf()  )
			if randf() < 0.5:
				floorInst = floorComps[0].instance()
			else:
				floorInst= floorComps[ spot ].instance()
			
			$worldFolder.add_child(floorInst)
#			if spot != 1:
#				floorInst.rotation_degrees.y = 0 if randf() < 0.5 else 90
			floorInst.global_transform.origin = Vector3( 
				x*tileSize,
				-0.5,
				y*tileSize
			)
	spawnAWallAtGivenPosWithRot(  (xSizeOfMap*tileSize)+(tileSize/8),0, 0,90   )
	spawnAWallAtGivenPosWithRot(  (-(   ((xSizeOfMap+1)*tileSize)+(tileSize/8))  )   ,0, 0,90   )
	spawnAWallAtGivenPosWithRot(  0, (ySizeOfMap*tileSize)+(tileSize/8)  , 90,0   )
	spawnAWallAtGivenPosWithRot(  0,  (-(((ySizeOfMap+1)*tileSize)+(tileSize/8))  )  , 90,0   )
	
	

func spawnAWallAtGivenPosWithRot(posX,posZ,rotX,rotZ) -> void:
	var wall :StaticBody= preload("res://src/world/roofs/largeRoof.tscn").instance()
	$worldFolder.add_child(wall)
	wall.global_transform.origin = Vector3(posX,0,posZ)
	wall.rotation_degrees = Vector3(rotX,0, rotZ)
	pass
	


func spawnEnemy() -> void:
	var enemy : KinematicBody = enemyArr[ floor( enemyArr.size()*randf()  )  ].instance()
	$enemyFolder.add_child(enemy)
	enemy.global_transform.origin.x = rand_range( (xSizeOfMap-1)*tileSize, 10  ) if randf() < 0.5 else rand_range( -10, -(xSizeOfMap-1)*tileSize  ) 
	enemy.global_transform.origin.z = rand_range( (ySizeOfMap-1)*tileSize, 10  ) if randf() < 0.5 else rand_range( -10, -(ySizeOfMap-1)*tileSize  ) 
	

