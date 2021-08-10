extends Sprite

var arrOfImages := [
	preload("res://assets/imgs/picturesOfGun/pistol.png"),
	preload("res://assets/imgs/picturesOfGun/rocketlauncherSide.png"),
	preload("res://assets/imgs/picturesOfGun/shotgun.png"),
	preload("res://assets/imgs/picturesOfGun/sniper.png"),
	preload("res://assets/imgs/picturesOfGun/machinegun.png"),
]

#	if Input.is_action_pressed("lClick") and canShoot:
#		if gunPosToShow == 0: # PISTOL
#			spawn_bullet(0, 0.1,6.0, false,0)
#		elif gunPosToShow == 1: # ROCKET 
#			pass # TO MAKE ROCKET
#		elif gunPosToShow == 2: # SHOUTGUN
#			for i in 20:
#				spawn_bullet(250, 0.2, 10.0,true, PI/24)
#		elif gunPosToShow == 3: # SNIPER
#			fire_ray_cast_bullet(500, 0.5)
#		elif gunPosToShow == 4: # UZI - or sub machine gun for intents and pursospe
#			spawn_bullet(75, 0.01, 10.0,true,PI/64)
#	var amtToMove := 0.01
	


func _on_player_gunChanged(arg) -> void:
	texture = arrOfImages[arg[0]]
#	if arg == 0:
#		texture = 
#	elif arg == 1:
#		pass
#	elif arg == 2:
#		pass
#	elif arg == 3:
#		pass
#	elif arg == 4:
#		pass
		
	print("gunPosChangedTo",arg)
