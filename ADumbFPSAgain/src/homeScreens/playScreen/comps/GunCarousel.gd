extends "res://src/homeScreens/playScreen/comps/Carosuel.gd"

func _ready() -> void:
	arrOfChoices = [
		"Pistol",
		"Shotgun",
		"Mega Shotgun",
		"Laser",
#		"Laser Shotgun",
		"Sniper",
		"Multi Sniper",
		"Bouncing Ballo",
		"Plasma Orb",
		"No gun"
	]
	secondaryArr = [
		"Just a good old revolver",
		"Think revolver but 10 times more bullets",
		"Think shotgun but 20 more bullets and longer wait times",
		"A scary deathray",
#		"Even more scary deathrays :o ",
		"Pew pew, monsters no more",
		"Sniper shotgun?",
		"A bouncing ball that lasts for 10 seconds, kills everything it touches",
		"A giant ball that moves slowly but kills a lot of stuff",
		"Oh, I didn't know you wanted this option"
	]
	arrOfImages = [
		load("res://assets/imgs/gunImgs/pistol.png"),
		load("res://assets/imgs/gunImgs/shotgun.png"),
		load("res://assets/imgs/gunImgs/megaShotgun.png"),
		load("res://assets/imgs/gunImgs/laser.png"),
#		load("res://assets/imgs/gunImgs/laserShotgun.png"),
		load("res://assets/imgs/gunImgs/sniper.png"),
		load("res://assets/imgs/gunImgs/multiSniper.png"),
		load("res://assets/imgs/gunImgs/bouncingBall.png"),
		load("res://assets/imgs/gunImgs/plasmaOrbo.png"),
		load("res://assets/imgs/gunImgs/nothing.png"),
	]
	setFromLastRun(1)
	setText()
