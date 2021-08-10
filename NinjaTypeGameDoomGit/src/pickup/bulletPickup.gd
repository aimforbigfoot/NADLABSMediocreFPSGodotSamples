extends Area

var gunAmmos := ["Infinite",50,100,50,500]
func _on_bulletPickup_body_entered(body: Node) -> void:
	if body.is_in_group("player") and !body.is_in_group("bullet"):
		if randf() < Global.chanceOfWantedAmmo:
			var randPos := floor(rand_range(1,5))
			if randPos == 1:
				body.gunAmmos[randPos] += 10
				pass
			elif randPos == 2:
				body.gunAmmos[randPos] += 50
				pass
			elif randPos == 3:
				body.gunAmmos[randPos] += 10
				pass
			elif randPos == 4:
				body.gunAmmos[randPos] += 100
			elif randPos == 5:
				body.gunAmmos[randPos] += 200
			else:
				for thing in body.gunAmmos.size():
					if typeof(body.gunAmmos[thing]) != TYPE_STRING:
						body.gunAmmos[thing] += 100
			regularStuff(body)
		else:
			var purposePos :int= body.gunPosToShow
			if purposePos == 1:
				body.gunAmmos[purposePos] += 10
				pass
			elif purposePos == 2:
				body.gunAmmos[purposePos] += 50
				pass
			elif purposePos == 3:
				body.gunAmmos[purposePos] += 10
				pass
			elif purposePos == 4:
				body.gunAmmos[purposePos] += 100
			elif purposePos == 5:
				body.gunAmmos[purposePos] += 200
			else:
				for thing in body.gunAmmos.size():
					if typeof(body.gunAmmos[thing]) != TYPE_STRING:
						body.gunAmmos[thing] += 100
#var gunAmmos := ["Infinite",50,100,50,500]
#var gunArr := ["pistol","rocket","shoutgun","sniper","uzi"]
			
			regularStuff(body)


func regularStuff (body) -> void:
	$AudioStreamPlayer3D.playing=true
	body.ammoPickedUp()
	body.updateAmmoCount()
	queue_free()
