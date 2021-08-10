extends Spatial

var buttonFolder : Spatial

var middleInside := false
var leftInside := false
var rightInside := false
var notClickedMat := load("res://assets/materials/clickedYellowButton.tres")
var clickedMat := load("res://assets/materials/NotClickedYellowButton.tres")

func _ready() -> void:
	var closestPos : Spatial
	var closestDist : float = 10000000
	buttonFolder = get_parent().get_node("PlayerHub/buttonPositions")
	for button in buttonFolder.get_children():
		var currDist := global_transform.origin.distance_squared_to(button.global_transform.origin)
		print(currDist)
		if currDist < closestDist:
			closestDist = currDist
			closestPos = button
	$ButtonFolder.global_transform.origin = closestPos.global_transform.origin

	$ButtonFolder/middleButton.connect("area_entered",self,"middleButtonEnter")
	$ButtonFolder/leftButton.connect("area_entered",self,"leftButtonEnter")
	$ButtonFolder/rightButton.connect("area_entered",self,"rightButtonEnter")
	$ButtonFolder/middleButton.connect("area_exited",self,"middleButtonExit")
	$ButtonFolder/leftButton.connect("area_exited",self,"leftButtonExit")
	$ButtonFolder/rightButton.connect("area_exited",self,"rightButtonExit")
func middleButtonExit(area:Area)-> void:
	middleInside = false
func leftButtonExit(area:Area)-> void:
	leftInside = false
func rightButtonExit(area:Area)-> void:
	rightInside = false

func middleButtonEnter(area:Area)-> void:
	middleInside = true
func leftButtonEnter(area:Area)-> void:
	leftInside = true
func rightButtonEnter(area:Area)-> void:
	rightInside = true


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		if middleInside:
			$middleLight.visible = !$middleLight.visible 
			if $middleLight.visible:
				$ButtonFolder/middleButton/ButonMesh/Sphere.material_override = clickedMat
			else:
				$ButtonFolder/middleButton/ButonMesh/Sphere.material_override = notClickedMat
		if leftInside:
			$leftLight.visible = !$leftLight.visible
			if $leftLight.visible:
				$ButtonFolder/leftButton/ButonMesh/Sphere.material_override = clickedMat
			else:
				$ButtonFolder/leftButton/ButonMesh/Sphere.material_override = notClickedMat
		if rightInside:
			$rightLight.visible = !$rightLight.visible 
			if $rightLight.visible:
				$ButtonFolder/rightButton/ButonMesh/Sphere.material_override = clickedMat
			else:
				$ButtonFolder/rightButton/ButonMesh/Sphere.material_override = notClickedMat
		pass
