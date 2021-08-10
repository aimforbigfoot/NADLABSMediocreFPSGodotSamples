extends Spatial

var middleInside := false
var leftInside := false
var rightInside := false
var clickedMat := load("res://assets/materials/clickedYellowButton.tres")
var notClickedMat := load("res://assets/materials/NotClickedYellowButton.tres")
var middleLight : SpotLight
var rightLight : SpotLight
var leftLight : SpotLight

func _ready() -> void:
	$Timer.connect("timeout",self,"turnOffAllLights")
	middleLight = get_parent().get_node("SpotLight")
	rightLight = get_parent().get_node("SpotLight3")
	leftLight = get_parent().get_node("SpotLight2")
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


func clicked() -> void:
	$Timer.start()
	middleLight.hide()
	leftLight.hide()
	rightLight.hide()
	if Input.is_action_just_pressed("click"):
		if middleInside:
			middleLight.visible = !middleLight.visible
			if middleLight.visible:
				get_node("buttonFacade/Sphere2").material_override= clickedMat
			else:
				get_node("buttonFacade/Sphere2").material_override = notClickedMat
		if leftInside:
			leftLight.visible = !leftLight.visible
			if leftLight.visible:
				get_node("buttonFacade/Sphere4").material_override= clickedMat
			else:
				get_node("buttonFacade/Sphere4").material_override = notClickedMat
		if rightInside:
			rightLight.visible = !rightLight.visible 
			
			if rightLight.visible:
				get_node("buttonFacade/Sphere").material_override= clickedMat
			else:
				get_node("buttonFacade/Sphere").material_override = notClickedMat
			
func turnOffAllLights() -> void:
	middleLight.hide()
	leftLight.hide()
	rightLight.hide()
