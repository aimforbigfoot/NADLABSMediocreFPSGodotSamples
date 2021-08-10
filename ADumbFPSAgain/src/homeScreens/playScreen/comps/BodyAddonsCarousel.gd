extends "res://src/homeScreens/playScreen/comps/Carosuel.gd"

func _ready() -> void:
	arrOfChoices = [
		"The Old Ways",
		"Rocket Boots",
		"Spring Boots",
		"TrenchCoat",
		"JetSuit",
		"Jetpack",
		"Reversed Thrusters",
		"Gravity Switch"
	]
	secondaryArr =[
		"No Powerup",
		"Lower gravity but only 1 jump",
		"10 Jumps but slower movement",
		"Smaller Collison Box but 50% speed reduction",
		"200% increase in speed, but only 2 jumps",
		"Unlimited jumps but extremelly slow movement",
		"Dash is flipped backwards",
		"Issan Newton would cry if this switch existed"
	]
	arrOfImages = [
		load("res://assets/imgs/powerUpBody/theOldWays.png"),
		load("res://assets/imgs/powerUpBody/rocketBoots.png"),
		load("res://assets/imgs/powerUpBody/springBoots.png"),
		load("res://assets/imgs/powerUpBody/trenchCoat.png"),
		load("res://assets/imgs/powerUpBody/jetSuit.png"),
		load("res://assets/imgs/powerUpBody/jetpack.png"),
		load("res://assets/imgs/powerUpBody/reversedThruster.png"),
		load("res://assets/imgs/powerUpBody/gravitySwitch.png"),
		
	]
	setFromLastRun(0)
	setText() 
