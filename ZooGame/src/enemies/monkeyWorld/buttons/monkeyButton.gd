extends Area
signal smthClicked
export var pos := "center"
var isBroken := false
var timesClicked := 0
export var spotLightName := "Lights"
var notClickedTexture := load("res://assets/materials/clickedYellowButton.tres")
var clickedTexture := load("res://assets/materials/NotClickedYellowButton.tres")
var breakNoises := [
	load("res://assets/sfx/glassBreak/break1.wav"),
	load("res://assets/sfx/glassBreak/break2.wav"),
	load("res://assets/sfx/glassBreak/break3.wav"),
]


var spotLightIFluctuate : Spatial

func _ready() -> void:
	spotLightIFluctuate = get_parent().get_parent().get_node("Lights").get_node(spotLightName)

func breakBulb() -> void:
	isBroken = true
	$breakBulb.stream = breakNoises[ floor( randf() * breakNoises.size() ) ]
	$breakBulb.play()
	spotLightIFluctuate.hide()
	$button.material_override = notClickedTexture
	GlobalSettings.addPower(10)


func click() -> void:
	if not isBroken:
		emit_signal("smthClicked",pos)
		timesClicked += 1
		if timesClicked > 6:
			breakBulb()
		else:
			if spotLightIFluctuate.visible:
				spotLightIFluctuate.hide()
				$button.material_override = notClickedTexture
				GlobalSettings.subPower(10)
			else:
				spotLightIFluctuate.show()
				GlobalSettings.addPower(10)
				$button.material_override = clickedTexture
	$pressed.play()


func _on_resetTimer_timeout() -> void:
	timesClicked = 0
	pass # Replace with function body.
