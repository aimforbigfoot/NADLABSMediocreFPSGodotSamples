extends Node2D

onready var levelNumLabel := $levelNumLabel
onready var loreTextBox := $loreTextBox

var sayingsArr := [
	"Another step closer to the center",
	"Does anyone read this text",
	"There are only 4 bosses and the game is over",
	"The rocket launcher doesn't damage you, but can damage enemies through walls",
	"Don't ask where the pistol's infinite ammo comes from",
	"The shotgun fires twenty bullets, but costs one ammo, you're lucky it's like that",
]



func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Global.levelNum += 1
	randomize()
#	so at difficulty 0 - easy, 50% chance of getting a powerup
#	33% chance of powerup at medium
#	25% chance of powerup at hard
	if randf() < 1/(Global.difficulty+2):
		$PowerUpBox.disabledTheButtons()
	levelNumLabel.text = ("Level "+str(Global.levelNum))
	loreTextBox.text = sayingsArr[ floor( randf()*sayingsArr.size()  )  ]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("m"):
		if Global.levelNum<Global.levelSelectorArr.size():
			get_tree().change_scene( Global.levelSelectorArr[Global.levelNum] )
		else:
			get_tree().change_scene("res://src/world/World.tscn")


func _on_PowerUpBox_anyBtnPressed() -> void:
	print("got press")
	get_tree().change_scene( Global.levelSelectorArr[Global.levelNum] )
