extends Node2D


func _ready() -> void:
	$level1.connect("pressed",self,"level1")
	$level2.connect("pressed",self,"level2")
	$challenge.connect("pressed",self,"challenge")
	


func setStuff(text:String,textCol:Color,col:Color) -> void:
	$title.text = text
	$title.modulate = textCol
	$ColorRect.color = col
	
