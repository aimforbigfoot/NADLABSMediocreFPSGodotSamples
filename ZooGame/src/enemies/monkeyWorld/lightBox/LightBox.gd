extends Spatial


signal smthClicked

func _ready() -> void:
	$monkeyButton.connect("smthClicked",self,"smthClicked")
	$monkeyButton2.connect("smthClicked",self,"smthClicked")
	$monkeyButton3.connect("smthClicked",self,"smthClicked")

func smthClicked(spot) -> void:
	emit_signal("smthClicked",spot)
