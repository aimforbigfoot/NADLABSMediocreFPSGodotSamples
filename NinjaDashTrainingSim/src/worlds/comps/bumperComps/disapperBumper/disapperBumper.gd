extends "res://src/worlds/comps/bumperComps/baseBumper.gd"


func _ready() -> void:
	print("runs in the extension")
	isDisappear = true
	setColor(true)
