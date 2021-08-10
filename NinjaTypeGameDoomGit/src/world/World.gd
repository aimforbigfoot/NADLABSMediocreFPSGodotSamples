extends Spatial

var passedLevelFlag := false 
var width := 10
var height := 10
var blockArr := [ 
	preload("res://src/world/blocks/BaseFloor.tscn"),
#		preload("res://src/world/blocks/BaseFloorWithMini4Walls.tscn"),
#	preload("res://src/world/blocks/FloorWithMiddleWall.tscn"),
	preload("res://src/world/blocks/FloorWithWall.tscn"),
#	preload("res://src/world/blocks/FloorWithWallwithStep.tscn"),
	preload("res://src/world/blocks/FloorWithRoof.tscn"),
#	preload("res://src/world/blocks/FloorWith4MiddleSegments.tscn"),
	preload("res://src/world/blocks/FloorWith2Walls.tscn"),
	preload("res://src/world/blocks/FloorWith1SmallerWall.tscn"),
#	preload("res://src/world/blocks/slantedWall.tscn"),
#	preload("res://src/world/blocks/MiniWallPlus.tscn"),
	preload("res://src/world/blocks/Stacked3MiniWalls.tscn"),
#	preload("res://src/world/blocks/LowMiniwalls.tscn"),
#	preload("res://src/world/blocks/HigherMiniWalls.tscn"),
#	preload("res://src/world/blocks/TwoMiniWallsSlanted.tscn"),
#	preload("res://src/world/blocks/cornerMiniWallFloating.tscn"),
#	preload("res://src/world/blocks/FloatingRoofSideHalfWallSide.tscn"),
	preload("res://src/world/blocks/SpiraledStairCase.tscn"),
	preload("res://src/world/blocks/FloatingRoofs3.tscn"),
	preload("res://src/world/blocks/LotsFiveOfSlantedMinis.tscn"),
#	preload("res://src/world/blocks/StartingSquare.tscn"),
	preload("res://src/world/blocks/TunnelTile.tscn"),
#	preload("res://src/world/blocks/TunnelOffOneSide.tscn"),
	preload("res://src/world/blocks/FloorAtTheTop.tscn"),
#	preload("res://src/world/blocks/CoveredArea.tscn"),
	preload("res://src/world/blocks/twoSlantedWallsHigh.tscn"),
#	preload("res://src/world/blocks/MiddleHoleInWall.tscn"),
#	preload("res://src/world/blocks/DoubleMiddleHoleInWall.tscn"),
	
	preload("res://src/world/blocks/pillarBlocks/PillarMiddle.tscn"),
	preload("res://src/world/blocks/pillarBlocks/FourPillarsInMiddle.tscn"),
	preload("res://src/world/blocks/pillarBlocks/PillarTower.tscn"),
	preload("res://src/world/blocks/pillarBlocks/MiniArchPillars.tscn"),
	preload("res://src/world/blocks/pillarBlocks/pillarRoof.tscn"),
	preload("res://src/world/blocks/pillarBlocks/LargePillarRoof.tscn")
]
var enemyArr := [
	preload("res://src/enemy/dumbEnemy/dumbEnemy.tscn"),
	preload("res://src/enemy/yEnemyBat/yEnemyBat.tscn"),
	preload("res://src/enemy/xEnemyBat/xEnemyBat.tscn"),
	preload("res://src/enemy/xEnemy/xEnemy.tscn"),
	preload("res://src/enemy/yEnemy/yEnemy.tscn"),
	preload("res://src/enemy/areaEffectEnemy/areaEffectEnemy.tscn"),
	preload("res://src/enemy/turtleEnemy/turtleEnemy.tscn"),
	preload("res://src/enemy/bulletEnemy/bulletEnemy.tscn"),
	preload("res://src/enemy/xEnemyBunny/xEnemyBunny.tscn"),
	preload("res://src/enemy/yEnemyBunny/yEnemyBunny.tscn")
]
export var enemyMargin := 9.0
const size := 40
var minAmtOfEnemies := 2
var didPlayerDie := false
var paused := false
onready var musicPlayer := $WorldStuff/musicPlayer
onready var player := $player
onready var pauseScreen := $player/head/Camera/UISTuff/pauseScreen

