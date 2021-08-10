extends Node

var pillarMesh 
var pillarWallMeshes := [
	preload("res://assets/imgs/grounds/miniWallStyles/stonyWall1.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/stonyWall2.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/rock1.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/ground2.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/blueRockWall.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/gravelWall.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/redWall.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/woody1.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/RockyWall1.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/mossyWall1.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/gravelWall1.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/gravelWall2.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/leather.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/gravelWall.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/gravel1.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/gravel2.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/gravel3.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/metal1.tres"),
	preload("res://assets/imgs/grounds/groundStyles/StonyGround1.tres"),
	preload("res://assets/imgs/grounds/groundStyles/GrassGround.tres"),
	preload("res://assets/imgs/grounds/groundStyles/WoodyGround1.tres"),
	preload("res://assets/imgs/grounds/groundStyles/chip1.tres"),
	preload("res://assets/imgs/grounds/groundStyles/concrete1.tres"),
	preload("res://assets/imgs/grounds/groundStyles/concrete2.tres"),
	preload("res://assets/imgs/grounds/groundStyles/fingerprints1.tres"),

]

var miniWallMesh 
var miniWallMeshes := [
	preload("res://assets/imgs/grounds/miniWallStyles/stonyWall1.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/stonyWall2.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/rock1.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/ground2.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/blueRockWall.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/gravelWall.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/redWall.tres"),
	preload("res://assets/imgs/grounds/miniWallStyles/woody1.tres"),
]

var regularWallMesh
var regularWallMeshes := [
	preload("res://assets/imgs/grounds/regularWallStyles/RockyWall1.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/mossyWall1.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/gravelWall1.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/gravelWall2.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/leather.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/gravelWall.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/gravel1.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/gravel2.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/gravel3.tres"),
	preload("res://assets/imgs/grounds/regularWallStyles/metal1.tres"),
]

var floorMesh 
var floorMeshes := [
	preload("res://assets/imgs/grounds/groundStyles/StonyGround1.tres"),
	preload("res://assets/imgs/grounds/groundStyles/GrassGround.tres"),
	preload("res://assets/imgs/grounds/groundStyles/WoodyGround1.tres"),
	preload("res://assets/imgs/grounds/groundStyles/chip1.tres"),
	preload("res://assets/imgs/grounds/groundStyles/concrete1.tres"),
	preload("res://assets/imgs/grounds/groundStyles/concrete2.tres"),
	preload("res://assets/imgs/grounds/groundStyles/fingerprints1.tres"),
]


var songsArr := [
	preload("res://assets/songs/chillBackBeat.wav"),
	preload("res://assets/songs/hellsHallsBackBeat.wav"),
	preload("res://assets/songs/hypedBackBeat.wav"),
	preload("res://assets/songs/mye1m1.wav"),
	preload("res://assets/songs/mysteriousBackBeat.wav"),
]

var levelSelectorArr := [
	("res://src/world/World.tscn"),
	("res://src/world/World.tscn"),
	("res://src/bosses/cylinderBoss/cylinderBossLand.tscn"),
	("res://src/world/World.tscn"),
	("res://src/bosses/handBoss/handBossLand.tscn"),
	("res://src/world/World.tscn"),
	("res://src/bosses/pyramidBoss/pyramidBossLand.tscn"),
	("res://src/world/World.tscn"),
	("res://src/bosses/octogonalBoss/octogonalBossLand.tscn"),
	("res://src/titleScreen/endScreen/endScreen.tscn")
]


var arrOfPowerUps := [
	"More ammo from ammo packs",
	"Get 1000 health, but take more damage",
	"Take away all ammo, but get a lot more ammo from ammo packs",
	"Monsters have lower accuracy, but do 2x the damage",
	"Take less damage, but monsters fire more bullets",
	"Go to 1 HP but all enemy bullets are extemelly slow",
	"get one extra jump, and lower gravity",
	"Reduced gravity by 50%",
	"Increased speed by 2x",
	"50% chance not to use ammo, but also 50% chance to use double ammo",
	"All reload times doubled and double damage",
	"All projectiles travel further but slower",
	"All enemy projectiles are slower but do dobule damage",
	"Increase gravity by 2x, but move 2x faster",
	"disable gravity by pressing F",
	"toggle gravity by pressing F",
	"Get 1000 ammo for every weapon",
	"Get 5 extra jumps",
	"Lose 1 jump for extra greater jump height",
]

#var gunAmmos := ["Infinite",50,100,50,500]
#var gunArr := ["pistol","rocket","shoutgun","sniper","uzi"]
var player : KinematicBody
var jumpAmts := 3
var enemyProjectileSpeed := 3
var reloadTimes := 0.0 #find			Global.ammoAmtToBePickedUP = ["Infinite",100,200,100,500]
var ammoAmtToBePickedUP := ["",50,50,50,200] #find
var gravityAmt := 0.0 #find
var playerSpeed :=200.0 #find
var damageFromEnemyBullet := 0.0 #find
var monsterBulletSpread := 1.0 #will be multpler on vector of uncertanity
var playerjumpStrength := 0.0 #find
var chanceOfWantedAmmo := 0.01
var minDamageEnemy = 17
var maxDamageEnemy = 20
func take_away_all_ammo_but_get_more_from_ammo_packs() -> void:
	ammoAmtToBePickedUP = ["", 100, 100, 100, 1000]
	globalAmmoArr = ["Infinite",0,0,0,0]
	
	pass

func setPlayerHealth(num:int) -> void:
	player.globalHealthNum = num




func randomiez_the_meshes() -> void:
	randomize()
	miniWallMesh = miniWallMeshes[ floor( randf()*miniWallMeshes.size() ) ]
	regularWallMesh = regularWallMeshes[ floor( randf()*regularWallMeshes.size() )]
	floorMesh = floorMeshes[floor( randf()*floorMeshes.size() )]
	pillarMesh = pillarWallMeshes[floor(randf()*pillarWallMeshes.size())]

# MAKE SURE TO SWTICH BACK TO 0 For EXPORT
var difficulty : int = 0
var gameMode : String = "infinite"
var levelNum := 1
var globalHealthNum := 100
var globalAmmoArr := ["Infinite",50,100,50,500]
#If you must eek out every drop of performance, delte the music nodes and sound nodes if these are set to false
#Right now it is set to check every time : ( 
var musicAllowed := true
var soundAllowed := true
var canShake := true
var mouseSensitivty : float = 0.2
var playAnimStarting := "start"

var usedPowerUP := []

func _ready() -> void:
	for thing in arrOfPowerUps:
		usedPowerUP.append(false)
