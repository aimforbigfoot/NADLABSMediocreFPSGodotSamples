extends Spatial

onready var croc := $crocDude
var buttonFolder : Spatial
var crawlingFolder : Spatial
var myCrawlingSpot : Spatial

func _ready() -> void:
	randomize()
	buttonFolder = get_parent().get_node("buttonSpots")
	crawlingFolder = get_parent().get_node("crawlingFolder")
	getClosestButtonFolder()
	$crocTimer.connect("timeout",self,"crocTimerTimeOut")
	GlobalSettings.difficulity = 1.0

func getClosestButtonFolder() -> void:
	var closestPos : Spatial
	var closestDist : float = 10000000
	for button in buttonFolder.get_children():
		var currDist := global_transform.origin.distance_squared_to(button.global_transform.origin)
		print(currDist)
		if currDist < closestDist:
			closestDist = currDist
			closestPos = button
	$crocBoxBetter.global_transform.origin = closestPos.global_transform.origin

func getClosestCrawlingFolder() -> void:
	var closestDist : float = 10000000
	for spot in crawlingFolder.get_children():
		var currDist := global_transform.origin.distance_squared_to(spot.global_transform.origin)
		if currDist < closestDist:
			closestDist = currDist
			myCrawlingSpot = spot
	$CrawlingCroc.global_transform.origin = myCrawlingSpot.get_child( floor(randf()*myCrawlingSpot.get_child_count()) ).global_transform.origin
	

func getFleeVec() -> void:
	croc.vel = (croc.global_transform.origin - getRandomPosFromStartingFolder()).normalized() * -40
	$crocTimer.start(5)

func bodyEnteredSpotLights(body:PhysicsBody) -> void:
	if body:
		body.vel = (body.global_transform.origin - getRandomPosFromStartingFolder()).normalized() 
	pass

func getRandomPosFromStartingFolder() -> Vector3:
	return $startingPos.get_child( floor($startingPos.get_child_count() * randf())  ).global_transform.origin

func getRandomPosFromHinderFolder() -> Vector3:
	return $hinderPoss.get_child( floor($hinderPoss.get_child_count() * randf())  ).global_transform.origin

func getRandomPosFromPossFolder() -> Vector3:
	return $poss.get_child( floor($poss.get_child_count() * randf())  ).global_transform.origin

func getRandomVel() -> Vector3:
	var r : Vector3
	var ra := randf()
#	 so 1 difficulity means always true 
	if ra < GlobalSettings.difficulity:
		r = -(croc.global_transform.origin - getRandomPosFromPossFolder()).normalized()
	else:
		r = -(croc.global_transform.origin - getRandomPosFromHinderFolder()).normalized()
	return r

func crocTimerTimeOut() -> void:
	var randVel : Vector3 = getRandomVel() * rand_range(-5,20)
	randVel.y = 0
	croc.vel = randVel




func _on_boundary_body_entered(body: Node) -> void:
	if body:
		body.global_transform.origin = getRandomPosFromHinderFolder()


func _on_ohNoArea_body_entered(body: Node) -> void:
	if body:
		body.global_transform.origin = getRandomPosFromStartingFolder()
		$crocTimer.start(15)
		$CrawlingCroc.startClimbing()
		croc.vel = Vector3.ZERO
		print("time to crawlCroc")
		getClosestCrawlingFolder()
		GlobalSettings.difficulity = 0.0
