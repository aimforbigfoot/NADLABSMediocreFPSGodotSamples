extends Spatial

onready var monkey := $MonkeyDude

func _ready() -> void:
	getClosestButtonFolder()
	$LightBox.connect("smthClicked",self,"btnWasPressed")
	$smallArea.connect("body_entered",self,"bdEnter")

func bdEnter(bdy:PhysicsBody) -> void:
	if bdy:
		moveMonkeyToTree()

func btnWasPressed(spot:String) -> void:
	if randf() < (GlobalSettings.difficulity-0.75):
		moveMonkeyToGround()
	else:
		moveMonkeyToTree()
	print("lightBtn Pressed",spot)


func moveMonkeyToGround() -> void:
	var childSpotNum := floor($MonkeyStandingSpots.get_child_count() * randf() )
	var thingToReturn :Position3D= $MonkeyStandingSpots.get_child(childSpotNum  )
	monkey.playAnim("standing")
	monkey.global_transform.origin = thingToReturn.global_transform.origin
	print(monkey.global_transform.origin, thingToReturn.global_transform.origin)


func moveMonkeyToTree() -> void:
	var childSpotNum := floor($MonkeySpots.get_child_count() * randf() )
	var thingToReturn :Position3D= $MonkeySpots.get_child(childSpotNum  )
	monkey.spot = thingToReturn.get_groups()[0]
	monkey.playAnim("swinging")
	monkey.global_transform.origin = thingToReturn.global_transform.origin
	print(monkey.global_transform.origin, thingToReturn.global_transform.origin)


func getClosestButtonFolder() -> void:
	var buttonFolder : Spatial = get_parent().get_node("buttonSpots")
	var closestPos : Spatial
	var farthestPos : Spatial
	var closestDist : float = 10000
	var farthestDist : float = 10
	for button in buttonFolder.get_children():
		var currDist := global_transform.origin.distance_squared_to(button.global_transform.origin)
		if currDist > farthestDist :
			farthestDist = currDist
			farthestPos = button
		if currDist < closestDist:
			closestDist = currDist
			closestPos = button
	$LightBox.global_transform.origin = closestPos.global_transform.origin
	$smallArea.global_transform.origin = farthestPos.global_transform.origin



func _on_SwingTimer_timeout() -> void:
	pass # Replace with function body.


func _on_moveToGround_timeout() -> void:
	pass # Replace with function body.
