extends Node2D


func _ready() -> void:
	$OptionButton.add_item("a walk in the park (easy difficulty)",0)
	$OptionButton.add_item("bring it on (medium difficulty)",1)
	$OptionButton.add_item("oh no (insane difficulty)",2)
	$OptionButton.add_item("genuinely impossible",3)


func _on_OptionButton_item_selected(index: int) -> void:
	Global.difficulty = index


func _on_trialButton_pressed() -> void:
	Global.gameMode = "trial"
	get_tree().change_scene("res://src/world/World.tscn")

func _on_ininfiteButton_pressed() -> void:
	Global.gameMode = "infinite"
	get_tree().change_scene("res://src/world/World.tscn")


func _on_backButton_pressed() -> void:
	get_parent().go_back_from_start()


func _on_powerUpPressed_pressed() -> void:
	get_parent().from_gameScreen_to_powerup()