func _ready() -> void:
	randomize()
	Global.randomiez_the_meshes()
	if Global.musicAllowed:
		musicPlayer.stream = Global.songsArr[ floor(Global.songsArr.size() * randf()  ) ]
		musicPlayer.play()
	var procSky := ProceduralSky.new()
	procSky.sky_top_color= Color(randf(),randf(),randf(),1  )
	procSky.sky_horizon_color = Color(randf(),randf(),randf(),1  )
	procSky.ground_horizon_color = Color(randf(),randf(),randf(),1  )
	procSky.ground_bottom_color = Color.black
	procSky.sun_color = Color(randf(),randf(),randf(),1  )
	var de : = load("res://default_env.tres")
	de.background_sky = procSky
#	var randEnemyNum := randf()
	enemyArr.shuffle()
#	if randEnemyNum < 0.25:
#		enemyArr.pop_back()
#		enemyArr.pop_front()
#	elif randEnemyNum < 0.5:
#		enemyArr.pop_front()
#		enemyArr.pop_front()
#		enemyArr.pop_front()
#	elif randEnemyNum < 0.75:
#		enemyArr.pop_front()
#	else:
#		enemyArr.pop_front()
#		enemyArr.pop_front()
#		enemyArr.pop_front()
#		enemyArr.pop_front()
	if Global.levelNum == 1:
		Global.globalAmmoArr= ["Infinite",50,100,50,500]

	var arrOfAngles := [0,90,180,270]
	for x in width:
		for y in height:
			var block : StaticBody = blockArr[ floor( randf()*blockArr.size() )  ].instance()
			if x == 0 and y == 0:
				block = preload("res://src/world/blocks/StartingSquare.tscn").instance()
			else:
				block.rotation_degrees.y = arrOfAngles[ floor( randf()*arrOfAngles.size()  ) ]
			add_child(block)
			if !(x < 3 and y < 3): 
#				if randf() < 0.92 and Global.gameMode !="test":
				if randf() < (Global.difficulty+1)*0.2+((Global.difficulty+1)/50)and Global.gameMode !="test":
					spawn_enemy(x,y)
			block.global_transform.origin = Vector3( x*size , 0, y*size  ) 

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("q") and didPlayerDie:
		get_tree().change_scene("res://src/titleScreen/TitleScreen.tscn")
	if event.is_action_pressed("r") and didPlayerDie:
# warning-ignore:return_value_discarded
#		Global.levelNum = 1
		get_tree().reload_current_scene()
	if event.is_action_pressed("m"):
		musicPlayer.stop()
		musicPlayer.volume_db = -80
		print("yes, muted")


func spawn_enemy(x:int, y:int) -> void:
	var enemy : Area = enemyArr[ floor(enemyArr.size()*randf()) ].instance()
	add_child(enemy)
	var specifiedY := 10
	var randX := x*size + rand_range(enemyMargin,30-enemyMargin)
	var randZ := y*size + rand_range(enemyMargin,30-enemyMargin) 
	if enemy.enemyType == "yEnemyBat":
		specifiedY = 40
	elif enemy.enemyType == "xEnemyBat":
		specifiedY = 100
	
	enemy.global_transform.origin = Vector3( randX, specifiedY, randZ  )
	pass


func _on_Timer_timeout() -> void:
	if Global.gameMode != "test":
		if randf() < 0.01:
			minAmtOfEnemies += 1
			print(minAmtOfEnemies)
		
		if player.global_transform.origin.y < -100:
#			Global.levelNum = 1
		
			get_tree().reload_current_scene()
		
		var amtOfEnemiesLeft := 0
		for child in get_children():
			if child.is_in_group("enemy"):
				amtOfEnemiesLeft+= 1
		if amtOfEnemiesLeft > minAmtOfEnemies:
			print("you still have work and ememies to clear")
			if not musicPlayer.playing and Global.musicAllowed and not passedLevelFlag:
				musicPlayer.stream = Global.songsArr[ floor(Global.songsArr.size() * randf()  ) ]
				musicPlayer.play()
		else:
			passedLevelFlag = true
			print("all enmies clearned, go ahead chief")
			musicPlayer.stop()
	#		player.die("good")
			var portal : Area = preload("res://src/pickup/portal.tscn").instance()
			add_child(portal)
