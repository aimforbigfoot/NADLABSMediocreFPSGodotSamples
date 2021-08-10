extends Button

#var arrOfPowerUps := [
#	"More ammo from ammo packs, but will not be for the one you want",
#	"Get 1000 health, but take more damage",
#	"Take away all ammo, but get 10x more ammo from ammo packs",
#	"Monsters have lower accuracy, but do 2x the damage",
#	"Take less damage, but monsters fire more bullets",
#	"Go to 1 HP but all enemy bullets are extemelly slow",
#	"get one extra jump, and lower gravity",
#	"Reduced gravity by 50%",
#	"Increased speed by 2x",
#	"50% chance not to use ammo, but also 50% chance to use double ammo",
#	"All reload times doubled and double damage",
#	"All projectiles travel further but slower",
#	"All enemy projectiles are slower but do dobule damage",
#	"Increase gravity by 2x, but move 2x faster",
#	"disable gravity by pressing F",
#	"toggle gravity by pressing F",
#	"Get 1000 ammo for every weapon",
#	"Get 5 extra jumps",
#	"Lose 1 jump for extra greater jump height",
#]

var chosenPowerUpText = ""

func _ready() -> void:
	randomize()

	Global.arrOfPowerUps.shuffle()
	var randNum := floor( Global.arrOfPowerUps.size()*randf() )
	if Global.usedPowerUP[randNum] == false:
		chosenPowerUpText = Global.arrOfPowerUps[ randNum ]
		text = chosenPowerUpText
	else:
		text = "No choice for you"


func _on_PowerUpButton_pressed() -> void:
	match chosenPowerUpText:
		"More ammo from ammo packs, but will not be for the one you want":
			Global.passchanceOfWantedAmmo = 0.9
			Global.ammoAmtToBePickedUP = ["Infinite",100,200,100,500]
		"Get 1000 health, but take more damage":
			Global.globalHealthNum = 1000
			Global.minDamageEnemy = 20
			Global.maxDamageEnemy = 40
			
		"Take away all ammo, but get 10x more ammo from ammo packs":
			Global.take_away_all_ammo_but_get_more_from_ammo_packs()
		"Monsters have lower accuracy, but do 2x the damage":
			Global.monsterBulletSpread = 5
			Global.minDamageEnemy *= 2
			Global.maxDamageEnemy *= 2
		"Take less damage, but monsters fire more bullets":
			pass
		"Go to 1 HP but all enemy bullets are extemelly slow":
			pass
		"get one extra jump, and lower gravity":
			pass
		"Reduced gravity by 50%":
			pass
		"Increased speed by 2x":
			pass
		"50% chance not to use ammo, but also 50% chance to use double ammo":
			pass
		"All reload times doubled and double damage":
			pass
		"All projectiles travel further but slower":
			pass
		"All enemy projectiles are slower but do dobule damage":
			pass
		"Increase gravity by 2x, but move 2x faster":
			pass
		"disable gravity by pressing F":
			pass
		"toggle gravity by pressing F":
			pass
		"Get 1000 ammo for every weapon":
			pass
		"Get 5 extra jumps":
			pass
		"Lose 1 jump for extra greater jump height":
			pass
			
