extends Node2D

signal selectedVersion

var posToShow := 0

var arrOfChoices : PoolStringArray = [
	"Fix",
	"this",
	"player not meant to see this",
]
var secondaryArr : PoolStringArray = [
	"",
	"",
	"",
]
var arrOfImages := [
	
]


func _ready() -> void:
	$left.connect("pressed",self,"left")
	$right.connect("pressed",self,"right")


func setText() -> void:
	$Main.text = arrOfChoices[posToShow]
	$Secondary.text = secondaryArr[posToShow]
	$TextureRect.texture = arrOfImages[posToShow]
	emit_signal("selectedVersion",[posToShow] )


func right() -> void:
	if posToShow < arrOfChoices.size()-1:
		posToShow += 1
	else:
		posToShow = 0
	setText() 

func left() -> void:
	if posToShow > 0:
		posToShow -= 1
	else:
		posToShow = arrOfChoices.size()-1
	setText() 


func setFromLastRun(pos) -> void:
	posToShow = Global.arrOfSettings[pos]
	pass
